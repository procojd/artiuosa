import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:artiuosa/model/colormode.dart';
import 'package:artiuosa/model/savemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class controller extends GetxController {
  var selectedindex = 0.obs;
  var bottomsheet = false.obs;

  var strokeWidth = 0.3.obs;
  var diagonalLines = false.obs;
  var color = '0xFFFFFFFF'.obs;
  var lineDistance = 25.obs;
  var squareGrid = true.obs;
  var labels = false.obs;

  var selectedFile = Rx<File?>(null);
  var filteredFile = Rx<File?>(null);
  var imagewidth = Rx<double?>(null);
  var imageheight = Rx<double?>(null);
  var tempwidth = Rx<double?>(null);
  var tempheight = Rx<double?>(null);
  var paperHeight = 297.0.obs; // A4 paper height in mm
  var paperWidth = 210.0.obs;

  var onboarding_done = false.obs;

  // final String _imagePathKey = 'image_path';
  final String imageWidthKey = 'image_width';
  final String imageHeightKey = 'image_height';
  ui.Size? imageSize;

  @override
  void onInit() {
    super.onInit();
    loadPreferences();
  }

  ui.Color? tocolor(String hex) {
    return hex.toColor();
  }

  String tohex(ui.Color color) {
    return color.toHexString();
  }

  Future<void> onboarding() async {
    final prefs = await SharedPreferences.getInstance();
    onboarding_done.value = prefs.getBool('onboarding') ?? false;
  }

  Future<void> setonboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding', true);
  }

  Future<void> getfilteredfile() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedFilePath = prefs.getString('selectedFile');
    if (selectedFilePath != null) {
      selectedFile.value = File(selectedFilePath);
      print('selectedFile: ${selectedFile.value?.path}');
    } else {
      print('selectedFile: null');
    }
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the values, set default if null
    strokeWidth.value = prefs.getDouble('strokeWidth') ?? 1.0;
    print('strokeWidth: ${strokeWidth.value}');

    diagonalLines.value = prefs.getBool('diagonalLines') ?? false;
    print('diagonalLines: ${diagonalLines.value}');

    color.value = prefs.getString('color') ?? '0xFFFFFFFF';
    print('color: ${color.value}');

    lineDistance.value = prefs.getInt('lineDistance') ?? 25;
    print('lineDistance: ${lineDistance.value}');

    squareGrid.value = prefs.getBool('squareGrid') ?? true;
    labels.value = prefs.getBool('labels') ?? false;
    print('squareGrid: ${squareGrid.value}');

    paperHeight.value = prefs.getDouble('paperHeight') ?? 297.0;
    print('paperHeight: ${paperHeight.value}');

    paperWidth.value = prefs.getDouble('paperWidth') ?? 210.0;
    print('paperWidth: ${paperWidth.value}');

    // If imageWidth and imageHeight are not set, assign some default values
    imagewidth.value = prefs.getDouble('imageWidth') ?? 100.0; // default value
    print('imageWidth: ${imagewidth.value}');

    imageheight.value =
        prefs.getDouble('imageHeight') ?? 100.0; // default value
    print('imageHeight: ${imageheight.value}');

    // Handle files (You can adjust this part based on how you save/load files)
    final selectedFilePath = prefs.getString('selectedFile');
    if (selectedFilePath != null) {
      selectedFile.value = File(selectedFilePath);
      print('selectedFile: ${selectedFile.value?.path}');
    } else {
      print('selectedFile: null');
    }

    final filteredFilePath = prefs.getString('filteredFile');
    if (filteredFilePath != null) {
      filteredFile.value = File(filteredFilePath);
      print('filteredFile: ${filteredFile.value?.path}');
    } else {
      print('filteredFile: null');
    }
  }

  RxList<Color> selectedColors = [Colors.red, Colors.white].obs;
  RxList<PrismacolorPencil> availablePencils = [
    PrismacolorPencil(
      name: 'Red',
      code: 'PC923',
      hex: '#FF0000',
      rgb: [255, 0, 0],
    ),
    PrismacolorPencil(
      name: 'White',
      code: 'PC938',
      hex: '#FFFFFF',
      rgb: [255, 255, 255],
    ),
    // Add more pencils as needed
  ].obs;

  void addcm(PrismacolorPencil pencil) {
    if (availablePencils.length < 5) availablePencils.add(pencil);
  }

  void removecm(int index) {
    if (availablePencils.isNotEmpty &&
        index < availablePencils.length &&
        availablePencils.length > 2) {
      availablePencils.removeAt(index);
    }
  }

  // void removeColor(int index) {
  //   if (selectedColors.length > 2) {
  //     selectedColors.removeAt(index);
  //   }
  // }

  void onItemTap(int index) {
    selectedindex.value = index;

    // Close the drawer
  }

  // static const String _colorModelKey = 'colorModel';
  RxList colorModels = [].obs;

  Future<void> savecm(cm colorModel) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? colorModelsJson = prefs.getStringList('colorModels') ?? [];
    colorModelsJson.add(jsonEncode(colorModel.toJson()));
    await prefs.setStringList('colorModels', colorModelsJson);
  }

  Future<List<cm>?> getcm() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? colorModelsJson = prefs.getStringList('colorModels');
    if (colorModelsJson != null && colorModelsJson.isNotEmpty) {
      return colorModelsJson
          .map((colorModelJson) => cm.fromJson(jsonDecode(colorModelJson)))
          .toList();
    }
    return null;
  }

  Future<void> loadColorModels() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? colorModelStrings = prefs.getStringList('colorModels');
    if (colorModelStrings != null) {
      colorModels.value =
          colorModelStrings.map((str) => cm.fromMap(jsonDecode(str))).toList();
    }
  }

  Future<void> saveColorModels() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> colorModelStrings =
        colorModels.map((cm) => jsonEncode(cm.toMap())).toList();
    await prefs.setStringList('colorModels', colorModelStrings);
    await loadColorModels();
  }

  void deleteColorModel(cm colorModel) async {
    colorModels.remove(colorModel);

    await saveColorModels();
  }

  Future<void> storeStrokeWidth(double strokeWidth) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('strokeWidth', strokeWidth);
  }

  Future<void> storeDiagonalLines(bool diagonalLines) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('diagonalLines', diagonalLines);
  }

  Future<void> storeLabels(bool labels) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('labels', labels);
  }

  Future<void> storeOpacity(double opacity) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('opacity', opacity);
  }

  Future<void> storeColor(String color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('color', color);
  }

  Future<void> storeLineDistance(int lineDistance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lineDistance', lineDistance);
  }

  Future<void> storeGoldenRatio(bool goldenRatio) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('golden_ratio', goldenRatio);
  }

  Future<void> storefilteredfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (filteredFile.value != null) {
      prefs.setString('filteredFile', filteredFile.value!.path);
    }
  }

  Future<void> storeSquareGrid(bool squareGrid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('square_grid', squareGrid);
  }

  Future<double> getStrokeWidth({double defaultValue = 1.0}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('strokewidth') ?? defaultValue;
  }

  Future<bool> getDiagonalLines({bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('diagonalLines') ?? defaultValue;
  }

  // Future<bool> getLabels({bool defaultValue = false}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('labels') ?? defaultValue;
  // }

  // Future<double> getOpacity({double defaultValue = 1.0}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getDouble('opacity') ?? defaultValue;
  // }

  Future<int> getColor({int defaultValue = 0xFFFFFFFF}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('color') ?? defaultValue;
  }

  Future<double> getLineDistance({double defaultValue = 10.0}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('line_distance') ?? defaultValue;
  }

  Future<bool> getGoldenRatio({bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('golden_ratio') ?? defaultValue;
  }

  Future<bool> getSquareGrid({bool defaultValue = true}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('square_grid') ?? defaultValue;
  }

  CropAspectRatio getCropAspectRatio(String paperSize, String orientation) {
    switch (paperSize) {
      case 'A0':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 841, ratioY: 1189)
            : CropAspectRatio(ratioX: 1189, ratioY: 841);
      case 'A1':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 594, ratioY: 841)
            : CropAspectRatio(ratioX: 841, ratioY: 594);
      case 'A2':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 420, ratioY: 594)
            : CropAspectRatio(ratioX: 594, ratioY: 420);
      case 'A3':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 297, ratioY: 420)
            : CropAspectRatio(ratioX: 420, ratioY: 297);
      case 'A4':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 210, ratioY: 297)
            : CropAspectRatio(ratioX: 297, ratioY: 210);
      case 'A5':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 148, ratioY: 210)
            : CropAspectRatio(ratioX: 210, ratioY: 148);
      case 'custom':
        return CropAspectRatio(
            ratioX: tempwidth.value! * 10, ratioY: tempheight.value! * 10);
      default:
        return CropAspectRatio(ratioX: 1, ratioY: 1);
    }
  }
}

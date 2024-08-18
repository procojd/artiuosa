import 'dart:convert';

import 'package:artiuosa/model/colormode.dart';
import 'package:artiuosa/model/savemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class controller extends GetxController {
  var selectedindex = 0.obs;

  var strokeWidth = 1.0.obs;
  var diagonalLines = false.obs;
  var labels = false.obs;
  var opacity = 1.0.obs;
  var color = '0xFFFFFFFF'.obs;
  var lineDistance = 10.0.obs;
  var goldenRatio = false.obs;
  var squareGrid = false.obs;
  var bottomsheet = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    strokeWidth.value = prefs.getDouble('strokewidth') ?? 1.0;
    diagonalLines.value = prefs.getBool('diagonal_lines') ?? false;
    labels.value = prefs.getBool('labels') ?? false;
    opacity.value = prefs.getDouble('opacity') ?? 1.0;
    color.value = prefs.getString('color') ?? '0xFFFFFFFF';
    lineDistance.value = prefs.getDouble('line_distance') ?? 25.0;
    goldenRatio.value = prefs.getBool('golden_ratio') ?? false;
    squareGrid.value = prefs.getBool('square_grid') ?? true;
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
  // Save a cm to Shared Preferences
  // Future<void> savecm(cm colorModel) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String colorModelJson = jsonEncode(colorModel.toJson());
  //   print('///////////////////');
  //   print(colorModelJson);
  //   await prefs.setString(_colorModelKey, colorModelJson);
  // }

  // // Retrieve a cm from Shared Preferencesr
  // Future<cm?> getcm() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? colorModelJson = prefs.getString(_colorModelKey);
  //   if (colorModelJson != null) {
  //     Map<String, dynamic> colorModelMap = jsonDecode(colorModelJson);

  //     return cm.fromJson(colorModelMap);
  //   }
  //   return null;
  // }
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
    await prefs.setDouble('strokewidth', strokeWidth);
  }

  Future<void> storeDiagonalLines(bool diagonalLines) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('diagonal_lines', diagonalLines);
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

  Future<void> storeLineDistance(double lineDistance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('line_distance', lineDistance);
  }

  Future<void> storeGoldenRatio(bool goldenRatio) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('golden_ratio', goldenRatio);
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
    return prefs.getBool('diagonal_lines') ?? defaultValue;
  }

  Future<bool> getLabels({bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('labels') ?? defaultValue;
  }

  Future<double> getOpacity({double defaultValue = 1.0}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('opacity') ?? defaultValue;
  }

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
}

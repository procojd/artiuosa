import 'dart:convert';

import 'package:artiuosa/model/colormode.dart';
import 'package:artiuosa/model/savemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class controller extends GetxController {
  var selectedindex = 0.obs;
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

void addColorModel(PrismacolorPencil pencil) {
  availablePencils.add(pencil);
}

void removeColorModel(int index) {
  if (availablePencils.isNotEmpty && index < availablePencils.length) {
    availablePencils.removeAt(index);
  }
}

  void removeColor(int index) {
    if (selectedColors.length > 2) {
      selectedColors.removeAt(index);
    }
  }

  void onItemTap(int index) {
    selectedindex.value = index;

    // Close the drawer
  }

  static const String _colorModelKey = 'colorModel';

  // Save a cm to Shared Preferences
  Future<void> savecm(cm colorModel) async {
    final prefs = await SharedPreferences.getInstance();
    String colorModelJson = jsonEncode(colorModel.toJson());
    await prefs.setString(_colorModelKey, colorModelJson);
  }

  // Retrieve a cm from Shared Preferencesr
  Future<cm?> getcm() async {
    final prefs = await SharedPreferences.getInstance();
    String? colorModelJson = prefs.getString(_colorModelKey);
    if (colorModelJson != null) {
      Map<String, dynamic> colorModelMap = jsonDecode(colorModelJson);
      
      return cm.fromJson(colorModelMap);
    }
    return null;
  }
}

// lib/app/controllers/settings_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final GetStorage _box = GetStorage();
  
  // Theme settings
  final isDarkMode = false.obs;
  
  // App settings
  final keepScreenOn = false.obs;
  final vibrationEnabled = true.obs;
  final decimalPlaces = 4.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved settings
    isDarkMode.value = _box.read('isDarkMode') ?? false;
    keepScreenOn.value = _box.read('keepScreenOn') ?? false;
    vibrationEnabled.value = _box.read('vibrationEnabled') ?? true;
    decimalPlaces.value = _box.read('decimalPlaces') ?? 4;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    _box.write('isDarkMode', value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleKeepScreenOn(bool value) {
    keepScreenOn.value = value;
    _box.write('keepScreenOn', value);
  }

  void toggleVibration(bool value) {
    vibrationEnabled.value = value;
    _box.write('vibrationEnabled', value);
  }

  void updateDecimalPlaces(int value) {
    decimalPlaces.value = value;
    _box.write('decimalPlaces', value);
  }
}
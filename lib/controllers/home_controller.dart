// lib/controllers/home_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final GetStorage _box = GetStorage();

  final RxInt currentNavIndex = 0.obs;
  final isDarkMode = false.obs;
  final introDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Defer theme change to avoid build-time error
    Future.microtask(() => _initializeSettings());
  }

  @override
  void onReady() {
    super.onReady();
    // Delay intro check to avoid triggering rebuilds during build
    Future.delayed(Duration.zero, _showIntroIfNeeded);
  }

  void _initializeSettings() {
    isDarkMode.value = _box.read('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    introDone.value = _box.read('introDone') ?? false;
  }

  void _showIntroIfNeeded() {
    if (!introDone.value) {
      Future.delayed(500.milliseconds, () {
        showIntroTour();
        _box.write('introDone', true);
        introDone.value = true;
      });
    }
  }

  void changeNavIndex(int index) {
    if (currentNavIndex.value != index) {
      currentNavIndex.value = index;
    }
  }

  void toggleTheme() {
    isDarkMode.toggle();
    _box.write('isDarkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void showIntroTour() {
    Get.dialog(
      AlertDialog(
        title: Text('Welcome to Unit Converter Pro!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletPoint('Tap any category to start converting'),
            _buildBulletPoint('Use the swap button to reverse units'),
            _buildBulletPoint('View your history in the Recent tab'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(
              'Got it!',
              style: TextStyle(color: Get.theme.primaryColor),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•', style: Get.textTheme.bodyLarge),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: Get.textTheme.bodyLarge)),
        ],
      ),
    );
  }

  void resetIntro() {
    _box.write('introDone', false);
    introDone.value = false;
    showIntroTour();
  }
}

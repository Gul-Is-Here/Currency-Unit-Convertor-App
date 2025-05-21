// lib/app/views/settings_view.dart
import 'package:currency_convertor_app/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildThemeSetting(),
          Divider(),
          _buildDisplaySettings(),
          Divider(),
          _buildOtherSettings(),
        ],
      ),
    );
  }

  Widget _buildThemeSetting() {
    return Obx(
      () => SwitchListTile(
        activeColor: Colors.indigo,
        title: Text('Dark Mode'),
        value: controller.isDarkMode.value,
        onChanged: controller.toggleDarkMode,
        secondary: Icon(Icons.dark_mode, color: Colors.indigo),
      ),
    );
  }

  Widget _buildDisplaySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 8),
          child: Text(
            'Display',
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.indigo),
          ),
        ),
        Obx(
          () => Slider(
            activeColor: Colors.indigo,
            value: controller.decimalPlaces.value.toDouble(),
            min: 2,
            max: 8,
            divisions: 6,
            label: '${controller.decimalPlaces.value} decimal places',
            onChanged: (value) => controller.updateDecimalPlaces(value.toInt()),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Number of decimal places to show in results',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 8),
          child: Text(
            'Other Settings',
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.indigo),
          ),
        ),
        Obx(
          () => SwitchListTile(
            activeColor: Colors.indigo,
            title: Text('Keep screen on'),
            value: controller.keepScreenOn.value,
            onChanged: controller.toggleKeepScreenOn,
            secondary: Icon(Icons.stay_primary_portrait, color: Colors.indigo),
          ),
        ),
      ],
    );
  }
}

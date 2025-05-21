// lib/app/bindings/app_bindings.dart
import 'package:currency_convertor_app/controllers/setting_controller.dart';
import 'package:get/get.dart';

import 'package:currency_convertor_app/controllers/currency_controller.dart';
import 'package:currency_convertor_app/controllers/home_controller.dart';
import 'package:currency_convertor_app/controllers/length_controller.dart';
import 'package:currency_convertor_app/controllers/mass_controller.dart';
import 'package:currency_convertor_app/controllers/recent_controller.dart';
import 'package:currency_convertor_app/controllers/volume_controller.dart';
import 'package:currency_convertor_app/database/database_helper.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() async {
    // Initialize and register DatabaseHelper
    final dbHelper = await DatabaseHelper().init();
    Get.put<DatabaseHelper>(dbHelper);

    // Register other controllers
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LengthController());
    Get.lazyPut(() => MassController());
    Get.lazyPut(() => VolumeController());
    Get.lazyPut(() => CurrencyController());
    Get.lazyPut(() => RecentController());
  }
}

// Individual Bindings
class HomeBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => HomeController());
}

class LengthBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => LengthController());
}

class MassBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => MassController());
}

class VolumeBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => VolumeController());
}

class CurrencyBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CurrencyController());
}

class RecentBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => RecentController());
}

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
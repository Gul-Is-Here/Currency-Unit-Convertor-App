// lib/app/routes/app_pages.dart
import 'package:currency_convertor_app/splasScreen.dart';
import 'package:currency_convertor_app/views/setting_vew.dart';
import 'package:get/get.dart';
import 'package:currency_convertor_app/bindings/app_bindings.dart';
import 'package:currency_convertor_app/bindings/app_route.dart';
import 'package:currency_convertor_app/views/cuurencyVIew.dart';

import 'package:currency_convertor_app/views/home_view.dart';
import 'package:currency_convertor_app/views/length_view.dart';
import 'package:currency_convertor_app/views/mass_view.dart';
import 'package:currency_convertor_app/views/recent_view.dart';
import 'package:currency_convertor_app/views/volume_screen.dart';

class AppPages {
  AppPages._();

  static const INITIAL = AppRoutes.INITIAL;

  static final routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => SplashScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.LENGTH,
      page: () => LengthView(),
      binding: LengthBinding(),
    ),
    GetPage(
      name: AppRoutes.MASS,
      page: () => MassView(),
      binding: MassBinding(),
    ),
    GetPage(
      name: AppRoutes.VOLUME,
      page: () => VolumeView(),
      binding: VolumeBinding(),
    ),
    GetPage(
      name: AppRoutes.CURRENCY,
      page: () => CurrencyView(),
      binding: CurrencyBinding(),
    ),
    GetPage(
      name: AppRoutes.RECENT,
      page: () => RecentView(),
      binding: RecentBinding(),
    ),
    // lib/app/routes/app_pages.dart
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}

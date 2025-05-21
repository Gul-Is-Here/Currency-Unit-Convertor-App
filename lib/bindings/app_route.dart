// lib/app/routes/app_routes.dart
abstract class AppRoutes {
  static const INITIAL = '/splash';
  static const String HOME = '/home';
  static const String LENGTH = '/length';
  static const String MASS = '/mass';
  static const String VOLUME = '/volume';
  static const String CURRENCY = '/currency';
  static const String RECENT = '/recent';
  static const String FAVORITES = '/favorites';
  static const String SETTINGS = '/settings';

  // ✅ Missing route added:
  static const String CURRENCY_RATE_EDITOR = '/currency/rate-editor';
}

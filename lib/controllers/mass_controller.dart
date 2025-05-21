// app/modules/mass/mass_controller.dart
import 'package:get/get.dart';

import 'package:currency_convertor_app/database/database_helper.dart';

class MassController extends GetxController {
  final DatabaseHelper _database = Get.find();

  var fromValue = 0.0.obs;
  var toValue = 0.0.obs;
  var fromUnit = 'Grams'.obs;
  var toUnit = 'Kilograms'.obs;

  final List<String> units = [
    'Milligrams',
    'Grams',
    'Kilograms',
    'Metric Tons',
    'Ounces',
    'Pounds',
    'Stones',
  ];

  void convert() {
    double gramValue = _toGrams(fromValue.value, fromUnit.value);
    toValue.value = _fromGrams(gramValue, toUnit.value);
    
    _database.insertConversion({
      'category': 'mass',
      'fromValue': fromValue.value,
      'fromUnit': fromUnit.value,
      'toValue': toValue.value,
      'toUnit': toUnit.value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  void swapUnits() {
    final temp = fromUnit.value;
    fromUnit.value = toUnit.value;
    toUnit.value = temp;
    convert();
  }

  double _toGrams(double value, String unit) {
    switch (unit) {
      case 'Milligrams': return value / 1000;
      case 'Grams': return value;
      case 'Kilograms': return value * 1000;
      case 'Metric Tons': return value * 1000000;
      case 'Ounces': return value * 28.3495;
      case 'Pounds': return value * 453.592;
      case 'Stones': return value * 6350.29;
      default: return value;
    }
  }

  double _fromGrams(double value, String unit) {
    switch (unit) {
      case 'Milligrams': return value * 1000;
      case 'Grams': return value;
      case 'Kilograms': return value / 1000;
      case 'Metric Tons': return value / 1000000;
      case 'Ounces': return value / 28.3495;
      case 'Pounds': return value / 453.592;
      case 'Stones': return value / 6350.29;
      default: return value;
    }
  }
}
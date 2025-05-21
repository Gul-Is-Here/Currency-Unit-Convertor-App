// app/modules/volume/volume_controller.dart
import 'package:get/get.dart';
import 'package:currency_convertor_app/database/database_helper.dart';


class VolumeController extends GetxController {
  final DatabaseHelper _database = Get.find();

  var fromValue = 0.0.obs;
  var toValue = 0.0.obs;
  var fromUnit = 'Milliliters'.obs;
  var toUnit = 'Liters'.obs;

  final List<String> units = [
    'Milliliters',
    'Liters',
    'Cubic Meters',
    'Cubic Centimeters',
    'Cubic Inches',
    'Cubic Feet',
    'Gallons (US)',
    'Gallons (UK)',
    'Fluid Ounces (US)',
    'Fluid Ounces (UK)',
  ];

  void convert() {
    double literValue = _toLiters(fromValue.value, fromUnit.value);
    toValue.value = _fromLiters(literValue, toUnit.value);
    
    _database.insertConversion({
      'category': 'volume',
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

  double _toLiters(double value, String unit) {
    switch (unit) {
      case 'Milliliters': return value / 1000;
      case 'Liters': return value;
      case 'Cubic Meters': return value * 1000;
      case 'Cubic Centimeters': return value / 1000;
      case 'Cubic Inches': return value * 0.0163871;
      case 'Cubic Feet': return value * 28.3168;
      case 'Gallons (US)': return value * 3.78541;
      case 'Gallons (UK)': return value * 4.54609;
      case 'Fluid Ounces (US)': return value * 0.0295735;
      case 'Fluid Ounces (UK)': return value * 0.0284131;
      default: return value;
    }
  }

  double _fromLiters(double value, String unit) {
    switch (unit) {
      case 'Milliliters': return value * 1000;
      case 'Liters': return value;
      case 'Cubic Meters': return value / 1000;
      case 'Cubic Centimeters': return value * 1000;
      case 'Cubic Inches': return value / 0.0163871;
      case 'Cubic Feet': return value / 28.3168;
      case 'Gallons (US)': return value / 3.78541;
      case 'Gallons (UK)': return value / 4.54609;
      case 'Fluid Ounces (US)': return value / 0.0295735;
      case 'Fluid Ounces (UK)': return value / 0.0284131;
      default: return value;
    }
  }
}
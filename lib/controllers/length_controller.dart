// app/modules/length/length_controller.dart
import 'package:get/get.dart';
import 'package:currency_convertor_app/database/database_helper.dart';

class LengthController extends GetxController {
  final DatabaseHelper _database = Get.find();

  var fromValue = 0.0.obs;
  var toValue = 0.0.obs;
  var fromUnit = 'Meters'.obs;
  var toUnit = 'Kilometers'.obs;

  final List<String> units = [
    'Millimeters',
    'Centimeters',
    'Meters',
    'Kilometers',
    'Inches',
    'Feet',
    'Yards',
    'Miles',
  ];

  void convert() {
    double meterValue = _toMeters(fromValue.value, fromUnit.value);
    toValue.value = _fromMeters(meterValue, toUnit.value);
    
    // Save to history
    _database.insertConversion({
      'category': 'length',
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

  double _toMeters(double value, String unit) {
    switch (unit) {
      case 'Millimeters': return value / 1000;
      case 'Centimeters': return value / 100;
      case 'Meters': return value;
      case 'Kilometers': return value * 1000;
      case 'Inches': return value * 0.0254;
      case 'Feet': return value * 0.3048;
      case 'Yards': return value * 0.9144;
      case 'Miles': return value * 1609.344;
      default: return value;
    }
  }

  double _fromMeters(double value, String unit) {
    switch (unit) {
      case 'Millimeters': return value * 1000;
      case 'Centimeters': return value * 100;
      case 'Meters': return value;
      case 'Kilometers': return value / 1000;
      case 'Inches': return value / 0.0254;
      case 'Feet': return value / 0.3048;
      case 'Yards': return value / 0.9144;
      case 'Miles': return value / 1609.344;
      default: return value;
    }
  }
}
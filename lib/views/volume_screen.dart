// lib/views/volume_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_convertor_app/controllers/volume_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class VolumeView extends StatelessWidget {
  final VolumeController controller =
      Get.find<VolumeController>(); // ✅ Manual injection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Volume Converter'),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz, color: Colors.white),
            onPressed: controller.swapUnits,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConversionCard(),
            SizedBox(height: 20),
            _buildUnitDropdowns(),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'From'),
              onChanged: (value) {
                controller.fromValue.value = double.tryParse(value) ?? 0.0;
                controller.convert();
              },
            ),
            SizedBox(height: 16),
            Obx(
              () => Text(
                controller.toValue.value.toStringAsFixed(4),
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitDropdowns() {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => DropdownButtonFormField<String>(
              value: controller.fromUnit.value,
              items:
                  controller.units
                      .map(
                        (unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(
                            unit,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                controller.fromUnit.value = value!;
                controller.convert();
              },
              decoration: InputDecoration(labelText: 'From Unit'),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Obx(
            () => DropdownButtonFormField<String>(
              value: controller.toUnit.value,
              items:
                  controller.units
                      .map(
                        (unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(
                            unit,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                controller.toUnit.value = value!;
                controller.convert();
              },
              decoration: InputDecoration(labelText: 'To Unit'),
            ),
          ),
        ),
      ],
    );
  }
}

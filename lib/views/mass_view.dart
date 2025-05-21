import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currency_convertor_app/controllers/mass_controller.dart';

class MassView extends StatelessWidget {
  final MassController controller = Get.find<MassController>();

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
        title: Text(
          'Mass Converter',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz, color: Colors.white),
            onPressed: controller.swapUnits,
            tooltip: 'Swap Units',
          ),
        ],
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildConversionCard(context),
            const SizedBox(height: 24),
            _buildUnitDropdowns(context),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(Icons.scale, size: 40, color: Colors.indigo),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Enter mass',
              labelStyle: GoogleFonts.poppins(),
              prefixIcon: Icon(Icons.line_weight),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onChanged: (value) {
              controller.fromValue.value = double.tryParse(value) ?? 0.0;
              controller.convert();
            },
          ),
          const SizedBox(height: 20),
          Obx(
            () => Text(
              controller.toValue.value.toStringAsFixed(4),
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitDropdowns(BuildContext context) {
    final borderRadius = BorderRadius.circular(14);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose Units", style: GoogleFonts.poppins(fontSize: 16)),
        const SizedBox(height: 12),
        Row(
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
                  decoration: InputDecoration(
                    labelText: 'From',
                    labelStyle: GoogleFonts.poppins(),
                    prefixIcon: Icon(Icons.arrow_upward, size: 15),
                    border: OutlineInputBorder(borderRadius: borderRadius),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
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
                  decoration: InputDecoration(
                    labelText: 'To',
                    labelStyle: GoogleFonts.poppins(),
                    prefixIcon: Icon(Icons.arrow_downward, size: 15),
                    border: OutlineInputBorder(borderRadius: borderRadius),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:currency_convertor_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:currency_convertor_app/bindings/app_route.dart';
import 'package:currency_convertor_app/controllers/currency_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyView extends StatelessWidget {
  final CurrencyController controller = Get.find<CurrencyController>();
  final HomeController homeController = Get.find<HomeController>();
  CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          'Currency Converter',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz, color: Colors.white),
            onPressed: controller.swapCurrencies,
            tooltip: 'Swap Currencies',
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () => Get.toNamed(AppRoutes.CURRENCY_RATE_EDITOR),
            tooltip: 'Edit Rates',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildConversionCard(context),
            const SizedBox(height: 24),
            _buildCurrencyDropdowns(context),
            const SizedBox(height: 30),
            _buildLastUpdatedText(),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white12 : Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(Icons.currency_exchange_rounded, size: 48, color: Colors.indigo),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Enter Amount',
              labelStyle: GoogleFonts.poppins(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              prefixIcon: Icon(Icons.attach_money_rounded),
            ),
            onChanged: (value) {
              controller.fromValue.value = double.tryParse(value) ?? 0.0;
              controller.convert();
            },
          ),
          const SizedBox(height: 30),
          Obx(
            () => Text(
              controller.toValue.value.toStringAsFixed(4),
              style: GoogleFonts.poppins(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyDropdowns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose Currencies", style: GoogleFonts.poppins(fontSize: 16)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.fromCurrency.value,
                  items:
                      controller.currencies
                          .map(
                            (currency) => DropdownMenuItem(
                              value: currency,
                              child: Text(
                                currency,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    controller.fromCurrency.value = value!;
                    controller.convert();
                  },
                  decoration: InputDecoration(
                    labelText: 'From',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.arrow_upward_rounded),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.toCurrency.value,
                  items:
                      controller.currencies
                          .map(
                            (currency) => DropdownMenuItem(
                              value: currency,
                              child: Text(
                                currency,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    controller.toCurrency.value = value!;
                    controller.convert();
                  },
                  decoration: InputDecoration(
                    labelText: 'To',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.arrow_downward_rounded),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLastUpdatedText() {
    return Obx(() {
      final updated = controller.lastUpdated.value;
      return updated == null
          ? SizedBox()
          : Center(
            child: Text(
              'Last updated: ${DateFormat('MMM d, y - h:mm a').format(updated)}',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          );
    });
  }
}

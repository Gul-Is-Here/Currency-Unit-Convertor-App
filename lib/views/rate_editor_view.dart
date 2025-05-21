// lib/modules/currency/rate_editor_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_convertor_app/controllers/currency_controller.dart';

class RateEditorView extends StatelessWidget {
  final CurrencyController controller = Get.find<CurrencyController>(); // ✅ Manual injection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Currency Rates'),
      ),
      body: ListView.builder(
        itemCount: controller.currencies.length,
        itemBuilder: (context, index) {
          final currency = controller.currencies[index];
          if (currency == 'USD') return SizedBox();

          return Obx(() {
            final rate = controller.defaultRates[currency] ?? 1.0;
            return ListTile(
              title: Text('1 USD = $rate $currency'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _showEditDialog(currency, rate),
              ),
            );
          });
        },
      ),
    );
  }

  void _showEditDialog(String currency, double currentRate) {
    final textController = TextEditingController(
      text: currentRate.toStringAsFixed(4),
    );

    Get.dialog(
      AlertDialog(
        title: Text('Edit $currency Rate'),
        content: TextField(
          controller: textController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: '1 USD = ? $currency',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newRate =
                  double.tryParse(textController.text) ?? currentRate;
              controller.updateRate(currency, newRate);
              Get.back();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

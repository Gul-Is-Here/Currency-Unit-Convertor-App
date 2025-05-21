import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:currency_convertor_app/controllers/recent_controller.dart';

class RecentView extends StatelessWidget {
  final RecentController controller = Get.find<RecentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent Conversions',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: Obx(
        () =>
            controller.recentConversions.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.recentConversions.length,
                  itemBuilder: (context, index) {
                    final conversion = controller.recentConversions[index];
                    return _buildConversionCard(context, conversion);
                  },
                ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No recent conversions yet.',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Theme.of(
            context,
          ).textTheme.bodyMedium?.color?.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildConversionCard(
    BuildContext context,
    Map<String, dynamic> conversion,
  ) {
    final date = DateTime.fromMillisecondsSinceEpoch(conversion['timestamp']);
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    final color = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Text(
          '${conversion['fromValue']} ${conversion['fromUnit']} → ${conversion['toValue']} ${conversion['toUnit']}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6),
            Text(
              conversion['category'].toString().toUpperCase(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: color,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 4),
            Text(
              formattedDate,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(Icons.cached, color: color),
        ),
      ),
    );
  }
}

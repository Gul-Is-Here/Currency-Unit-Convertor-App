// app/modules/recent/recent_controller.dart
import 'package:get/get.dart';

import 'package:currency_convertor_app/database/database_helper.dart';

class RecentController extends GetxController {
  final DatabaseHelper _database = Get.find();

  var recentConversions = <Map<String, dynamic>>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadRecentConversions();
  }

  Future<void> loadRecentConversions() async {
    final length = await _database.getRecentConversions('length');
    final mass = await _database.getRecentConversions('mass');
    final volume = await _database.getRecentConversions('volume');
    final currency = await _database.getRecentConversions('currency');
    
    recentConversions.assignAll([...length, ...mass, ...volume, ...currency]);
    recentConversions.sort((a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));
  }
}
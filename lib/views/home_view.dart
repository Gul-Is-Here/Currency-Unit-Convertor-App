import 'package:currency_convertor_app/views/setting_vew.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_convertor_app/bindings/app_route.dart';
import 'package:currency_convertor_app/controllers/home_controller.dart';
import 'package:currency_convertor_app/views/recent_view.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.history, size: 30),
    Icon(Icons.settings, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Obx(() => _buildCurrentScreen()),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          index: controller.currentNavIndex.value,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Colors.indigo,
          buttonBackgroundColor: Colors.indigo,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          items: items,
          onTap: controller.changeNavIndex,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Unit/Currency Converter Pro',
        style: GoogleFonts.poppins(fontSize: 20),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.history, color: Colors.white),
          onPressed: () => Get.toNamed(AppRoutes.RECENT),
        ),
        Obx(() {
          return IconButton(
            icon: Icon(
              controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: controller.toggleTheme,
          );
        }),
      ],
    );
  }

  Widget _buildCurrentScreen() {
    switch (controller.currentNavIndex.value) {
      case 0:
        return _buildConversionGrid();
      case 1:
        return RecentView();
      default:
        return SettingsView();
    }
  }

  Widget _buildConversionGrid() {
    return GridView.count(
      padding: EdgeInsets.all(20),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1,
      children: [
        _buildCategoryTile(
          'Length',
          Icons.straighten,
          Colors.blueAccent,
          AppRoutes.LENGTH,
        ),
        _buildCategoryTile('Mass', Icons.scale, Colors.green, AppRoutes.MASS),
        _buildCategoryTile(
          'Volume',
          Icons.water_drop,
          Colors.orange,
          AppRoutes.VOLUME,
        ),
        _buildCategoryTile(
          'Currency',
          Icons.currency_exchange,
          Colors.deepPurple,
          AppRoutes.CURRENCY,
        ),
      ],
    );
  }

  Widget _buildCategoryTile(
    String title,
    IconData icon,
    Color color,
    String route,
  ) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        shadowColor: color.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, size: 28, color: color),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

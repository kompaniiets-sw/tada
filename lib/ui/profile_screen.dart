import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tada/common/widgets/appbar/header_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _toggleTheme() {
    final isDark = Get.isDarkMode;
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppbar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Get.isDarkMode ? Iconsax.sun_1 : Iconsax.moon),
              onPressed: _toggleTheme,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Профіль'),
      ),
    );
  }
}

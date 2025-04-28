import 'package:tada/helpers/network_manager.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tada/navigation_menu.dart';

class ThemeController extends GetxController {
  final isDarkMode = false.obs;

  // void toggleTheme() {
  //   isDarkMode.value = !isDarkMode.value;
  //   Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  // }
}

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ENetworkManager());
    Get.put(ThemeController());
    Get.put(NavigationController());
  }
}

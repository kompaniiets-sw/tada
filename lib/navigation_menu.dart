import 'package:tada/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tada/ui/profile_screen.dart';
import 'package:tada/ui/tasks_screen.dart';
import 'package:tada/common/bindings/general_bindings.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final themeController = Get.find<ThemeController>();
    final bool darkMode = themeController.isDarkMode.value;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          indicatorColor: darkMode ? Colors.white.withAlpha(26) : Colors.black.withAlpha(26),
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.timer_1), label: 'Pomodoro',),
            NavigationDestination(icon: Icon(Iconsax.task), label: 'Tasks'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            controller.screens[controller.selectedIndex.value],
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const TasksScreen(),
    const ProfileScreen(),
  ];
}
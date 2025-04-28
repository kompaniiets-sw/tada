import 'package:tada/features/profile/screens/profile_screen.dart';
import 'package:tada/features/tasks/screens/tasks_screen.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:tada/features/pomodoro/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tada/common/bindings/general_bindings.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:tada/utils/constants/colors.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final controller = Get.put(NavigationController());
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController?.animation?.addListener(() {
      final value = tabController?.animation?.value.round() ?? 0;
      if (value != controller.selectedIndex.value && mounted) {
        controller.selectedIndex.value = value;
      }
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final bool darkMode = EHelperFunctions.isDarkMode(context);
    final Color unselectedColor = darkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: darkMode ? EColors.dark : EColors.light,
      body: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        clipBehavior: Clip.none,
        child: BottomBar(
          fit: StackFit.expand,
          icon:
              (width, height) => Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_upward_rounded,
                    color: unselectedColor,
                    size: width,
                  ),
                ),
              ),
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(seconds: 1),
          curve: Curves.decelerate,
          barDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            boxShadow: [],
            border: Border.all(color: Colors.transparent),
          ),
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: darkMode ? Colors.black : Colors.white,
          start: 2,
          end: 0,
          offset: 0,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 35,
          iconWidth: 35,

          reverse: false,
          hideOnScroll: true,
          scrollOpposite: false,
          respectSafeArea: true,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body:
              (context, controller) => TabBarView(
                controller: tabController!,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const HomeScreen(),
                  const TasksScreen(),
                  const ProfileScreen(),
                ],
              ),
          child: Material(
            elevation: 0,
            color: darkMode ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(500),
            child: TabBar(
              controller: tabController!,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: darkMode ? Colors.white : Colors.black,
              indicatorWeight: 3,
              indicatorPadding: const EdgeInsets.only(bottom: 5),
              labelColor: darkMode ? Colors.white : Colors.black,
              unselectedLabelColor: unselectedColor.withOpacity(0.5),
              tabs: [
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                    child: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Icon(
                        Iconsax.timer_1,
                        color:
                            controller.selectedIndex.value == 0
                                ? (darkMode ? Colors.white : Colors.black)
                                : unselectedColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                    child: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Icon(
                        Iconsax.task,
                        color:
                            controller.selectedIndex.value == 1
                                ? (darkMode ? Colors.white : Colors.black)
                                : unselectedColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                    child: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Icon(
                        Iconsax.user,
                        color:
                            controller.selectedIndex.value == 2
                                ? (darkMode ? Colors.white : Colors.black)
                                : unselectedColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

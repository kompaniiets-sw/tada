import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tada/helpers/helper_functions.dart';

import 'package:tada/ui/components/pomodoro/pomodoro_timer.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? EColors.night : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pomodoro'),
        backgroundColor: dark 
        ? EColors.night
        : Colors.white,
        foregroundColor: dark ? Colors.white : EColors.night,
        elevation: 0, // Робить заголовок більш "чистим"
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: ESizes.defaultSpace),
            child: IconButton(
              icon: const Icon(Iconsax.setting_4),
              onPressed: () {
                // Додайте тут функціонал для кнопки налаштувань
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: PomodoroTimer()),
          
          ]),
    );
  }
}

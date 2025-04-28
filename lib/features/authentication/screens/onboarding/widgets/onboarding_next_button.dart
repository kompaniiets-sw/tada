import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tada/features/authentication/screens/onboarding/controllers/onboarding_controller.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/utils/constants/sizes.dart';
import 'package:tada/utils/device/device_utility.dart';
import 'package:tada/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;

    return Positioned(
      right: ESizes.defaultSpace,
      bottom: ESizes.defaultSpace,
      left: ESizes.defaultSize,
      height: ESizes.defaultSizeBig,
      child: ElevatedButton(
        onPressed: () => controller.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: dark ? EColors.accent : EColors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Obx(
          () =>
              controller.currentPageIndex.value == 2
                  ? const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                  : const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        ),
      ),
    );
  }
}

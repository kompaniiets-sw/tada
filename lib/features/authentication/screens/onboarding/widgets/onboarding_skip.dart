import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada/utils/constants/sizes.dart';
import 'package:tada/utils/device/device_utility.dart';
import 'package:tada/features/authentication/screens/onboarding/controllers/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      top: EDeviceUtils.getAppBarHeight(),
      right: ESizes.defaultSpace,
      child: TextButton(
        onPressed: () => controller.skipPage(),
        child: const Text('Пропустити'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada/utils/constants/image_strings.dart';
import 'package:tada/utils/constants/text_strings.dart';

import 'package:tada/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:tada/features/authentication/screens/onboarding/widgets/onboarding_page.dart';

import 'package:tada/features/authentication/screens/onboarding/controllers/onboarding_controller.dart';

/// Onboarding screen
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          /// Горизонтальні сторінки з прокручуванням
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: EImages.onboarding1,
                title: ETexts.onBoardingTitle1,
                subTitle: ETexts.onBoardingSubTitle1,
              ),

              OnBoardingPage(
                image: EImages.onboarding2,
                title: ETexts.onBoardingTitle2,
                subTitle: ETexts.onBoardingSubTitle2,
              ),

              OnBoardingPage(
                image: EImages.onboarding3,
                title: ETexts.onBoardingTitle3,
                subTitle: ETexts.onBoardingSubTitle3,
              ),
            ],
          ),

          /// Кнопка пропуску
          //const OnBoardingSkip(),

          /// Кнопка вперед
          //const OnBoardingDotNavigation(),

          /// Кругла кнопка
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

import 'package:tada/common/styles/spacing_styles.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:tada/utils/constants/sizes.dart';
import 'package:tada/utils/constants/text_strings.dart';

import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});

  final  String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight*2,
          child: Column(
            children: [
              /// Image
              Image(image:  AssetImage(image), width: EHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: ESizes.spaceBtwSections),
            
              /// Title & Subtitle
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: ESizes.spaceBtwItems),

              Text(subtitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
               const SizedBox(height: ESizes.spaceBtwSections),

               /// Buttons
               SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(ETexts.tContinue),
                )
               ),
    ],
          ),
        ),
      ),
    );
  }
}

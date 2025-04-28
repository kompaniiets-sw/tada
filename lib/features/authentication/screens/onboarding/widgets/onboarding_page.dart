import 'package:flutter/material.dart';
import 'package:tada/helpers/helper_functions.dart';
import '../../../../../../utils/constants/sizes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Column(
            children: [
              Image.asset(
                image,
                width: EHelperFunctions.screenWidth() * 0.8,
                height: EHelperFunctions.screenHeight() * 0.6,
                errorBuilder: (context, error, stackTrace) {
                  print('Помилка завантаження зображення: $error');
                  print('Шлях до зображення: $image');
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 50,
                        ),
                        const SizedBox(height: 16),
                        Text('Помилка завантаження зображення: $image'),
                      ],
                    ),
                  );
                },
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ESizes.spaceBtwInputFields),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ESizes.spaceBtwInputFields),
            ],
          ),
        ],
      ),
    );
  }
}

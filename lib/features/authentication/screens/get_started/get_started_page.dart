import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';
import 'package:tada/features/authentication/screens/onboarding/onboarding.dart';
import 'package:tada/features/authentication/screens/login/login_screen.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to TADA',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              FButton(
                onPress: () => Get.to(() => const OnboardingScreen()),
                label: const Text('Get Started'),
              ),
              const SizedBox(height: 16),
              FButton(
                onPress: () => Get.to(() => const LoginScreen()),
                label: const Text('Login'),
                style: FButtonStyle.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

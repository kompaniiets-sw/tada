import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tada/common/widgets/pages/app_loading_page.dart';
import 'package:tada/features/authentication/screens/onboarding/onboarding.dart';
import 'package:tada/features/authentication/services/auth_service.dart';
import 'package:tada/navigation_menu.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});

  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, AuthService, child) {
        return StreamBuilder(
          stream: AuthService.authStateChanges,
          builder: (context, snaphot) {
            Widget widget;
            if (snaphot.connectionState == ConnectionState.waiting) {
              widget = AppLoadingPage();
            } else if (snaphot.hasData) {
              widget = const NavigationMenu();
            } else {
              widget = pageIfNotConnected ?? const OnboardingScreen();
            }
            return widget;
          },
        );
      },
    );
  }
}

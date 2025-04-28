import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tada/common/widgets/appbar/header_appbar.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/features/authentication/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _toggleTheme() {
    final isDark = Get.isDarkMode;
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  void _signOut() async {
    try {
      await authService.value.signOut();
    } catch (e) {
      Get.snackbar(
        'Помилка',
        'Не вдалося вийти з акаунту',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: HeaderAppbar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Get.isDarkMode ? Iconsax.sun_1 : Iconsax.moon),
              onPressed: _toggleTheme,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: dark ? EColors.dark : EColors.light,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: dark ? EColors.light : EColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  user?.displayName ?? 'Користувач',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dark ? EColors.light : EColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  user?.email ?? 'Немає email',
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        dark
                            ? EColors.light.withOpacity(0.7)
                            : EColors.dark.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ListTile(
                leading: Icon(
                  Icons.email_outlined,
                  color: dark ? EColors.light : EColors.dark,
                ),
                title: Text(
                  'Email',
                  style: TextStyle(color: dark ? EColors.light : EColors.dark),
                ),
                subtitle: Text(
                  user?.email ?? 'Немає email',
                  style: TextStyle(
                    color:
                        dark
                            ? EColors.light.withOpacity(0.7)
                            : EColors.dark.withOpacity(0.7),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.verified_user_outlined,
                  color: dark ? EColors.light : EColors.dark,
                ),
                title: Text(
                  'Статус верифікації',
                  style: TextStyle(color: dark ? EColors.light : EColors.dark),
                ),
                subtitle: Text(
                  user?.emailVerified == true
                      ? 'Верифіковано'
                      : 'Не верифіковано',
                  style: TextStyle(
                    color:
                        dark
                            ? EColors.light.withOpacity(0.7)
                            : EColors.dark.withOpacity(0.7),
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _signOut,
                  icon: const Icon(Icons.logout),
                  label: const Text('Вийти з акаунту'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

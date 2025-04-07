import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:tada/common/bindings/general_bindings.dart';
import 'package:flutter/material.dart';
import 'package:tada/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:tada/theme/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: EAppTheme.lightTheme,
      darkTheme: EAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
        debugShowCheckedModeBanner: false,
        title: 'TADA',

        home: const NavigationMenu(),
    );
  }
}




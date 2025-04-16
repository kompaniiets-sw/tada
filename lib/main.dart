import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:tada/common/bindings/general_bindings.dart';
import 'package:tada/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:tada/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _brightness == Brightness.dark;

    return FTheme(
      data: isDark ? FThemes.zinc.dark : FThemes.zinc.light,
      child: GetMaterialApp(
        theme: isDark ? AppTheme.dark : AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        initialBinding: GeneralBindings(),
        debugShowCheckedModeBanner: false,
        title: 'TADA',
        home: const NavigationMenu(),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:tada/common/bindings/general_bindings.dart';
import 'package:tada/features/authentication/services/auth_layout.dart';
import 'package:tada/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:tada/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:tada/features/authentication/screens/get_started/get_started_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      _brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
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
        home: const AuthLayout(pageIfNotConnected: GetStartedPage()),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

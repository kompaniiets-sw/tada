import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:tada/theme/custom_themes/switch_theme.dart';

class AppTheme {
  static ThemeData get light => FThemes.zinc.light.toApproximateMaterialTheme().copyWith(
    switchTheme: CustomSwitchTheme.light,
  );

  static ThemeData get dark => FThemes.zinc.dark.toApproximateMaterialTheme().copyWith(
    switchTheme: CustomSwitchTheme.dark,
  );
} 
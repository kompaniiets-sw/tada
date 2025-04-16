import 'package:flutter/material.dart';
import 'package:tada/utils/constants/colors.dart';

class CustomSwitchTheme {
  static SwitchThemeData get light => SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return EColors.accent;
      }
      return EColors.black;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return EColors.accent.withValues(alpha: 0.3);
      }
      return EColors.silver;
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
  );

  static SwitchThemeData get dark => SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return EColors.accent;
      }
      return EColors.lightGrey;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return EColors.accent.withValues(alpha: 0.5);
      }
      return EColors.raisinblack;
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
  );
} 
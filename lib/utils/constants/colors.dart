import 'package:flutter/material.dart';


class EColors{
  EColors._();

  //app basic colors
  static const Color primary = Color(0xFF565FDB);
  static const Color secondary = Color(0xffffe601);


// Gradients
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xFF96A8FF),  // приклад кольору
      Color(0xFFA1AFF8),
      Color(0xFFD7DDFB) // ще один приклад кольору
    ],
  );

  //text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  //background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  //background container colors
  static const Color lightContainer = Color(0xFfF6F6F6);
  static Color darkContainer = EColors.white.withValues(alpha:0.1);

// Button Colors
  static const Color buttonPrimary = Color(0xFF4B68FF);
  static const Color buttonSecondary = Color(0xFF6C7570);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

// Border Colors
  static const Color borderPrimary = Color(0xFFD9D909);
  static const Color borderSecondary = Color(0xFFE6E6E6);

// Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

// Neutral Shades

  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);

  

  /// --USED IN APP--

  static const Color accent = Color(0xFFff6c1f); //tangerine 

  static const Color white = Color(0xFFFFFFFF);
  static const Color seasalt = Color(0xFFf8fafa);
  static const Color silver = Color(0xFFc5c6c8);
  static const Color gray = Color(0xFF818283);
  static const Color davygray = Color(0xFF4f5052);
  static const Color raisinblack = Color(0xFF2b2728);
  static const Color night = Color(0xFF0d0e10);
  static const Color black = Color(0xFF000000); // Black in light mode


}

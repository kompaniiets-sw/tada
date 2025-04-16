import 'package:flutter/material.dart';
import 'package:tada/utils/constants/colors.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isDark;
  final Color? borderColor;

  const SettingsButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    required this.isDark,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? EColors.darkerGrey : EColors.accent,
              foregroundColor: isDark ? Colors.white : Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
              ),
            ),
            child: Text(text),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: isDark ? Colors.white : Colors.black,
              side: BorderSide(
                color: borderColor ?? (isDark ? Colors.white : Colors.black),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(text),
          );
  }
} 

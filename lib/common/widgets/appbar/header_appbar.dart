import 'package:flutter/material.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:tada/utils/constants/colors.dart';

class HeaderAppbar extends StatefulWidget implements PreferredSizeWidget {
  const HeaderAppbar({
    super.key,
    this.title = 'Pomodoro',
    this.actions = const [],
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String title;
  final List<Widget> actions;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<HeaderAppbar> createState() => _HeaderAppbarState();
}

class _HeaderAppbarState extends State<HeaderAppbar> {
  @override
  Widget build(BuildContext context) {
    if (!mounted) return const SizedBox.shrink();
    
    final dark = EHelperFunctions.isDarkMode(context);
    return AppBar(
      centerTitle: widget.centerTitle,
      title: Text(widget.title),
      backgroundColor: widget.backgroundColor ?? (dark ? EColors.night : Colors.white),
      foregroundColor: widget.foregroundColor ?? (dark ? Colors.white : EColors.night),
      elevation: widget.elevation,
      actions: widget.actions,
    );
  }
}
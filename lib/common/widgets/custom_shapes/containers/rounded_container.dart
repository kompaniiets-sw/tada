import 'package:tada/utils/constants/colors.dart';
import 'package:tada/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
class ERoundedContainer extends StatelessWidget {
  const ERoundedContainer({
    super.key,
    this.width,
    this.height,
     this.radius = ESizes.cardRadiusLg,
    this.child,
     this.showBorder = false,
     this.borderColor = EColors.borderPrimary,
     this.backgroundColor = EColors.white,
    this.padding,
    this.margin
    });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}

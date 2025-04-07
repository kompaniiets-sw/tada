import 'package:tada/utils/constants/colors.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:flutter/material.dart';



class EFormDivider extends StatelessWidget {
  const EFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
     final dark = EHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? EColors.darkGrey : EColors.grey,
            thickness: 0.8,
            indent: 60,
            endIndent: 10,
          ),
        ),
    
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
    
        Flexible(
          child: Divider(
            color: dark ? EColors.darkGrey : EColors.grey,
            thickness: 0.8,
            indent: 10,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}


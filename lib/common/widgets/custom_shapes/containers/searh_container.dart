
import 'package:tada/device/device_utility.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:tada/utils/constants/sizes.dart';

import 'package:tada/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ESearchContainer extends StatelessWidget {
  const ESearchContainer({
     super.key, 
     required this.text, 
     this.icon = Iconsax.search_normal, 
     this.showBackground = true, 
     this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ESizes.defaultSpace),
      child: Container(
       width: EDeviceUtils.getScreenWidth(context),
       padding: EdgeInsets.all(ESizes.md),
       decoration: BoxDecoration(
         color: showBackground 
         ? dark ? EColors.dark : EColors.white 
         : Colors.transparent,
         borderRadius: BorderRadius.circular(ESizes.md),
         border: showBorder ? Border.all(color: EColors.grey) : null,
       ),
       child: Row(
         children: [
           Icon(icon, color: EColors.darkerGrey,),
           const SizedBox(width: ESizes.spaceBtwSections, ),
           Text(text, style: Theme.of(context).textTheme.bodySmall!,)
         ],
       ),
      ),
    );
  }
}



import 'package:tada/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class EShadowStyle {

  static final verticalProductShadow = BoxShadow(
    color: EColors.darkGrey.withAlpha(25),
    blurRadius: 50,
    spreadRadius: 7,
    offset:  const Offset(0, 2)
  );

  static final horizontalProductShadow = BoxShadow(
    color: EColors.darkGrey.withAlpha(25),
    blurRadius: 50,
    spreadRadius: 7,
    offset:  const Offset(0, 2)
  );

}

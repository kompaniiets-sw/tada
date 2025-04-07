import 'package:tada/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:tada/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:flutter/material.dart';
class EPrimaryHeaderContainer extends StatelessWidget {
  const EPrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ECurvedEdgeWidget(
      child: Container(
        color: EColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: ECircularContainer(
                  backgroundColor: EColors.textWhite.withAlpha(26),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: ECircularContainer(
                  backgroundColor: EColors.textWhite.withAlpha(26),
                ),
              ),
              Positioned.fill( // Додає `child` (EAppBar)
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

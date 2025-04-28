import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tada/utils/constants/colors.dart';

class ProjectContainerWidget extends StatelessWidget {
  final String projectName;
  final String time;
  final bool isDark;

  const ProjectContainerWidget({
    super.key,
    required this.projectName,
    required this.time,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: isDark ? EColors.black : EColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectName,
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? EColors.white : EColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Divider(
                        color: isDark ? EColors.white : EColors.grey,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      time,
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: const Icon(Iconsax.play),
                iconSize: 30,
                color: Colors.grey[600],
                onPressed: () {
                  // TODO: Додати функціонал запуску таймера
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

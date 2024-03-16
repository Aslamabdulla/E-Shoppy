import 'package:e_shoppy/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.0, 1.0],
            colors: [
              LightThemeColors.gradientLogin,
              LightThemeColors.gradientLogin2,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w600,
        height: 0.92,
        letterSpacing: -3.2,
        color: textColor,
        fontFamily: 'Georgia',
      ),
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.5,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        height: 1.85,
        color: textColor,
        fontFamily: 'Georgia',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.5,
        color: textColor,
      ),
      bodySmall: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.mist,
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
    );
  }
}

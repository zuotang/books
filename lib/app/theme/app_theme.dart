import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_extension.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColors.shelfBlue,
      surface: AppColors.paper,
      onSurface: AppColors.ink,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.paper,
      textTheme: AppTypography.textTheme(AppColors.ink),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.ink,
      ),
      cardColor: Colors.white.withValues(alpha: 0.68),
      extensions: const [
        ReadingThemeTokens(
          paperGradientTop: AppColors.paperSoft,
          paperGradientBottom: AppColors.paper,
          shelfStart: AppColors.shelfBlue,
          shelfEnd: AppColors.shelfBlueDeep,
          readerCard: Colors.white,
        ),
      ],
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.accentGold,
      surface: AppColors.night,
      onSurface: AppColors.nightInk,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.night,
      textTheme: AppTypography.textTheme(AppColors.nightInk),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.nightInk,
      ),
      cardColor: AppColors.nightCard,
      extensions: const [
        ReadingThemeTokens(
          paperGradientTop: Color(0xFF141820),
          paperGradientBottom: Color(0xFF0D1017),
          shelfStart: Color(0xFF2A3C56),
          shelfEnd: Color(0xFF17263B),
          readerCard: Color(0xFF11151C),
        ),
      ],
    );
  }
}

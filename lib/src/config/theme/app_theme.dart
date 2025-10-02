import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData buildAppTheme() {
  final base = ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary));
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: base.appBarTheme.copyWith(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}

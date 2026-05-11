import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData getLightTheme(String languageCode) {
    final textTheme = AppTypography.getTextTheme(languageCode);
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: DoctorXColors.lightScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: DoctorXColors.surface,
      extensions: const [
        AppTokens.defaultTokens,
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: DoctorXColors.surfaceContainerLowest.withOpacity(0.6),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: DoctorXColors.onSurface),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: DoctorXColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: DoctorXColors.primary,
          foregroundColor: DoctorXColors.onPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DoctorXColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DoctorXColors.primary, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: DoctorXColors.outlineVariant,
        ),
      ),
    );
  }
}

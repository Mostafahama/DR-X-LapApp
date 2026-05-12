import 'package:flutter/material.dart';

class DoctorXColors {
  // Primary & Action (Blue spectrum)
  static const Color primary = Color(0xFF0050CB);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF0066FF);
  static const Color onPrimaryContainer = Color(0xFFF8F7FF);
  static const Color surfaceTint = Color(0xFF0054D6);

  // Secondary - Slate Blues
  static const Color secondary = Color(0xFF515F74);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFD5E3FC);
  static const Color onSecondaryContainer = Color(0xFF57657A);

  // Semantic
  static const Color success = Color(0xFF006645); // Emerald Green
  static const Color tertiary = Color(0xFF006645);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF008259);
  static const Color onTertiaryContainer = Color(0xFFE1FFEC);
  
  static const Color pending = Color(0xFF3A485B); // Amber/Slate hybrid
  static const Color urgent = Color(0xFFBA1A1A); // Crimson
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Surface & Depth
  static const Color surface = Color(0xFFF7F9FB);
  static const Color surfaceDim = Color(0xFFD8DADC);
  static const Color surfaceBright = Color(0xFFF7F9FB);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F6);
  static const Color surfaceContainer = Color(0xFFECEEF0);
  static const Color surfaceContainerHigh = Color(0xFFE6E8EA);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E5);

  // Text & Outline
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF424656);
  static const Color outline = Color(0xFF727687);
  static const Color outlineVariant = Color(0xFFC2C6D8);

  // Liquid Glass Specifics
  static Color glassBackground(double opacity) => Colors.white.withOpacity(opacity);
  static const Color glassBorderTop = Color(0x66FFFFFF); // 40% white
  static const Color glassBorderBottom = Color(0x1A727687); // 10% outline

  // New specific tokens from HTML
  static const Color primaryFixed = Color(0xFFDAE1FF);
  static const Color primaryFixedDim = Color(0xFFB3C5FF);
  static const Color onPrimaryFixed = Color(0xFF001849);
  static const Color onPrimaryFixedVariant = Color(0xFF003FA4);
  
  static const Color secondaryFixed = Color(0xFFD5E3FC);
  static const Color secondaryFixedDim = Color(0xFFB9C7DF);
  static const Color onSecondaryFixed = Color(0xFF0D1C2E);
  static const Color onSecondaryFixedVariant = Color(0xFF3A485B);

  static const Color tertiaryFixed = Color(0xFF6FFBBE);
  static const Color tertiaryFixedDim = Color(0xFF4EDEA3);
  static const Color onTertiaryFixed = Color(0xFF002113);
  static const Color onTertiaryFixedVariant = Color(0xFF005236);

  static const LinearGradient clinicalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0050CB), Color(0xFF0066FF)],
  );

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceContainerHighest,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
  );
}

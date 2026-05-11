import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme getTextTheme(String languageCode) {
    final baseTextTheme = languageCode == 'ar' 
        ? GoogleFonts.cairoTextTheme() 
        : GoogleFonts.interTextTheme();

    final fontFunction = languageCode == 'ar' 
        ? GoogleFonts.cairo 
        : GoogleFonts.inter;

    return baseTextTheme.copyWith(
      displayLarge: fontFunction(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: languageCode == 'ar' ? 0 : -0.25,
      ),
      displayMedium: fontFunction(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: fontFunction(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: fontFunction(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: fontFunction(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: fontFunction(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: fontFunction(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: fontFunction(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: languageCode == 'ar' ? 0 : 0.15,
      ),
      titleSmall: fontFunction(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: languageCode == 'ar' ? 0 : 0.1,
      ),
      labelLarge: fontFunction(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: languageCode == 'ar' ? 0 : 0.1,
      ),
      labelMedium: fontFunction(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: languageCode == 'ar' ? 0 : 0.5,
      ),
      labelSmall: fontFunction(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: languageCode == 'ar' ? 0 : 0.5,
      ),
      bodyLarge: fontFunction(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: languageCode == 'ar' ? 0 : 0.5,
      ),
      bodyMedium: fontFunction(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: languageCode == 'ar' ? 0 : 0.25,
      ),
      bodySmall: fontFunction(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: languageCode == 'ar' ? 0 : 0.4,
      ),
    );
  }
}

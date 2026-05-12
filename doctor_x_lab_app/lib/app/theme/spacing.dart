import 'package:flutter/material.dart';

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  final double radiusSm; // 4.0
  final double radiusMd; // 6.0
  final double radiusLg; // 8.0
  final double radiusXl; // 16.0
  final double radiusLiquid; // 24.0
  final double radiusFull; // 999.0
  final double radiusXxl; // 32.0 (for backward compatibility)
  final double spacingXs;
  final double spacingSm;
  final double spacingMd;
  final double spacingLg;
  final double spacingXl;
  final double spacingXxl;
  final double glassBlur;

  const AppTokens({
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.radiusLiquid,
    required this.radiusFull,
    required this.radiusXxl,
    required this.spacingXs,
    required this.spacingSm,
    required this.spacingMd,
    required this.spacingLg,
    required this.spacingXl,
    required this.spacingXxl,
    required this.glassBlur,
  });

  static const defaultTokens = AppTokens(
    radiusSm: 4.0,
    radiusMd: 6.0,
    radiusLg: 8.0,
    radiusXl: 16.0,
    radiusLiquid: 24.0,
    radiusFull: 999.0,
    radiusXxl: 32.0,
    spacingXs: 4.0,
    spacingSm: 8.0,
    spacingMd: 16.0,
    spacingLg: 24.0,
    spacingXl: 32.0,
    spacingXxl: 48.0,
    glassBlur: 16.0,
  );

  @override
  ThemeExtension<AppTokens> copyWith({
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusXl,
    double? radiusLiquid,
    double? radiusFull,
    double? radiusXxl,
    double? spacingXs,
    double? spacingSm,
    double? spacingMd,
    double? spacingLg,
    double? spacingXl,
    double? spacingXxl,
    double? glassBlur,
  }) {
    return AppTokens(
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
      radiusXl: radiusXl ?? this.radiusXl,
      radiusLiquid: radiusLiquid ?? this.radiusLiquid,
      radiusFull: radiusFull ?? this.radiusFull,
      radiusXxl: radiusXxl ?? this.radiusXxl,
      spacingXs: spacingXs ?? this.spacingXs,
      spacingSm: spacingSm ?? this.spacingSm,
      spacingMd: spacingMd ?? this.spacingMd,
      spacingLg: spacingLg ?? this.spacingLg,
      spacingXl: spacingXl ?? this.spacingXl,
      spacingXxl: spacingXxl ?? this.spacingXxl,
      glassBlur: glassBlur ?? this.glassBlur,
    );
  }

  @override
  ThemeExtension<AppTokens> lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) {
      return this;
    }
    return AppTokens(
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t)!,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t)!,
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t)!,
      radiusXl: lerpDouble(radiusXl, other.radiusXl, t)!,
      radiusLiquid: lerpDouble(radiusLiquid, other.radiusLiquid, t)!,
      radiusFull: lerpDouble(radiusFull, other.radiusFull, t)!,
      radiusXxl: lerpDouble(radiusXxl, other.radiusXxl, t)!,
      spacingXs: lerpDouble(spacingXs, other.spacingXs, t)!,
      spacingSm: lerpDouble(spacingSm, other.spacingSm, t)!,
      spacingMd: lerpDouble(spacingMd, other.spacingMd, t)!,
      spacingLg: lerpDouble(spacingLg, other.spacingLg, t)!,
      spacingXl: lerpDouble(spacingXl, other.spacingXl, t)!,
      spacingXxl: lerpDouble(spacingXxl, other.spacingXxl, t)!,
      glassBlur: lerpDouble(glassBlur, other.glassBlur, t)!,
    );
  }

  double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}

extension ThemeTokens on BuildContext {
  AppTokens get tokens =>
      Theme.of(this).extension<AppTokens>() ?? AppTokens.defaultTokens;
}

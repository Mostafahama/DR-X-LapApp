import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/spacing.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? blur;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.blur,
    this.opacity = 0.6,
    this.padding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? context.tokens.radiusMd;
    final effectiveBlur = blur ?? context.tokens.glassBlur;

    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
            decoration: BoxDecoration(
              color: DoctorXColors.glassBackground(opacity),
              borderRadius: BorderRadius.circular(effectiveRadius),
              border: border ?? Border.all(color: Colors.white.withOpacity(0.4)),
              boxShadow: [
              BoxShadow(
                color: DoctorXColors.onSurface.withOpacity(0.06),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
              // Inner Glow
              const BoxShadow(
                color: Color(0x66FFFFFF),
                blurRadius: 1,
                spreadRadius: -1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

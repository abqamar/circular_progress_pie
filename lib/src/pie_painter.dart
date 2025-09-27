import 'dart:math';
import 'package:flutter/material.dart';

/// A [CustomPainter] that draws the pie progress background and foreground.
class PiePainter extends CustomPainter {
  final double value;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? progressGradient;
  final double strokeWidth;
  final bool isFilled;
  final double startAngle;
  final bool reverse;

  PiePainter({
    required this.value,
    required this.backgroundColor,
    required this.progressColor,
    this.progressGradient,
    required this.strokeWidth,
    required this.isFilled,
    required this.startAngle,
    required this.reverse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw background
    paint.shader = null;
    paint.color = backgroundColor;
    canvas.drawArc(rect, 0, 2 * pi, false, paint);

    // Apply gradient or solid color for progress
    if (progressGradient != null) {
      paint.shader = progressGradient!.createShader(rect);
    } else {
      paint.color = progressColor;
    }

    // Draw progress arc
    final sweepAngle = (reverse ? -1 : 1) * (value * 2 * pi);
    canvas.drawArc(rect, startAngle, sweepAngle, isFilled, paint);
  }

  @override
  bool shouldRepaint(PiePainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.progressColor != progressColor ||
      oldDelegate.progressGradient != progressGradient ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.isFilled != isFilled ||
      oldDelegate.startAngle != startAngle ||
      oldDelegate.reverse != reverse;
}

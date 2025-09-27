import 'dart:math';
import 'package:flutter/material.dart';

import 'circular_progress_pie.dart';

class PiePainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? progressGradient;
  final double strokeWidth;
  final bool isFilled;
  final double startAngle;
  final bool reverse;
  final PieAnimationType animationType;
  final Animation<double>? animation;

  PiePainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    this.progressGradient,
    this.strokeWidth = 10.0,
    this.isFilled = true,
    this.startAngle = -pi / 2,
    this.reverse = false,
    this.animationType = PieAnimationType.sweep,
    this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    _drawBackground(canvas, center, radius);

    // Only draw progress if percentage > 0
    if (percentage > 0.0) {
      _drawProgress(canvas, size);
    }
  }

  void _drawBackground(Canvas canvas, Offset center, double radius) {
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = isFilled ? 0 : strokeWidth
      ..isAntiAlias = true;

    canvas.drawCircle(center, radius, bgPaint);
  }

  void _drawProgress(Canvas canvas, Size size) {
    final progressPaint = Paint()
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = isFilled ? 0 : strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    if (progressGradient != null) {
      final rect = Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: size.width / 2,
      );
      progressPaint.shader = progressGradient!.createShader(rect);
    } else {
      progressPaint.color = progressColor;
    }

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Calculate the sweep angle based on the percentage
    final sweepAngle = 2 * pi * percentage * (reverse ? -1 : 1);

    canvas.drawArc(rect, startAngle, sweepAngle, isFilled, progressPaint);
  }

  @override
  bool shouldRepaint(covariant PiePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.isFilled != isFilled ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.reverse != reverse ||
        oldDelegate.animationType != animationType ||
        oldDelegate.animation != animation;
  }
}

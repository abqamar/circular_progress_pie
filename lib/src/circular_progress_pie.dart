import 'package:flutter/material.dart';
import 'animated_pie_progress.dart';

/// The type of animation for the pie progress indicator
enum PieAnimationType {
  /// Sweep animation (default) - arc grows from start angle
  sweep,

  /// Fill animation - pie fills from center outward
  fill,

  /// Clockwise animation with bounce effect
  bounce,

  /// Elastic animation with overshoot
  elastic,
}

/// A highly customizable pie progress indicator widget.
///
/// Provides multiple constructors to build:
/// - `CircularProgressPie.circular`: Ring style progress indicator
/// - `CircularProgressPie.percentage`: Shows percentage text inside
/// - `CircularProgressPie.gradient`: Progress with gradient fill
///
/// Example:
/// ```dart
/// CircularProgressPie.percentage(value: 0.5);
/// ```
class CircularProgressPie extends StatefulWidget {
  /// The current progress value between 0.0 and 1.0
  final double value;

  /// The size of the indicator (width and height)
  final double size;

  /// Background color of the pie (default: light gray)
  final Color backgroundColor;

  /// Progress color (ignored if [progressGradient] is provided)
  final Color progressColor;

  /// Gradient for the progress arc (overrides [progressColor])
  final Gradient? progressGradient;

  /// Stroke width for ring-style progress (only used when [isFilled] = false)
  final double strokeWidth;

  /// Whether to draw a filled pie (true) or a ring (false)
  final bool isFilled;

  /// Type of animation to use
  final PieAnimationType animationType;

  /// Duration of the animation
  final Duration duration;

  /// Curve for the animation (default: [Curves.easeInOut])
  final Curve curve;

  /// Widget to display in the center of the pie (e.g., text, icon)
  final Widget? child;

  /// Starting angle in radians (default: -pi/2 = top)
  final double startAngle;

  /// Whether to animate in reverse direction
  final bool reverse;

  /// Whether to animate changes
  final bool animate;

  /// Callback when animation completes
  final VoidCallback? onAnimationComplete;

  const CircularProgressPie({
    super.key,
    required this.value,
    this.size = 100.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
    this.progressGradient,
    this.strokeWidth = 10.0,
    this.isFilled = true,
    this.animationType = PieAnimationType.sweep,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeInOut,
    this.child,
    this.startAngle = -1.5708, // -pi/2
    this.reverse = false,
    this.animate = true,
    this.onAnimationComplete,
  }) : assert(
         value >= 0.0 && value <= 1.0,
         'Value must be between 0.0 and 1.0',
       ),
       assert(size > 0, 'Size must be positive');

  /// Creates a circular ring-style progress indicator.
  static Widget circular({
    required double value,
    double size = 40.0,
    Color backgroundColor = const Color(0xFFE0E0E0),
    Color progressColor = Colors.blue,
    double strokeWidth = 3.0,
    bool animate = true,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return CircularProgressPie(
      value: value,
      size: size,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
      strokeWidth: strokeWidth,
      isFilled: false,
      animate: animate,
      duration: duration,
    );
  }

  /// Creates a percentage indicator with text in the center.
  static Widget percentage({
    required double value,
    double size = 100.0,
    TextStyle? textStyle,
    Color progressColor = Colors.blue,
    Color backgroundColor = const Color(0xFFE0E0E0),
    bool animate = true,
  }) {
    return CircularProgressPie(
      value: value,
      size: size,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      animate: animate,
      child: Text(
        '${(value * 100).round()}%',
        style:
            textStyle ??
            TextStyle(
              fontSize: size * 0.25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
      ),
    );
  }

  /// Creates a gradient progress indicator.
  static Widget gradient({
    required double value,
    required Gradient gradient,
    double size = 100.0,
    Color backgroundColor = const Color(0xFFE0E0E0),
    bool isFilled = true,
    double strokeWidth = 10.0,
    bool animate = true,
  }) {
    return CircularProgressPie(
      value: value,
      size: size,
      progressGradient: gradient,
      backgroundColor: backgroundColor,
      isFilled: isFilled,
      strokeWidth: strokeWidth,
      animate: animate,
    );
  }

  @override
  State<CircularProgressPie> createState() => _CircularProgressPieState();
}

class _CircularProgressPieState extends State<CircularProgressPie> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPieProgress(
      value: widget.value,
      size: widget.size,
      backgroundColor: widget.backgroundColor,
      progressColor: widget.progressColor,
      progressGradient: widget.progressGradient,
      strokeWidth: widget.strokeWidth,
      isFilled: widget.isFilled,
      animationType: widget.animationType,
      duration: widget.duration,
      curve: widget.curve,
      startAngle: widget.startAngle,
      reverse: widget.reverse,
      animate: widget.animate,
      onAnimationComplete: widget.onAnimationComplete,
      child: widget.child,
    );
  }
}

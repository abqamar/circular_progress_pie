import 'package:flutter/material.dart';
import 'circular_progress_pie.dart';
import 'pie_painter.dart';
import '../circular_progress_pie.dart';

class AnimatedPieProgress extends StatefulWidget {
  final double value;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? progressGradient;
  final double strokeWidth;
  final bool isFilled;
  final PieAnimationType animationType;
  final Duration duration;
  final Curve curve;
  final double startAngle;
  final bool reverse;
  final bool animate;
  final VoidCallback? onAnimationComplete;
  final Widget? child;

  const AnimatedPieProgress({
    super.key,
    required this.value,
    required this.size,
    required this.backgroundColor,
    required this.progressColor,
    this.progressGradient,
    required this.strokeWidth,
    required this.isFilled,
    required this.animationType,
    required this.duration,
    required this.curve,
    required this.startAngle,
    required this.reverse,
    required this.animate,
    this.onAnimationComplete,
    this.child,
  });

  @override
  State<AnimatedPieProgress> createState() => _AnimatedPieProgressState();
}

class _AnimatedPieProgressState extends State<AnimatedPieProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldValue = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animateTo(widget.value);
  }

  @override
  void didUpdateWidget(AnimatedPieProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _animateTo(widget.value);
    }
  }

  void _animateTo(double newValue) {
    if (!widget.animate) {
      setState(() {});
      return;
    }

    _animation = Tween<double>(
      begin: _oldValue,
      end: newValue,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.forward(from: 0).whenComplete(() {
      widget.onAnimationComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, _) {
          final animatedValue = widget.animate
              ? _animation.value
              : widget.value;
          return CustomPaint(
            painter: PiePainter(
              value: animatedValue,
              backgroundColor: widget.backgroundColor,
              progressColor: widget.progressColor,
              progressGradient: widget.progressGradient,
              strokeWidth: widget.strokeWidth,
              isFilled: widget.isFilled,
              startAngle: widget.startAngle,
              reverse: widget.reverse,
            ),
            child: Center(child: widget.child),
          );
        },
      ),
    );
  }
}

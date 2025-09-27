import 'package:flutter/material.dart';
import 'circular_progress_pie.dart';
import 'pie_painter.dart';

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
  final Widget? child;
  final double startAngle;
  final bool reverse;
  final bool animate;
  final VoidCallback? onAnimationComplete;

  const AnimatedPieProgress({
    super.key,
    required this.value,
    required this.size,
    required this.backgroundColor,
    required this.progressColor,
    this.progressGradient,
    this.strokeWidth = 10.0,
    this.isFilled = true,
    this.animationType = PieAnimationType.sweep,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeInOut,
    this.child,
    this.startAngle = -1.5708,
    this.reverse = false,
    this.animate = true,
    this.onAnimationComplete,
  });

  @override
  State<AnimatedPieProgress> createState() => _AnimatedPieProgressState();
}

class _AnimatedPieProgressState extends State<AnimatedPieProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0.0;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(begin: _previousValue, end: widget.value)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: _getCurveForAnimationType(widget.animationType),
          ),
        );

    if (widget.animate) {
      _controller.forward().then((_) {
        widget.onAnimationComplete?.call();
      });
    }
  }

  Curve _getCurveForAnimationType(PieAnimationType type) {
    switch (type) {
      case PieAnimationType.bounce:
        return Curves.bounceOut;
      case PieAnimationType.elastic:
        return Curves.elasticOut;
      case PieAnimationType.fill:
        return Curves.easeInCubic;
      case PieAnimationType.sweep:
      return widget.curve;
    }
  }

  @override
  void didUpdateWidget(AnimatedPieProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value && widget.animate) {
      _previousValue = _animation.value;
      _controller.reset();
      _animation = Tween<double>(begin: _previousValue, end: widget.value)
          .animate(
            CurvedAnimation(
              parent: _controller,
              curve: _getCurveForAnimationType(widget.animationType),
            ),
          );
      _controller.forward().then((_) {
        widget.onAnimationComplete?.call();
      });
    }
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(widget.size, widget.size),
            painter: PiePainter(
              percentage: widget.animate ? _animation.value : widget.value,
              backgroundColor: widget.backgroundColor,
              progressColor: widget.progressColor,
              progressGradient: widget.progressGradient,
              strokeWidth: widget.strokeWidth,
              isFilled: widget.isFilled,
              startAngle: widget.startAngle,
              reverse: widget.reverse,
              animationType: widget.animationType,
              animation: widget.animate ? _animation : null,
            ),
          ),
          if (widget.child != null) widget.child!,
        ],
      ),
    );
  }
}

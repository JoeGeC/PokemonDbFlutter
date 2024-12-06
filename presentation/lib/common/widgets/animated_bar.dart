import 'package:flutter/material.dart';

class AnimatedBar extends StatefulWidget {
  final int initialValue; // 0-255
  final int targetValue; // 0-255
  final double height;
  final double width;
  final int milliseconds;
  final Color backgroundColor;
  final Color barColor;
  final double barRadius;

  const AnimatedBar({
    super.key,
    this.initialValue = 0,
    this.targetValue = 255,
    this.height = 20,
    this.width = 300,
    this.milliseconds = 500,
    this.backgroundColor = Colors.grey,
    this.barColor = Colors.red,
    this.barRadius = 4,
  });

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() {
    setState(() {
      _currentValue = widget.targetValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    double normalizedWidth = (_currentValue / 255).clamp(0.0, 1.0);
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(widget.barRadius),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: Duration(milliseconds: widget.milliseconds),
          curve: Curves.easeInOut,
          width: widget.width * normalizedWidth,
          decoration: BoxDecoration(
            color: widget.barColor,
            borderRadius: BorderRadius.all(
              Radius.circular(widget.barRadius),
            ),
          ),
        ),
      ),
    );
  }

  int validateValue() => widget.targetValue > 255
      ? 255
      : widget.targetValue < 0
          ? 0
          : widget.targetValue;
}

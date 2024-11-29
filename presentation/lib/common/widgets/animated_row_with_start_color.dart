import 'package:flutter/material.dart';

class AnimatedRowWithStartColor extends StatefulWidget {
  final Color startColor;
  final List<Widget> children;
  final double initialWidth;
  final double expandedWidth;
  final int id;
  final Function(int)? onTapped;
  final Function(bool)? isAnimating;

  const AnimatedRowWithStartColor({
    super.key,
    this.startColor = Colors.red,
    this.children = const <Widget>[],
    this.initialWidth = 20,
    this.expandedWidth = 100,
    this.id = 0,
    this.onTapped,
    this.isAnimating,
  });

  @override
  _AnimatedRowWithStartColorState createState() =>
      _AnimatedRowWithStartColorState();
}

class _AnimatedRowWithStartColorState extends State<AnimatedRowWithStartColor>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  void _onTap() {
    _startAnimation();
    _toggleExpanded();
    _tapCallback();
  }

  Future<void> _startAnimation() async {
    if(widget.isAnimating != null) {
      widget.isAnimating!(true);
    }
    await _controller.forward();
    if(widget.isAnimating != null) {
      widget.isAnimating!(false);
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _tapCallback() {
    if (widget.onTapped != null) {
      widget.onTapped!(widget.id);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var expandedWidth = constraints.maxWidth;

        return InkWell(
          onTap: _onTap,
          child: SizedBox(
            width: double.infinity,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAnimatedColor(expandedWidth),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.children,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AnimatedContainer _buildAnimatedColor(double expandedWidth) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: _isExpanded ? expandedWidth : widget.initialWidth,
      decoration: BoxDecoration(
        color: widget.startColor,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(8),
        ),
      ),
    );
  }
}

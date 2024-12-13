import 'package:flutter/material.dart';

class LoadingBar extends StatefulWidget {
  final Widget? child;

  const LoadingBar({super.key, this.child});

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false); // Loop the animation

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _buildAnimatedBar(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: widget.child ?? Container(),
            ),
          ),
        ],
      );

  Container _buildAnimatedBar() {
    var theme = Theme.of(context);
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => FractionallySizedBox(
          widthFactor: _animation.value,
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}

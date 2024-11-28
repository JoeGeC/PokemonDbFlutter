import 'package:flutter/cupertino.dart';

class AnimatedRowWithStartColor extends StatefulWidget {
  final Color startColor;
  final List<Widget> children;
  final double initialWidth;
  final double expandedWidth;

  const AnimatedRowWithStartColor({
    required this.startColor,
    this.children = const <Widget>[],
    this.initialWidth = 20,
    this.expandedWidth = 100,
    super.key,
  });

  @override
  _AnimatedRowWithStartColorState createState() =>
      _AnimatedRowWithStartColorState();
}

class _AnimatedRowWithStartColorState extends State<AnimatedRowWithStartColor> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      var expandedWidth = constraints.maxWidth;
      return IntrinsicHeight(
        child: GestureDetector(
          onTap: _toggleExpansion,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: _isExpanded ? expandedWidth : widget.initialWidth,
                decoration: BoxDecoration(
                  color: widget.startColor,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(8),
                  ),
                ),
              ),
              Flexible(child: Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.children,
              ))
            ],
          ),
        ),
      );
    });
  }
}

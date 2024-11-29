import 'package:flutter/material.dart';

class RowWithStartColor extends StatefulWidget {
  final Color startColor;
  final List<Widget> children;
  final double startColorWidth;
  final int id;
  final Function(int)? onTapped;

  const RowWithStartColor({
    super.key,
    this.startColor = Colors.red,
    this.children = const <Widget>[],
    this.startColorWidth = 20,
    this.id = 0,
    this.onTapped,
  });

  @override
  _RowWithStartColorState createState() => _RowWithStartColorState();
}

class _RowWithStartColorState extends State<RowWithStartColor>
    with TickerProviderStateMixin {
  void _onTap() {
    if (widget.onTapped != null) {
      widget.onTapped!(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) => Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _onTap,
        child: SizedBox(
          width: double.infinity,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStartColor(),
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
      ),
    );

  Widget _buildStartColor() => Container(
        width: widget.startColorWidth,
        decoration: BoxDecoration(
          color: widget.startColor,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(8),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final TextStyle? textStyle;

  const ErrorPage({super.key, this.textStyle});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text(
          "Something went wrong :(",
          style: textStyle ?? theme.textTheme.labelMedium,
        ),
    );
  }
}

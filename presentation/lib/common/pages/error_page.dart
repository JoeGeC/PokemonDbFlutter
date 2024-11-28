import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text(
        "Something went wrong :(",
        style: theme.textTheme.labelMedium,
      ),
    );
  }
}

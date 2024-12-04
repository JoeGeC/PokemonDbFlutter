import 'package:flutter/material.dart';
import 'package:presentation/common/text_theme.dart';

Widget buildPageTitle({
  required ThemeData theme,
  GlobalKey<State<StatefulWidget>>? headerKey,
  required String title,
  String? subtitle,
  double? leftPadding
}) =>
    Padding(
      padding: EdgeInsets.only(left: leftPadding ?? 0),
      child: Row(
        key: headerKey,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineMedium!.copyWith(),
          ),
          SizedBox(width: 10),
          if (subtitle != null && subtitle.isNotEmpty)
            _buildTitleAbbreviation(theme, subtitle)
        ],
      ),
    );

Padding _buildTitleAbbreviation(ThemeData theme, String subtitle) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        "($subtitle)",
        style: theme.textTheme.labelMediumWhite,
      ),
    );

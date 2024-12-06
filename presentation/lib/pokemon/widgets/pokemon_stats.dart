import 'package:flutter/material.dart';
import 'package:presentation/common/text_theme.dart';

import '../../common/widgets/animated_bar.dart';

Row buildPokemonStatRow(ThemeData theme, String label, int? value) => Row(
      children: [
        SizedBox(
          width: 100,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(label, style: theme.textTheme.labelMediumWhite),
          ),
        ),
        SizedBox(width: 16),
        _buildStatBar(value, theme)
      ],
    );

Expanded _buildStatBar(int? value, ThemeData theme) => Expanded(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedBar(
            targetValue: value ?? 0,
            height: 30,
            barColor: theme.colorScheme.secondary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child:
                Text(value.toString(), style: theme.textTheme.labelMediumWhite),
          ),
        ],
      ),
    );

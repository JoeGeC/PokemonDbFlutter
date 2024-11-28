import 'package:flutter/material.dart';
import 'package:presentation/common/text_theme.dart';
import 'package:presentation/common/widgets/rounded_box.dart';

import '../type_colors.dart';

Widget buildPokemonTypes(List<String>? types, ThemeData theme) {
  if (types == null) return _buildFallBacks(theme);
  return types.isEmpty
      ? _buildTypeBox("?", theme)
      : _buildTypeBoxes(types, theme);
}

Widget _buildFallBacks(ThemeData theme) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTypeBoxBackground(),
        SizedBox(width: 10),
        _buildTypeBoxBackground(),
      ],
    );

Widget _buildTypeBoxes(List<String> types, ThemeData theme) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: types
          .map((type) => Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: _buildTypeBox(type, theme),
              ))
          .toList(),
    );

Widget _buildTypeBox(String type, ThemeData theme) => Stack(
      alignment: Alignment.center,
      children: [
        _buildTypeBoxBackground(type: type),
        _buildTypeText(type, theme),
      ],
    );

Widget _buildTypeBoxBackground({String? type}) => RoundedBox(
      width: 100,
      height: 40,
      color: getTypeColor(type),
      borderRadius: 4,
      borderColor: getTypeBorderColor(type),
      borderWidth: 2
    );

Widget _buildTypeText(String text, ThemeData theme) => Text(
      text,
      style: CustomTextTheme().labelMediumAlt
    );

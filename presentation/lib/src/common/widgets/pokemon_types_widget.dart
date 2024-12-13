import 'package:flutter/material.dart';
import 'package:presentation/src/common/text_theme.dart';
import 'package:presentation/src/common/widgets/rounded_box.dart';
import 'package:presentation/src/common/widgets/shimmer.dart';

import '../type_colors.dart';

Widget buildPokemonTypes(
    {required List<String>? types,
    required ThemeData theme,
    double typeBoxWidth = 100,
    double typeBoxHeight = 40,
    double borderRadius = 4,
    MainAxisAlignment alignment = MainAxisAlignment.start}) {
  if (types == null) {
    return _buildFallBacks(
      theme,
      typeBoxWidth,
      typeBoxHeight,
      borderRadius,
      alignment,
    );
  }
  return types.isEmpty
      ? _buildFallBacks(
          theme,
          typeBoxWidth,
          typeBoxHeight,
          borderRadius,
          alignment,
        )
      : _buildTypeBoxes(
          types,
          theme,
          typeBoxWidth,
          typeBoxHeight,
          borderRadius,
          alignment,
        );
}

Widget _buildFallBacks(
  ThemeData theme,
  double typeBoxWidth,
  double typeBoxHeight,
  double borderRadius,
  MainAxisAlignment alignment,
) =>
    Row(
      mainAxisAlignment: alignment,
      children: [
        buildShimmer(
            width: typeBoxWidth,
            height: typeBoxHeight,
            borderRadius: borderRadius),
        SizedBox(width: 10),
        buildShimmer(
            width: typeBoxWidth,
            height: typeBoxHeight,
            borderRadius: borderRadius),
      ],
    );

Widget _buildTypeBoxes(
  List<String> types,
  ThemeData theme,
  double typeBoxWidth,
  double typeBoxHeight,
  double borderRadius,
  MainAxisAlignment alignment,
) =>
    Semantics(
      label: "Pokemon types: ${types.join(", ")}",
      child: Row(
        mainAxisAlignment: alignment,
        children: types
            .map((type) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: _buildTypeBox(
                      type, theme, typeBoxWidth, typeBoxHeight, borderRadius),
                ))
            .toList(),
      ),
    );

Widget _buildTypeBox(
  String type,
  ThemeData theme,
  double typeBoxWidth,
  double typeBoxHeight,
  double borderRadius,
) =>
    Stack(
      alignment: Alignment.center,
      children: [
        RoundedBox(
          width: 100,
          height: 40,
          color: getTypeColor(type),
          borderRadius: borderRadius,
          borderColor: getTypeBorderColor(type),
          borderWidth: 2,
          child: _buildTypeText(type, theme),
        ),
      ],
    );

Widget _buildTypeText(String text, ThemeData theme) =>
    Center(child: Text(text, style: theme.textTheme.labelMediumWhite));

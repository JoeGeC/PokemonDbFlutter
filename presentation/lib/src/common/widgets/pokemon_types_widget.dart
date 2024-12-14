import 'package:flutter/material.dart';
import 'package:presentation/src/common/text_theme.dart';
import 'package:presentation/src/common/utils/extensions.dart';
import 'package:presentation/src/common/widgets/rounded_box.dart';
import 'package:presentation/src/common/widgets/shimmer.dart';

import '../type_colors.dart';

Widget buildPokemonTypes(
    {required List<String>? types,
    required BuildContext context,
    double typeBoxWidth = 120,
    double typeBoxHeight = 40,
    double borderRadius = 4,
    MainAxisAlignment alignment = MainAxisAlignment.start}) {
  if (types == null) {
    return _buildFallBacks(
      context.theme,
      typeBoxWidth,
      typeBoxHeight,
      borderRadius,
      alignment,
    );
  }
  return types.isEmpty
      ? _buildFallBacks(
          context.theme,
          typeBoxWidth,
          typeBoxHeight,
          borderRadius,
          alignment,
        )
      : _buildTypeBoxes(
          types,
          context,
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
  BuildContext context,
  double typeBoxWidth,
  double typeBoxHeight,
  double borderRadius,
  MainAxisAlignment alignment,
) =>
    Semantics(
      label: "${context.localizations.pokemonTypes}: ${types.join(", ")}",
      child: Row(
        mainAxisAlignment: alignment,
        children: types
            .map((type) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: _buildTypeBox(
                      type, context, typeBoxWidth, typeBoxHeight, borderRadius),
                ))
            .toList(),
      ),
    );

Widget _buildTypeBox(
  String type,
  BuildContext context,
  double typeBoxWidth,
  double typeBoxHeight,
  double borderRadius,
) =>
    Stack(
      alignment: Alignment.center,
      children: [
        RoundedBox(
          width: typeBoxWidth,
          height: typeBoxHeight,
          color: getTypeColor(type, context.localizations),
          borderRadius: borderRadius,
          borderColor: getTypeBorderColor(type, context.localizations),
          borderWidth: 2,
          child: _buildTypeText(type, context.theme),
        ),
      ],
    );

Widget _buildTypeText(String text, ThemeData theme) =>
    Center(child: Text(text, style: theme.textTheme.labelMediumWhite));

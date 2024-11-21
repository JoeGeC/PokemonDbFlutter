import 'package:flutter/material.dart';

Widget buildPokemonTypes(List<String>? types, ThemeData theme) {
  if (types == null) return _buildFallBacks();
  return types.isEmpty
      ? _buildUnknownTypeBox(theme)
      : _buildTypeBoxes(types, theme);
}

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
      children: [
        _buildTypeFallBack(), //TODO: Change this
        _buildCenterText(type, theme),
      ],
    );

Widget _buildUnknownTypeBox(ThemeData theme) => Stack(
      children: [
        _buildTypeFallBack(),
        _buildCenterText("?", theme),
      ],
    );

Positioned _buildCenterText(String text, ThemeData theme) => Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: theme.textTheme.displayMedium!.copyWith(),
        ),
      ),
    );

Widget _buildFallBacks() => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTypeFallBack(),
        SizedBox(width: 10),
        _buildTypeFallBack(),
      ],
    );

Widget _buildTypeFallBack() => FittedBox(
      fit: BoxFit.fill,
      child: Image(
          image: AssetImage('assets/pokemon_type_fallback.png'),
          opacity: const AlwaysStoppedAnimation(.4),
          height: 40,
          width: 80),
    );

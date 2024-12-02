import 'package:flutter/material.dart';

extension CustomStyles on TextTheme {
  TextStyle get labelMediumBold =>
      labelMedium?.copyWith(fontWeight: FontWeight.bold, shadows: []) ??
      TextStyle();

  TextStyle get labelMediumWhite =>
      labelMedium?.copyWith(
          color: Colors.white, shadows: mediumTextShadowBlackTransparent) ??
      TextStyle();
}

TextStyle headlineTextStyle(ColorScheme colorScheme) => TextStyle(
      fontFamily: 'PokemonBW',
      color: colorScheme.onPrimary,
      shadows: mediumTextShadowBlack,
    );

TextStyle titleTextStyle(ColorScheme colorScheme) => TextStyle(
      fontFamily: 'PokemonBW',
      color: colorScheme.onSurface,
      shadows: mediumTextShadow(colorScheme),
    );

TextStyle labelTextStyle(ColorScheme colorScheme) => TextStyle(
      fontFamily: 'PokemonBW',
      color: colorScheme.onSurface,
      shadows: mediumTextShadow(colorScheme),
    );

List<Shadow> mediumTextShadow(ColorScheme colorScheme) => [
      Shadow(
        offset: Offset(2.0, 2.0),
        color: colorScheme.shadow,
      )
    ];

const List<Shadow> mediumTextShadowBlack = [
      Shadow(
        offset: Offset(2.0, 2.0),
        color: Colors.black,
      )
    ];

const List<Shadow> mediumTextShadowBlackTransparent = [
      Shadow(
        offset: Offset(2.0, 2.0),
        color: Color(0x80000000),
      )
    ];

List<Shadow> smallTextShadow(ColorScheme colorScheme) => [
      Shadow(
        offset: Offset(1.0, 1.0),
        color: colorScheme.shadow,
      )
    ];

import 'package:flutter/material.dart';
import 'package:pokemon_db/theme/colors.dart';

TextStyle labelMedium = TextStyle(
  fontSize: 40,
  fontFamily: 'PokemonBW',
  color: currentColorScheme.onSurface,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      color: Color.fromARGB(255, 180, 180, 180),
    ),
  ],
);

TextStyle titleMedium = TextStyle(
  fontSize: 60,
  fontFamily: 'PokemonBW',
  color: currentColorScheme.onPrimary,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);

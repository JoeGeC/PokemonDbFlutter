import 'package:flutter/material.dart';

Widget buildPokemonTypes() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTypeFallBack(),
      SizedBox(width: 10),
      buildTypeFallBack(),
    ],
  );
}

Widget buildTypeFallBack() {
  return FittedBox(
    fit: BoxFit.fill,
    child: Image(
        image: AssetImage('assets/pokemon_type_fallback.png'),
        opacity: const AlwaysStoppedAnimation(.4),
        height: 40,
        width: 80),
  );
}

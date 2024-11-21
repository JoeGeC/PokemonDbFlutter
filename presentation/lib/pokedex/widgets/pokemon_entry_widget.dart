import 'package:flutter/material.dart';

import '../../common/widgets/pokemon_types_widget.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

Widget buildPokemonEntry(
        PokedexPokemonPresentationModel pokemon, ThemeData theme) =>
    Padding(
      padding: EdgeInsets.all(8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage('assets/pokeball_background.png'),
              opacity: const AlwaysStoppedAnimation(.4),
              height: 100,
              width: 100,
            ),
            SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      pokemon.pokedexEntryNumber,
                      style: theme.textTheme.labelMedium!.copyWith(),
                    ),
                    SizedBox(width: 10),
                    Text(
                      pokemon.name,
                      style: theme.textTheme.labelMedium!.copyWith(),
                    ),
                  ],
                ),
                buildPokemonTypes()
              ],
            )
          ],
        ),
      ),
    );

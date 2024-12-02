import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/pokedex/widgets/pokemon_image_with_background.dart';

import '../../common/widgets/pokemon_types_widget.dart';
import '../../common/widgets/two_spaced_texts_row.dart';
import '../../injections.dart';
import '../bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

Widget buildPokemonEntry(
        PokedexPokemonPresentationModel pokemon, int pokedexId, ThemeData theme,
        {double imageSize = 100}) =>
    BlocProvider(
      create: (_) => PokedexPokemonBloc(getIt(), getIt())
        ..add(GetPokedexPokemonEvent(pokemon, pokedexId)),
      child: BlocBuilder<PokedexPokemonBloc, PokedexPokemonState>(
        builder: (context, state) {
          switch (state) {
            case PokedexPokemonSuccessState():
              return pokemonEntryWidget(state, state.pokemon, theme,
                  imageSize: imageSize);
            default:
              return pokemonEntryWidget(state, pokemon, theme,
                  imageSize: imageSize);
          }
        },
      ),
    );

Widget pokemonEntryWidget(
  PokedexPokemonState state,
  PokedexPokemonPresentationModel pokemon,
  ThemeData theme, {
  double imageSize = 100,
}) =>
    Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPokemonImageWithBackground(state, pokemon.imageUrl,
              size: imageSize),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TwoSpacedTextsRow(pokemon.pokedexEntryNumber, pokemon.name,
                    theme.textTheme.titleMedium!),
                buildPokemonTypes(types: pokemon.types, theme: theme)
              ],
            ),
          ),
        ],
      ),
    );

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/pokedex/widgets/pokemon_image_with_background.dart';

import '../../common/widgets/pokemon_types_widget.dart';
import '../../common/widgets/two_spaced_texts_row.dart';
import '../../injections.dart';
import '../bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

Widget buildPokemonEntry(
    PokedexPokemonPresentationModel pokemon, int pokedexId, ThemeData theme) {
  return BlocProvider(
    create: (_) => PokedexPokemonBloc(getIt(), getIt()),
    child: BlocBuilder<PokedexPokemonBloc, PokedexPokemonState>(
      builder: (context, state) {
        final pokemonBloc = context.read<PokedexPokemonBloc>();
        getPokemonOnStart(state, pokemonBloc, pokemon, pokedexId);
        if (state is PokedexPokemonSuccessState) {
          return pokemonEntryWidget(state, state.pokemon, theme);
        }
        return pokemonEntryWidget(state, pokemon, theme);
      },
    ),
  );
}

void getPokemonOnStart(
    PokedexPokemonState state,
    PokedexPokemonBloc pokemonBloc,
    PokedexPokemonPresentationModel pokemon,
    int pokedexId) {
  if (state is PokedexPokemonInitialState) {
    pokemonBloc.add(GetPokedexPokemonEvent(pokemon.id, pokedexId));
  }
}

Widget pokemonEntryWidget(PokedexPokemonState state,
        PokedexPokemonPresentationModel pokemon, ThemeData theme) =>
    Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPokemonImageWithBackground(state, pokemon.imageUrl),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TwoSpacedTextsRow(pokemon.pokedexEntryNumber, pokemon.name,
                    theme.textTheme.titleMedium!),
                buildPokemonTypes(pokemon.types, theme)
              ],
            ),
          ),
        ],
      ),
    );

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/common/utils/extensions.dart';
import 'package:presentation/src/common/widgets/pokemon_image_with_background.dart';

import '../../common/bloc/base_state.dart';
import '../../common/widgets/pokemon_types_widget.dart';
import '../../common/widgets/two_spaced_texts_row.dart';
import '../../injections.dart';
import '../bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

Widget buildPokemonEntry(PokedexPokemonPresentationModel pokemon, int pokedexId,
        {double imageSize = 100}) =>
    BlocProvider(
      create: (_) => PokedexPokemonBloc(getIt(), getIt())
        ..add(GetPokedexPokemonEvent(pokemon, pokedexId)),
      child: BlocBuilder<PokedexPokemonBloc, BaseState>(
        builder: (context, state) {
          switch (state) {
            case PokedexPokemonSuccessState():
              return pokemonEntryWidget(state, state.pokemon, context,
                  imageSize: imageSize);
            default:
              return pokemonEntryWidget(state, pokemon, context,
                  imageSize: imageSize);
          }
        },
      ),
    );

Widget pokemonEntryWidget(
  BaseState state,
  PokedexPokemonPresentationModel pokemon,
  BuildContext context, {
  double imageSize = 100,
}) =>
    Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPokemonImageWithBackground(
              state, pokemon.imageUrl, context, pokemon.name,
              size: imageSize),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPokedexNumberAndName(pokemon, context),
                buildPokemonTypes(types: pokemon.types, context: context)
              ],
            ),
          ),
        ],
      ),
    );

Widget buildPokedexNumberAndName(
        PokedexPokemonPresentationModel pokemon, BuildContext context) =>
    TwoSpacedTextsRow(
      label1: pokemon.pokedexEntryNumber,
      label2: pokemon.name,
      textStyle: context.theme.textTheme.titleMedium!,
      semanticsLabel:
          "${context.localizations.pokedexEntryNumber} ${pokemon.pokedexEntryNumber}, ${context.localizations.pokemonName}: ${pokemon.name}",
    );

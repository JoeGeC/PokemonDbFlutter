import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/assetConstants.dart';
import '../bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';

Widget buildPokemonImageWithBackground(
    PokedexPokemonState state, String? imageUrl) {
  return Stack(
    children: [
      buildPokemonImageBackground(),
      buildPokemonSprite(state, imageUrl)
    ],
  );
}

Image buildPokemonImageBackground() => Image(
      image: AssetImage(AssetConstants.pokeballBackground),
      opacity: const AlwaysStoppedAnimation(.4),
      height: 100,
      width: 100,
    );

Image buildPokemonFallback(String asset) => Image(
      image: AssetImage(asset),
      height: 100,
      width: 100,
    );

Widget buildPokemonSprite(PokedexPokemonState state, String? imageUrl) =>
    switch (state) {
      PokedexPokemonInitialState() =>
        _buildLoadingFallback(),
      PokedexPokemonLoadingState() =>
        _buildLoadingFallback(),
      PokedexPokemonSuccessState() => buildPokemonSpriteFromUrl(imageUrl),
      _ => buildPokemonFallback(AssetConstants.missingno)
    };

Widget buildPokemonSpriteFromUrl(String? imageUrl) {
  if (imageUrl == null) return buildPokemonFallback(AssetConstants.missingno);
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    frameBuilder: (context, child, frame, sync) {
      if (frame == null) return _buildLoadingFallback();
      return child;
    },
    errorBuilder: (context, error, stackTrace) {
      return buildPokemonFallback(AssetConstants.missingno);
    },
  );
}

Image _buildLoadingFallback() {
  return buildPokemonFallback(AssetConstants.pokemonFallback);
}

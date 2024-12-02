import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/assetConstants.dart';
import '../bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';

Widget buildPokemonImageWithBackground(
    PokedexPokemonState state, String? imageUrl,
    {double size = 100}) {
  return Stack(
    children: [
      buildPokemonImageBackground(size),
      buildPokemonSprite(state, imageUrl, size)
    ],
  );
}

Image buildPokemonImageBackground(double size) => Image(
      image: AssetImage(AssetConstants.pokeballBackground),
      opacity: const AlwaysStoppedAnimation(.4),
      height: size,
      width: size,
    );

Image buildPokemonFallback(String asset, double size) => Image(
      image: AssetImage(asset),
      height: size,
      width: size,
    );

Widget buildPokemonSprite(
        PokedexPokemonState state, String? imageUrl, double size) =>
    switch (state) {
      PokedexPokemonInitialState() => _buildLoadingFallback(size),
      PokedexPokemonLoadingState() => _buildLoadingFallback(size),
      PokedexPokemonSuccessState() => buildPokemonSpriteFromUrl(imageUrl, size),
      _ => buildPokemonFallback(AssetConstants.missingno, size)
    };

Widget buildPokemonSpriteFromUrl(String? imageUrl, double size) {
  if (imageUrl == null) {
    return buildPokemonFallback(AssetConstants.missingno, size);
  }
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    frameBuilder: (context, child, frame, sync) {
      if (frame == null) return _buildLoadingFallback(size);
      return child;
    },
    errorBuilder: (context, error, stackTrace) {
      return buildPokemonFallback(AssetConstants.missingno, size);
    },
  );
}

Image _buildLoadingFallback(double size) =>
    buildPokemonFallback(AssetConstants.pokemonFallback, size);

import 'package:flutter/cupertino.dart';

import '../../common/assetConstants.dart';
import '../bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';

Widget buildPokemonImageWithBackground(PokedexPokemonState state, String? imageUrl) {
  return Stack(
    children: [
      buildPokemonImageBackground(),
      buildPokemonSprite(state, imageUrl)
    ],
  );
}

Image buildPokemonImageBackground() => Image(
  image: AssetImage('assets/pokeball_background.png'),
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
      PokedexPokemonInitialState() => buildPokemonFallback(AssetConstants.pokemonFallback),
      PokedexPokemonLoadingState() => buildPokemonFallback(AssetConstants.pokemonFallback),
      PokedexPokemonSuccessState() => buildPokemonSpriteFromUrl(imageUrl),
      _ => buildPokemonFallback(AssetConstants.missingno)
    };

Widget buildPokemonSpriteFromUrl(String? imageUrl) {
  if (imageUrl == null) return buildPokemonFallback(AssetConstants.missingno);
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return buildPokemonFallback(AssetConstants.pokemonFallback);
    },
    errorBuilder: (context, error, stackTrace) {
      return buildPokemonFallback(AssetConstants.missingno);
    },
  );
}
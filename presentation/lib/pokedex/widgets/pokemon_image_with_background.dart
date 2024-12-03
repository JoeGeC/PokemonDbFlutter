import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/utils/extensions.dart';
import 'package:presentation/common/utils/is_dark_mode.dart';

import '../../common/asset_constants.dart';
import '../../common/bloc/base_state.dart';
import '../bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';

Widget buildPokemonImageWithBackground(
    BaseState state, String? imageUrl, ThemeData theme, BuildContext context,
    {double size = 100}) {
  return Stack(
    children: [
      buildPokemonImageBackground(size, theme),
      buildPokemonSprite(state, imageUrl, size, context)
    ],
  );
}

Image buildPokemonImageBackground(double size, ThemeData theme) => Image(
      image: AssetImage(AssetConstants.pokeballBackground(isDarkMode(theme))),
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
        BaseState state, String? imageUrl, double size, BuildContext context) =>
    switch (state) {
      PokedexPokemonInitialState() => _buildLoadingFallback(size),
      LoadingState() => _buildLoadingFallback(size),
      PokedexPokemonSuccessState() =>
        buildPokemonSpriteFromUrl(imageUrl, size, context),
      _ => buildPokemonFallback(AssetConstants.missingno, size)
    };

Widget buildPokemonSpriteFromUrl(
    String? imageUrl, double size, BuildContext context) {
  if (imageUrl == null) {
    return buildPokemonFallback(AssetConstants.missingno, size);
  }
  return CachedNetworkImage(
    imageUrl: imageUrl,
    memCacheHeight: size.cacheSize(context),
    memCacheWidth: size.cacheSize(context),
    placeholder: (context, url) => _buildLoadingFallback(size),
    errorWidget: (context, url, error) =>
        buildPokemonFallback(AssetConstants.missingno, size),
  );
}

Image _buildLoadingFallback(double size) =>
    buildPokemonFallback(AssetConstants.pokemonFallback, size);

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation/common/utils/extensions.dart';
import 'package:presentation/common/utils/is_dark_mode.dart';

import '../asset_constants.dart';
import '../bloc/base_state.dart';

Widget buildPokemonImageWithBackground(
  BaseState state,
  String? imageUrl,
  ThemeData theme,
  BuildContext context,
  String pokemonName, {
  double size = 100,
}) =>
    Semantics(
      label: "$pokemonName image",
      child: Stack(
        children: [
          buildPokemonImageBackground(size, theme),
          buildPokemonSprite(state, imageUrl, size, context)
        ],
      ),
    );

Widget buildPokemonImageBackground(double size, ThemeData theme) => Opacity(
      opacity: 0.4,
      child: SvgPicture.asset(
        AssetConstants.pokeballBackground(isDarkMode(theme)),
        height: size,
        width: size,
      ),
    );

Image buildPokemonFallback(String asset, double size) => Image(
      image: AssetImage(asset),
      height: size,
      width: size,
    );

Widget buildPokemonSprite(
        BaseState state, String? imageUrl, double size, BuildContext context) =>
    switch (state) {
      InitialState() => _buildLoadingFallback(size),
      LoadingState() => _buildLoadingFallback(size),
      SuccessState() => buildPokemonSpriteFromUrl(imageUrl, size, context),
      _ => buildPokemonFallback(AssetConstants.missingno, size)
    };

Widget buildPokemonSpriteFromUrl(
    String? imageUrl, double size, BuildContext context) {
  if (imageUrl == null) {
    return buildPokemonFallback(AssetConstants.missingno, size);
  }
  return CachedNetworkImage(
    width: size,
    height: size,
    imageUrl: imageUrl,
    memCacheHeight: size.cacheSize(context),
    memCacheWidth: size.cacheSize(context),
    placeholder: (context, url) => _buildLoadingFallback(size),
    errorWidget: (context, url, error) =>
        buildPokemonFallback(AssetConstants.missingno, size),
  );
}

Widget _buildLoadingFallback(double size) =>
    buildPokemonFallback(AssetConstants.pokemonFallback, size);

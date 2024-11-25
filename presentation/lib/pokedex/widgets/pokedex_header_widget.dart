import 'package:flutter/material.dart';
import 'package:presentation/common/assetConstants.dart';

Widget buildPokedexHeader(ThemeData theme, GlobalKey key, String pokedexName) =>
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetConstants.pokedexHeaderBackground),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        pokedexName,
        key: key,
        style: theme.textTheme.headlineMedium!.copyWith(),
        textAlign: TextAlign.center,
      ),
    );

import 'package:flutter/material.dart';

Widget buildPokedexHeader(ThemeData theme, GlobalKey key, String pokedexName) =>
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/pokedex_header_background.png'),
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

import 'package:flutter/material.dart';

import '../../common/widgets/header.dart';
import '../../common/widgets/menu_icon_button.dart';

Widget buildPokedexHeader(ThemeData theme, GlobalKey key, String pokedexName,
        GlobalKey<ScaffoldState> scaffoldKey) =>
    buildHeader(
      child: Row(
        children: [
          buildMenuIconButton(scaffoldKey),
          Text(
            pokedexName,
            key: key,
            style: theme.textTheme.headlineMedium!.copyWith(),
          ),
        ],
      ),
    );

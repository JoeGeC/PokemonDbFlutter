import 'package:flutter/material.dart';

import '../assetConstants.dart';

Widget buildHeader({Widget? child, String? backgroundAsset}) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundAsset ?? AssetConstants.pokedexHeaderBackground),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );

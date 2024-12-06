import 'package:flutter/material.dart';

import '../asset_constants.dart';
import '../utils/is_dark_mode.dart';

Widget buildRefreshablePageWithBackground({
  required ThemeData theme,
  required BuildContext context,
  double headerHeight = 80.0,
  Widget? title,
  Widget? body,
}) =>
    Stack(
      children: [
        _buildBackground(theme),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title ?? Container(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - headerHeight,
                ),
                child: body ?? Container(),
              ),
            ],
          ),
        ),
      ],
    );

Positioned _buildBackground(ThemeData theme) => Positioned.fill(
      child: Image.asset(
        AssetConstants.pokedexBackground(isDarkMode(theme)),
        fit: BoxFit.cover,
      ),
    );

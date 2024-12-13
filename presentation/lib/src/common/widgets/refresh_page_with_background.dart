import 'package:flutter/material.dart';
import 'package:presentation/src/common/utils/extensions.dart';

import '../asset_constants.dart';

Widget buildRefreshablePageWithBackground({
  required BuildContext context,
  double headerHeight = 80.0,
  Widget? title,
  Widget? body,
}) =>
    Stack(
      children: [
        _buildBackground(context.isDarkMode),
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

Positioned _buildBackground(bool isDarkMode) => Positioned.fill(
      child: Image.asset(
        AssetConstants.pokedexBackground(isDarkMode),
        fit: BoxFit.cover,
      ),
    );

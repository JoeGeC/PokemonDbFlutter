import 'package:flutter/material.dart';

import '../../common/widgets/header.dart';
import '../../common/widgets/menu_icon_button.dart';

Widget buildPokedexHeader({
  GlobalKey<ScaffoldState>? scaffoldKey,
  Widget? title,
  double height = 80,
  double horizontalPadding = 16,
}) =>
    SizedBox(
      height: height,
      child: buildHeader(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              if (scaffoldKey != null) buildMenuIconButton(scaffoldKey),
              title ?? Container(),
            ],
          ),
        ),
      ),
    );

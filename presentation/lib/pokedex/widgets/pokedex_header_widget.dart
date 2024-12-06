import 'package:flutter/material.dart';

import '../../common/widgets/header.dart';
import '../../common/widgets/menu_icon_button.dart';

Widget buildPokedexHeader({
  Widget? icon,
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
              icon ?? Container(),
              SizedBox(width: 40),
              title ?? Container(),
            ],
          ),
        ),
      ),
    );

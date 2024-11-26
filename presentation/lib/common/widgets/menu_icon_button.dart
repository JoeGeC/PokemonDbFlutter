import 'package:flutter/material.dart';

Widget buildMenuIconButton(GlobalKey<ScaffoldState> scaffoldKey) => Padding(
  padding: const EdgeInsets.only(right: 16, top: 8),
  child: Stack(
    alignment: Alignment.center,
    children: [
      Padding(
          padding: const EdgeInsets.only(left: 4, top: 4),
          child: Icon(
            Icons.menu,
            size: 30,
            color: Colors.black,
          )),
      IconButton(
        icon: Icon(
          Icons.menu,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
    ],
  ),
);

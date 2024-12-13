import 'package:flutter/material.dart';

Widget buildMenuIconButton({
  required GlobalKey<ScaffoldState> scaffoldKey,
  String toolTip = "Open navigation menu"
}) => Padding(
      padding: const EdgeInsets.only(top: 8),
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
              tooltip: toolTip,
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
    );

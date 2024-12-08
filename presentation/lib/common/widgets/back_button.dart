import 'package:flutter/material.dart';
import 'package:presentation/common/asset_constants.dart';

Widget PixelBackButton({
  double width = 30,
  double height = 30,
  GestureTapCallback? onTap,
}) =>
    Semantics(
      label: "Back button",
      button: onTap == null ? false : true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: SizedBox(
            height: double.infinity,
            width: _getTappableWidth(width, onTap),
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2, left: 2),
                    child: Image.asset(
                      width: width,
                      height: height,
                      AssetConstants.arrow,
                    ),
                  ),
                  Image.asset(
                    width: width,
                    height: height,
                    AssetConstants.arrow,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

double _getTappableWidth(double width, GestureTapCallback? onTap) =>
    (width <= 42.0 && onTap != null) ? 42.0 : width;

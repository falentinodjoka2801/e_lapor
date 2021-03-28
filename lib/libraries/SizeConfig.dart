import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double horizontalBlock;
  static double verticalBlock;
  static double leftAndRightContentContainerPadding;

  void initSize(BuildContext _sizeConfigBuildContext) {
    _mediaQueryData = MediaQuery.of(_sizeConfigBuildContext);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    horizontalBlock = screenWidth / 100;
    verticalBlock = screenHeight / 100;

    leftAndRightContentContainerPadding = horizontalBlock * 4.5;
  }
}

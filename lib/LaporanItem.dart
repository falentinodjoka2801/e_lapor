import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

class LaporanItem extends StatelessWidget {
  final String imageAssetPath;
  final String buttonText;
  final double buttonTextSize;
  final void Function() onButtonTap;

  LaporanItem(
      {@required this.imageAssetPath,
      @required this.buttonText,
      @required this.onButtonTap,
      this.buttonTextSize});

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _imageAndButtonSpace = SizeConfig.horizontalBlock * 5.0;
    double _widthAndHeightImage = SizeConfig.horizontalBlock * 25.0;

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Image.asset(imageAssetPath,
            width: _widthAndHeightImage, height: _widthAndHeightImage),
        SizedBox(height: _imageAndButtonSpace),
        Button.button(context, buttonText, onButtonTap,
            isBlock: true,
            isPill: true,
            color: CustomColors.eLaporGreen,
            elevation: 5.0,
            buttonFontSize: buttonTextSize)
      ]),
    );
  }
}

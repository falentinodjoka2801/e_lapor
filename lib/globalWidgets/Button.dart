import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

class Button {
  static const String lgSize = 'lg'; //+2.5
  static const String mdSize = 'md';
  static const String smSize = 'sm'; //-2.5
  static const String xsSize = 'xs'; //-5

  static Widget button(
      BuildContext parentContext, String text, void Function() onTap,
      {Color color,
      Color borderColor,
      double elevation = 0.0,
      bool isBlock = false,
      bool isBusy = false,
      bool outline = false,
      bool isPill = false,
      bool useBorder = true,
      String size,
      Widget trailing}) {
    SizeConfig().initSize(parentContext);

    borderColor = (borderColor == null) ? Color(0x55e9ecef) : borderColor;
    color = (color == null) ? Color(0xFFe9ecef) : color;
    size = (size == null) ? mdSize : size;

    double pillCorner = SizeConfig.horizontalBlock * 7.5; //ukuran md
    double paddingTopAndBottom = SizeConfig.horizontalBlock * 2.75; //ukuran md
    double paddingLeftAndRight = SizeConfig.horizontalBlock * 6.25;
    double fontSize = SizeConfig.horizontalBlock * 3.5; //ukuran md

    if (size == 'lg') {
      paddingLeftAndRight = paddingLeftAndRight + 2.5;
      fontSize = fontSize + 5;
    }

    if (size == 'sm') {
      paddingLeftAndRight = paddingLeftAndRight - 5;
      fontSize = fontSize - 2.5;
    }

    if (size == 'xs') {
      paddingLeftAndRight = paddingLeftAndRight - 6.25;
      fontSize = fontSize - 3.5;
    }

    Container _buttonContainer = Container(
        width: (isBlock) ? double.infinity : null,
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: (outline) ? color : Colors.white,
                fontSize: fontSize)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ));

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((isPill) ? pillCorner : 7.5),
          border: (useBorder)
              ? Border.all(width: 1, color: (outline) ? color : borderColor)
              : null),
      child: Material(
        color: (outline) ? CustomColors.eLaporWhite : color,
        elevation: elevation,
        borderRadius: BorderRadius.circular((isPill) ? pillCorner : 7.5),
        child: Stack(
          children: [
            InkWell(
                borderRadius:
                    BorderRadius.circular((isPill) ? pillCorner : 7.5),
                splashColor: (outline) ? color : Colors.white,
                onTap: (isBusy) ? null : onTap,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: paddingTopAndBottom,
                        bottom: paddingTopAndBottom,
                        left: paddingLeftAndRight,
                        right: paddingLeftAndRight),
                    child: (isBusy)
                        ? Center(
                            child: SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    CircularProgressIndicator(strokeWidth: .5)))
                        : _buttonContainer)),
            (trailing != null)
                ? Positioned(
                    right: 15.0, top: 0.0, bottom: 0.0, child: trailing)
                : SizedBox()
          ],
        ),
      ),
    );
  }

  static Widget submitButton(
      BuildContext parentContext, String text, void Function() onTap,
      {Color color,
      Color borderColor,
      double borderWidth = 1.0,
      double elevation = 0.0,
      bool isBusy = false,
      bool outline = false,
      bool useBorder = true,
      Widget trailing}) {
    SizeConfig().initSize(parentContext);

    color = (color == null) ? Color(0xFFe9ecef) : color;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.5),
          border: (borderWidth != null && borderColor != null)
              ? Border.all(
                  width: borderWidth, color: (outline) ? color : borderColor)
              : null),
      child: Material(
        color: (outline) ? CustomColors.eLaporWhite : color,
        elevation: elevation,
        borderRadius: BorderRadius.circular(7.5),
        child: Stack(
          children: [
            InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(7.5),
                splashColor: (outline) ? color : CustomColors.eLaporWhite,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.horizontalBlock * 4.6,
                        bottom: SizeConfig.horizontalBlock * 4.6),
                    child: (isBusy)
                        ? Center(
                            child: SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    CircularProgressIndicator(strokeWidth: .5)))
                        : Container(
                            width: double.infinity,
                            child: Text(text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: (outline)
                                        ? color
                                        : CustomColors.eLaporWhite,
                                    fontSize:
                                        SizeConfig.horizontalBlock * 3.75)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            )))),
            (trailing != null)
                ? Positioned(
                    right: 15.0, top: 0.0, bottom: 0.0, child: trailing)
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

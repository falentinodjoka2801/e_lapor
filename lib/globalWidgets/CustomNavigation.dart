import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/material.dart';

class CustomNavigation {
  static AppBar appBar(
      {@required String title,
      Color backgroundColor,
      double elevation = 0.0,
      List<Widget> actions}) {
    Color _backgroundColor = CustomColors.eLaporGreen;
    if (backgroundColor != null) {
      _backgroundColor = backgroundColor;
    }

    return AppBar(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
      elevation: elevation,
      backgroundColor: _backgroundColor,
      actions: (actions != null) ? actions : [],
    );
  }
}

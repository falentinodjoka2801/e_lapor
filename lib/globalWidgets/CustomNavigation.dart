import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

class CustomNavigation {
  static AppBar appBar(
      {@required BuildContext appBarContext,
      @required String title,
      Color backgroundColor,
      double elevation = 0.0,
      List<Widget> actions}) {
    Color _backgroundColor = CustomColors.eLaporGreen;
    if (backgroundColor != null) {
      _backgroundColor = backgroundColor;
    }

    SizeConfig().initSize(appBarContext);

    return AppBar(
        elevation: elevation,
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _backgroundColor,
        actions: actions);
  }
}

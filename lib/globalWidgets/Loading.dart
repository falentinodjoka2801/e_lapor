import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';

class Loading extends StatelessWidget {
  final String loadingTitle;
  final String loadingSubTitle;
  Loading({this.loadingTitle, this.loadingSubTitle});
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: SizeConfig.horizontalBlock * 7.5,
            height: SizeConfig.horizontalBlock * 7.5,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              backgroundColor: Colors.transparent,
              valueColor:
                  AlwaysStoppedAnimation<Color>(CustomColors.eLaporGreen),
            )),
        (loadingTitle != null)
            ? Padding(
                padding: EdgeInsets.only(top: SizeConfig.horizontalBlock * 6.5),
                child: Text(loadingTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeConfig.horizontalBlock * 4.0,
                        fontWeight: FontWeight.w500)))
            : SizedBox(),
        (loadingSubTitle != null)
            ? Padding(
                padding: EdgeInsets.only(top: SizeConfig.horizontalBlock * 1.5),
                child: Text(loadingSubTitle,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: SizeConfig.horizontalBlock * 3.25)))
            : SizedBox()
      ],
    ));
  }
}

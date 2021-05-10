import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DataNotFound extends StatelessWidget {
  final String textMessage;
  DataNotFound({this.textMessage = ''});
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          SvgPicture.asset(ClientPath.svgPath + '/sad.svg',
              color: CustomColors.eLaporGreen),
          SizedBox(height: 30.0),
          Text(textMessage,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0))
        ]));
  }
}

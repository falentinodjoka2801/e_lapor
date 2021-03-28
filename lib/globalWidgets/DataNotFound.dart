import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:flutter/material.dart';

class DataNotFound extends StatelessWidget {
  final String textMessage;
  DataNotFound({this.textMessage = ''});
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image.asset(ClientPath.iconPath + '/sad.png'),
      SizedBox(height: 30.0),
      Text(textMessage,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0))
    ]));
  }
}

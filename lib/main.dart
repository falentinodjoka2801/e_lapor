import 'package:e_lapor/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Lapor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          platform: TargetPlatform.macOS,
          primarySwatch: Colors.blue,
          fontFamily: 'QuickSand'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Login();
  }
}

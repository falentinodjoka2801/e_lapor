import 'dart:io';

import 'package:e_lapor/Future/AuthFuture.dart';
import 'package:e_lapor/GPSGrantPermission.dart';
import 'package:e_lapor/Login.dart';
import 'package:e_lapor/MyHomePage.dart';
import 'package:e_lapor/globalWidgets/Loading.dart';
import 'package:e_lapor/libraries/LocalStorage.dart';
import 'package:e_lapor/libraries/LocationService.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _initialization();
  }

  Future<void> _initialization() async {
    bool _isLogin = await AuthFuture.isLoggedIn();

    if (_isLogin) {
      Map<String, double> _currentLocation =
          await LocationService.detectCurrentLocation();

      if (_currentLocation != null) {
        double _latitude = _currentLocation['latitude'];
        double _longitude = _currentLocation['longitude'];
        await LocalStorage.setSavedLocation(_latitude, _longitude);

        await Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => MyHomePage()), (route) => false);
      } else {
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => GPSGrantPermission(
                    abaikanOnClick: () => (Platform.isAndroid)
                        ? SystemNavigator.pop()
                        : exit(0))),
            (route) => false);
      }
    } else {
      await Future.delayed(Duration(seconds: 2));
      await Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => Login()), (route) => false);
    }
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _circularWidth = SizeConfig.horizontalBlock * 3.5;

    return Scaffold(
        body: Stack(children: [
      Center(
        child: Image.asset(ClientPath.iconPath + '/elapor-opt-dpi.png',
            width: SizeConfig.horizontalBlock * 70.0),
      ),
      Positioned(
          left: 0,
          right: 0,
          bottom: SizeConfig.verticalBlock * 5.0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.horizontalBlock * 15.0),
            child: FutureBuilder<bool>(
                future: AuthFuture.isLoggedIn(),
                builder: (futureBuilderContext, snapshot) {
                  if (snapshot.hasData) {
                    bool _isLogin = snapshot.data;

                    return (_isLogin)
                        ? Loading(
                            loadingTitle: 'Pendeteksian Lokasi',
                            loadingSubTitle:
                                'Mohon tunggu sebentar, aplikasi sedang mencoba mendeteksi lokasi anda saat ini')
                        : SizedBox();
                  } else {
                    return Center(
                        child: SizedBox(
                            width: _circularWidth,
                            height: _circularWidth,
                            child:
                                CircularProgressIndicator(strokeWidth: 1.5)));
                  }
                }),
          ))
    ]));
  }
}

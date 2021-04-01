import 'package:e_lapor/GPSGrantPermission.dart';
import 'package:e_lapor/libraries/LocationService.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/Navigation/TabNavigator.dart';
import 'package:e_lapor/Navigation/TabItem.dart';

class AuthenticatedPages extends StatelessWidget {
  final TabItem currentTab;
  AuthenticatedPages({@required this.currentTab});

  Widget build(BuildContext context) {
    TabItem _currentTab = currentTab;

    return FutureBuilder<bool>(
        future: LocationService.isLocationServiceActive(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? (snapshot.data)
                  ? Stack(children: [
                      _buildBody(TabItem.beranda, _currentTab),
                      _buildBody(TabItem.laporanKu, _currentTab),
                      _buildBody(TabItem.akun, _currentTab)
                    ])
                  : GPSGrantPermission()
              : Center(
                  child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(strokeWidth: 1.5)));
        });
  }

  Widget _buildBody(TabItem tabItem, TabItem currentTab) {
    return Offstage(
        offstage: currentTab != tabItem,
        child: TabNavigator(
            navigatorKey: navigatesKey[tabItem], tabItem: tabItem));
  }
}

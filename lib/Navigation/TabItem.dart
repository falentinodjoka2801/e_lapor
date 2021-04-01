import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
// import 'package:e_lapor/libraries/CustomColors.dart';

import 'package:e_lapor/Beranda.dart';
import 'package:e_lapor/DetailAkun.dart';
import 'package:e_lapor/Laporanku.dart';
// import 'package:e_lapor/FilterPencarian.dart';

// import 'package:e_lapor/globalWidgets/Button.dart';
// import 'package:e_lapor/globalWidgets/Alert.dart';

enum TabItem { beranda, laporanKu, akun }

Map<TabItem, String> tabName = {
  TabItem.beranda: 'beranda',
  TabItem.laporanKu: 'laporan ku',
  TabItem.akun: 'akun'
};

Map<TabItem, String> tabIcon = {
  TabItem.beranda: ClientPath.tabbarIconPath + '/home_white.png',
  TabItem.laporanKu: ClientPath.tabbarIconPath + '/folder_white.png',
  TabItem.akun: ClientPath.tabbarIconPath + '/user_white.png'
};

Map<TabItem, String> tabIconActive = {
  TabItem.beranda: ClientPath.tabbarIconPath + '/home.png',
  TabItem.laporanKu: ClientPath.tabbarIconPath + '/folder.png',
  TabItem.akun: ClientPath.tabbarIconPath + '/user.png'
};

Map<TabItem, Widget> tabRootWidget = {
  TabItem.beranda: Beranda(),
  TabItem.laporanKu: LaporanKu(),
  TabItem.akun: DetailAkun()
};

/*
Map<TabItem, Map<String, dynamic>> tabSetting = {
  TabItem.auth: {'showAppBar': false, 'showBottomNavigationBar': false},
  TabItem.beranda: {'showAppBar': false, 'showBottomNavigationBar': true},
  TabItem.laporanKu: {
    'showAppBar': true,
    'appBarSetting': {
      'title': 'Laporan Ku',
      'backgroundColor': CustomColors.eLaporGreen,
      'actions': <Widget>[
        Builder(builder: (builderContext) {
          return IconButton(
              icon: Icon(LineIcons.filter, color: CustomColors.eLaporWhite),
              onPressed: () async {
                Widget _body = FilterPencarian();
                Widget _actions = Column(children: [
                  Button.submitButton(builderContext, 'TERAPKAN', () {
                    Navigator.pop(builderContext, true);
                  },
                      color: CustomColors.eLaporGreen,
                      trailing: Icon(Icons.arrow_forward_ios_sharp,
                          color: CustomColors.eLaporWhite)),
                  SizedBox(height: 5.0),
                  Button.submitButton(builderContext, 'BERSIHKAN FILTER', () {
                    Navigator.pop(builderContext, false);
                  },
                      color: CustomColors.eLaporRed,
                      outline: true,
                      useBorder: false),
                ]);
                bool _response = await Alert.widgetComponent(builderContext,
                    isDismissible: true,
                    icon: ClientPath.iconPath + '/search.png',
                    body: _body,
                    actions: _actions);
                print(_response);
              });
        })
      ]
    },
    'showBottomNavigationBar': true
  },
  TabItem.akun: {
    'showAppBar': true,
    'appBarSetting': {
      'title': 'Akun',
      'backgroundColor': CustomColors.eLaporGreen,
      'actions': <Widget>[]
    },
    'showBottomNavigationBar': true
  }
};
*/

Map<TabItem, GlobalKey<NavigatorState>> navigatesKey = {
  TabItem.beranda: GlobalKey<NavigatorState>(),
  TabItem.laporanKu: GlobalKey<NavigatorState>(),
  TabItem.akun: GlobalKey<NavigatorState>(),
};

Map<TabItem, String> tabTooltip = {
  TabItem.beranda: 'Halaman Beranda',
  TabItem.laporanKu: 'Halaman Laporan',
  TabItem.akun: 'Halaman Akun',
};

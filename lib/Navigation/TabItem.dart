import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';

import 'package:e_lapor/Beranda.dart';
import 'package:e_lapor/DetailAkun.dart';
import 'package:e_lapor/Laporanku.dart';

enum TabItem { beranda, laporanKu, akun }

Map<TabItem, String> tabName = {
  TabItem.beranda: 'beranda',
  TabItem.laporanKu: 'laporan ku',
  TabItem.akun: 'akun'
};

Map<TabItem, String> tabIcons = {
  TabItem.beranda: ClientPath.tabbarIconPath + '/home.svg',
  TabItem.laporanKu: ClientPath.tabbarIconPath + '/folder.svg',
  TabItem.akun: ClientPath.tabbarIconPath + '/user.svg'
};

Map<TabItem, Widget> tabRootWidget = {
  TabItem.beranda: Beranda(),
  TabItem.laporanKu: LaporanKu(),
  TabItem.akun: DetailAkun()
};

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

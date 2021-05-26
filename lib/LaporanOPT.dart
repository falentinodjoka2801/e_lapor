import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/TambahLaporan.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/LaporanItem.dart';

import 'package:e_lapor/libraries/ClientPath.dart';

class LaporanOPT extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 15.0,
        children: [
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image3.png',
              buttonText: 'LAPOR',
              onButtonTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          TambahLaporan(tabItem: TabItem.beranda)))),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image4.png',
              buttonText: 'REKAPITULASI',
              onButtonTap: () => null)
        ]);
  }
}

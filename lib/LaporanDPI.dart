import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/LaporanItem.dart';

class LaporanDPI extends StatelessWidget {
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
              imageAssetPath: ClientPath.iconPath + '/image5.png',
              buttonText: 'BANJIR',
              onButtonTap: () => null),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image6.png',
              buttonText: 'KEKERINGAN',
              onButtonTap: () => null),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image7.png',
              buttonText: 'BENCANA ALAM',
              onButtonTap: () => null),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image8.png',
              buttonText: 'GANGGUAN FISIOLOGIS',
              onButtonTap: () => null),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image9.png',
              buttonText: 'REKAPITULASI',
              onButtonTap: () => null)
        ]);
  }
}

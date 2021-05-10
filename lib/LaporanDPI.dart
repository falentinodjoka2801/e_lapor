import 'package:e_lapor/DPI/Banjir.dart';
import 'package:e_lapor/DPI/BencanaAlam.dart';
import 'package:e_lapor/DPI/GangguanFisiologis.dart';
import 'package:e_lapor/DPI/Kekeringan.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/LaporanItem.dart';

class LaporanDPI extends StatelessWidget {
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

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
              onButtonTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Banjir()))),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image6.png',
              buttonText: 'KEKERINGAN',
              onButtonTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Kekeringan()))),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image7.png',
              buttonText: 'BENCANA ALAM',
              onButtonTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BencanaAlam()))),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image8.png',
              buttonText: 'GANGGUAN FISIOLOGI',
              buttonTextSize: SizeConfig.horizontalBlock * 3.25,
              onButtonTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => GangguanFisiologis()))),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image9.png',
              buttonText: 'REKAPITULASI',
              onButtonTap: () => null)
        ]);
  }
}

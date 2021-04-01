import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/Navigation/CustomBottomNavigationBar.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/LaporanItem.dart';
import 'package:provider/provider.dart';

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
              onButtonTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Tes()));
              }),
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image4.png',
              buttonText: 'REKAPITULASI',
              onButtonTap: () => null)
        ]);
  }
}

class Tes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNavigation.appBar(
            currentTabItem: TabItem.beranda,
            appBarContext: context,
            title: 'Nande Tigan Lalit duana',
            backgroundColor: CustomColors.eLaporGreen),
        Expanded(child: Center(child: Text('Widget Tes'))),
        CustomBottomNavigationBar(
            currenTabItem: TabItem.beranda,
            onTap: (tabItem) => Provider.of<GlobalState>(context, listen: false)
                .currentTabItem = tabItem)
      ],
    );
  }
}

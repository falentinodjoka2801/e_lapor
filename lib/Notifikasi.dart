import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/LaporankuItem.dart';
import 'package:e_lapor/Navigation/CustomBottomNavigationBar.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/CustomNavigation.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/Object/Laporan.dart';
import 'package:e_lapor/FakeData/Laporan.dart' as fakeDataLaporan;
import 'package:provider/provider.dart';

class Notifikasi extends StatefulWidget {
  _NotifikasiState createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    List<Laporan> _items = fakeDataLaporan.laporan;

    return Column(
      children: [
        CustomNavigation.appBar(
            appBarContext: context,
            title: 'Notifikasi',
            currentTabItem: TabItem.beranda),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.leftAndRightContentContainerPadding,
                right: SizeConfig.leftAndRightContentContainerPadding,
                bottom: SizeConfig.topAndBottomContentContainerPadding),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _items.length,
              itemBuilder: (listViewBuilderContext, index) {
                Laporan _laporan = _items[index];
                return LaporankuItem(_laporan);
              },
            ),
          ),
        ),
        CustomBottomNavigationBar(
            currenTabItem: TabItem.beranda,
            onTap: (tabItem) => Provider.of<GlobalState>(context, listen: false)
                .currentTabItem = tabItem)
      ],
    );
  }
}

import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/LaporankuItem.dart';
import 'package:e_lapor/Navigation/CustomBottomNavigationBar.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/Object/Laporan.dart';
import 'package:e_lapor/FakeData/Laporan.dart' as fakeDataLaporan;
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';

import 'package:flutter/material.dart';

import 'package:e_lapor/FilterPencarian.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class LaporanKu extends StatefulWidget {
  _LaporanKuState createState() => _LaporanKuState();
}

class _LaporanKuState extends State<LaporanKu> with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    List<Laporan> _items = fakeDataLaporan.laporanPending;

    return Column(
      children: [
        CustomNavigation.appBar(
            currentTabItem: TabItem.laporanKu,
            appBarContext: context,
            title: 'Laporan Ku',
            actions: IconButton(
                icon: Icon(LineIcons.filter, color: CustomColors.eLaporWhite),
                onPressed: () async {
                  Widget _body = FilterPencarian();
                  Widget _actions = Column(children: [
                    Button.submitButton(context, 'TERAPKAN', () {},
                        color: CustomColors.eLaporGreen,
                        trailing: Icon(Icons.arrow_forward_ios_sharp,
                            color: CustomColors.eLaporWhite)),
                    SizedBox(height: 5.0),
                    Button.submitButton(context, 'BERSIHKAN FILTER', () {},
                        color: CustomColors.eLaporRed,
                        outline: true,
                        useBorder: false),
                  ]);
                  await Alert.widgetComponent(context,
                      useRouteNavigator: true,
                      isDismissible: true,
                      icon: ClientPath.iconPath + '/search.png',
                      body: _body,
                      actions: _actions);
                })),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.horizontalBlock * 4.0),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 7.5),
                child: TabBar(
                    isScrollable: true,
                    onTap: (value) {},
                    indicatorColor: CustomColors.eLaporGreen,
                    indicatorWeight: 3.5,
                    labelColor: CustomColors.eLaporGreen,
                    unselectedLabelColor: CustomColors.eLaporBlack,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w700, fontFamily: 'QuickSand'),
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal, fontFamily: 'QuickSand'),
                    controller:
                        TabController(length: 4, vsync: this, initialIndex: 0),
                    tabs: [
                      Tab(child: Text('PENDING (8)')),
                      Tab(child: Text('DALAM PENGECEKAN (1)')),
                      Tab(child: Text('TELAH DIVERIFIKASI (10)')),
                      Tab(child: Text('DITOLAK (1)'))
                    ]),
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _items.length,
                      itemBuilder: (_listViewContext, _index) {
                        Laporan _laporan = _items[_index];
                        return LaporankuItem(_laporan);
                      }))
            ]),
          ),
        ),
        CustomBottomNavigationBar(
            currenTabItem: TabItem.laporanKu,
            onTap: (tabItem) => Provider.of<GlobalState>(context, listen: false)
                .currentTabItem = tabItem)
      ],
    );
  }
}

import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/Future/LaporanFuture.dart';
import 'package:e_lapor/LaporankuItem.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/Object/Laporan.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/DataNotFound.dart';
import 'package:e_lapor/globalWidgets/Loading.dart';
import 'package:e_lapor/libraries/SPKey.dart';

import 'package:flutter/material.dart';

import 'package:e_lapor/FilterPencarian.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LaporanKu extends StatefulWidget {
  _LaporanKuState createState() => _LaporanKuState();
}

class _LaporanKuState extends State<LaporanKu> with TickerProviderStateMixin {
  int _currentTabInt = 0;
  String _currentTab = 'pending';

  List _laporanKu = [];
  bool _readyToShow = false;

  void initState() {
    super.initState();
    _initialization();
  }

  Future<void> _initialization() async {
    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    int _activeUserID = _dataLogin[SPKey.idUser];

    List _laporanByStatus = await LaporanFuture.getLaporan(
        idUser: _activeUserID, status: _currentTab);

    setState(() {
      _laporanKu = _laporanByStatus;
      _readyToShow = true;
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    List<String> _tabValue = [
      'pending',
      'diverifikasi kordinator kota/kab',
      'diverifikasi kordinator provinsi',
      'ditolak kordinator kota/kab',
      'ditolak kordinator provinsi'
    ];

    return Scaffold(
        appBar: CustomNavigation.appBar(
            appBarContext: context,
            title: 'Laporan Ku',
            actions: [
              IconButton(
                  icon: SvgPicture.asset(ClientPath.svgPath + '/filter.svg'),
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
                        icon: SvgPicture.asset(
                            ClientPath.svgPath + '/search-circle.svg'),
                        body: _body,
                        actions: _actions);
                  })
            ]),
        body: FutureBuilder(
            future: AkunFuture.getDataLogin(),
            builder: (futureBuilderContext, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> _dataLogin = snapshot.data;
                int _activeUserID = _dataLogin[SPKey.idUser];

                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontalBlock * 4.0),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 7.5),
                      child: TabBar(
                          isScrollable: true,
                          onTap: (selectedValue) async {
                            if (selectedValue != _currentTabInt) {
                              setState(() {
                                _readyToShow = false;
                              });

                              List _laporanByStatus =
                                  await LaporanFuture.getLaporan(
                                      idUser: _activeUserID,
                                      status: _currentTab);

                              setState(() {
                                _laporanKu = _laporanByStatus;
                                _readyToShow = true;
                                _currentTab = _tabValue[selectedValue];
                                _currentTabInt = selectedValue;
                              });
                            }
                          },
                          indicatorColor: CustomColors.eLaporGreen,
                          indicatorWeight: 3.5,
                          labelColor: CustomColors.eLaporGreen,
                          unselectedLabelColor: CustomColors.eLaporBlack,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'QuickSand'),
                          unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'QuickSand'),
                          controller: TabController(
                              length: 5,
                              vsync: this,
                              initialIndex: _currentTabInt),
                          tabs: [
                            Tab(child: Text('Pending')),
                            Tab(
                                child:
                                    Text('Diverifikasi Kordinator Kota/Kab')),
                            Tab(
                                child:
                                    Text('Diverifikasi Kordinator Provinsi')),
                            Tab(child: Text('Ditolak Kordinator Kota/Kab')),
                            Tab(child: Text('Ditolak Kordinator Provinsi'))
                          ]),
                    ),
                    Expanded(
                        child: (_readyToShow)
                            ? (_laporanKu.length >= 1)
                                ? RefreshIndicator(
                                    onRefresh: () async {
                                      setState(() {
                                        _currentTabInt = 0;
                                        _currentTab = 'pending';
                                      });
                                    },
                                    child: ListView.builder(
                                        padding: EdgeInsets.only(
                                            bottom: SizeConfig.horizontalBlock *
                                                4.0),
                                        itemCount: _laporanKu.length,
                                        itemBuilder:
                                            (_listViewContext, _index) {
                                          Map<String, dynamic> _laporan =
                                              _laporanKu[_index];
                                          Laporan _laporanItem = Laporan(
                                              id: _laporan['id'],
                                              judul: _laporan['title'],
                                              statusLaporan: _laporan['status'],
                                              waktu: _laporan['date'],
                                              lokasi: _laporan['location'],
                                              tipeLaporan: _laporan['type']);
                                          return LaporankuItem(_laporanItem,
                                              tabItem: TabItem.laporanKu);
                                        }))
                                : Center(
                                    child: DataNotFound(
                                        textMessage: 'Tidak Ada Laporan'))
                            : Center(
                                child: Loading(
                                    loadingTitle: 'Laporan',
                                    loadingSubTitle: 'Sedang mengambil data')))
                  ]),
                );
              } else {
                return Center(child: Loading());
              }
            }));
  }
}

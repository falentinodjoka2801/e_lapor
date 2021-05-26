import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/Future/LaporanFuture.dart';
import 'package:e_lapor/LaporankuItem.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/Object/Laporan.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
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
  Map<String, int> _filter;

  void initState() {
    super.initState();
    _initialization();
  }

  Future<void> _initialization(
      {int idProvinsi,
      int idKabupatenKota,
      int idKecamatan,
      int idKelurahan}) async {
    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    int _activeUserID = _dataLogin[SPKey.idUser];

    List _laporanByStatus = [];
    LaporanResponse _laporanResponse = await LaporanFuture.getLaporan(
        idUser: _activeUserID,
        status: _currentTab,
        idProvinsi: idProvinsi,
        idKabupatenKota: idKabupatenKota,
        idKecamatan: idKecamatan,
        idKelurahan: idKelurahan);

    if (_laporanResponse.statusCode == 200) {
      _laporanByStatus = _laporanResponse.laporan;
    } else {
      await Alert.alertServerBermasalah(context);
    }

    setState(() {
      _laporanKu = _laporanByStatus;
      _readyToShow = true;
    });
  }

  Future<void> _onRefreshIndicator(
      {@required BuildContext onRefreshIndicatorContext,
      @required int idUser,
      @required String currentTab}) async {
    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    int _idProvinsi = _dataLogin[SPKey.provinsiUser];
    int _idKabupatenKota = _dataLogin[SPKey.kabupatenKotaUser];
    int _kecamatan, _kelurahan;

    if (_filter != null) {
      _kecamatan = _filter['kecamatan'];
      _kelurahan = _filter['kelurahan'];

      _kecamatan = (_kecamatan != null && _kecamatan != 0) ? _kecamatan : null;
      _kelurahan = (_kelurahan != null && _kelurahan != 0) ? _kelurahan : null;
    }

    List _laporanByStatus = [];
    LaporanResponse _laporanResponse = await LaporanFuture.getLaporan(
        idUser: idUser,
        status: currentTab,
        idProvinsi: _idProvinsi,
        idKabupatenKota: _idKabupatenKota,
        idKecamatan: _kecamatan,
        idKelurahan: _kelurahan);

    if (_laporanResponse.statusCode == 200) {
      _laporanByStatus = _laporanResponse.laporan;
    } else {
      await Alert.alertServerBermasalah(onRefreshIndicatorContext);
    }

    setState(() {
      _laporanKu = _laporanByStatus;
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
        appBar: CustomNavigation
            .appBar(appBarContext: context, title: 'Laporan Ku', actions: [
          Stack(
            children: [
              IconButton(
                  icon: SvgPicture.asset(ClientPath.svgPath + '/filter.svg'),
                  onPressed: () async {
                    Widget _body = FilterPencarian(
                        currentTab: _currentTab,
                        currentFilter: _filter,
                        dataFiltered: (dataFiltered, filterData) async {
                          setState(() {
                            _laporanKu = dataFiltered;
                            _readyToShow = true;
                            _filter = filterData;
                          });

                          Navigator.pop(context);
                        },
                        onBersihkan: (dataFiltered) {
                          setState(() {
                            _filter = null;
                            _readyToShow = true;
                            _laporanKu = dataFiltered;
                          });

                          Navigator.pop(context);
                        });

                    await Alert.widgetComponent(context,
                        useRouteNavigator: false,
                        isDismissible: true,
                        icon: SvgPicture.asset(
                            ClientPath.svgPath + '/search-circle.svg'),
                        body: _body,
                        actions: null);
                  }),
              (_filter != null)
                  ? Positioned(
                      top: 7.5,
                      right: 7.5,
                      child: Container(
                          width: SizeConfig.horizontalBlock * 3,
                          height: SizeConfig.horizontalBlock * 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.horizontalBlock * 3),
                              color: CustomColors.dangerColor)))
                  : SizedBox()
            ],
          )
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

                              Map<String, dynamic> _dataLogin =
                                  await AkunFuture.getDataLogin();
                              int _provinsiUser =
                                  _dataLogin[SPKey.provinsiUser];
                              int _kabupatenUser =
                                  _dataLogin[SPKey.kabupatenKotaUser];

                              int _kecamatan, _kelurahan;
                              if (_filter != null) {
                                _kecamatan = _filter['kecamatan'];
                                _kelurahan = _filter['kelurahan'];

                                _kecamatan =
                                    (_kecamatan != null && _kecamatan != 0)
                                        ? _kecamatan
                                        : null;

                                _kelurahan =
                                    (_kelurahan != null && _kelurahan != 0)
                                        ? _kelurahan
                                        : null;
                              }

                              List _laporanByStatus = [];
                              LaporanResponse _laporanResponse =
                                  await LaporanFuture.getLaporan(
                                      idUser: _activeUserID,
                                      status: _tabValue[selectedValue],
                                      idProvinsi: _provinsiUser,
                                      idKabupatenKota: _kabupatenUser,
                                      idKecamatan: _kecamatan,
                                      idKelurahan: _kelurahan);
                              if (_laporanResponse.statusCode == 200) {
                                _laporanByStatus = _laporanResponse.laporan;
                              } else {
                                await Alert.alertServerBermasalah(context);
                              }

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
                                      await _onRefreshIndicator(
                                          onRefreshIndicatorContext: context,
                                          idUser: _activeUserID,
                                          currentTab: _currentTab);
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
                                : RefreshIndicator(
                                    onRefresh: () async {
                                      await _onRefreshIndicator(
                                          onRefreshIndicatorContext: context,
                                          idUser: _activeUserID,
                                          currentTab: _currentTab);
                                    },
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      return ListView(children: [
                                        Container(
                                            constraints: BoxConstraints(
                                                minHeight:
                                                    constraints.maxHeight,
                                                minWidth: constraints.minWidth),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DataNotFound(
                                                    textMessage:
                                                        'Tidak Ada Laporan'),
                                                SizedBox(height: 5.0),
                                                Text(
                                                    'Tarik layar ke bawah untuk mereload ulang data',
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .horizontalBlock *
                                                            3.5))
                                              ],
                                            ))
                                      ]);
                                    }),
                                  )
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

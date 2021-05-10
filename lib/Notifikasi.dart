import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/Object/Notifikasi.dart';
import 'package:e_lapor/Future/NotifikasiFuture.dart';
import 'package:e_lapor/NotifikasiItem.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/globalWidgets/DataNotFound.dart';
import 'package:e_lapor/globalWidgets/Loading.dart';
import 'package:e_lapor/libraries/SPKey.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';

class Notifikasi extends StatefulWidget {
  _NotifikasiState createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  int _idUserState;

  void initState() {
    super.initState();
    _initialization();
  }

  Future<void> _initialization() async {
    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    int _idUser = _dataLogin[SPKey.idUser];

    setState(() {
      _idUserState = _idUser;
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return Scaffold(
        appBar: CustomNavigation.appBar(
            appBarContext: context, title: 'Notifikasi'),
        body: (_idUserState != null)
            ? FutureBuilder(
                future: NotifikasiFuture.getNotifikasi(idUser: _idUserState),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List _notifikasi = snapshot.data;
                    return (_notifikasi.length >= 1)
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig
                                    .leftAndRightContentContainerPadding,
                                right: SizeConfig
                                    .leftAndRightContentContainerPadding,
                                bottom: SizeConfig
                                    .topAndBottomContentContainerPadding),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _notifikasi.length,
                              itemBuilder: (listViewBuilderContext, index) {
                                Map<String, dynamic> _notifItem =
                                    _notifikasi[index];

                                NotifikasiContent _notifContent =
                                    NotifikasiContent(
                                        id: _notifItem['content']['id'],
                                        title: _notifItem['content']['title'],
                                        status: _notifItem['content']['status'],
                                        desa: _notifItem['content']['desa'],
                                        notes: _notifItem['content']['notes']);
                                NotifikasiObject _notif = NotifikasiObject(
                                    id: _notifItem['id'],
                                    userID: _notifItem['user_id'],
                                    content: _notifContent,
                                    date: _notifItem['date']);

                                return NotifikasiItem(_notif,
                                    tabItem: TabItem.beranda);
                              },
                            ),
                          )
                        : Center(
                            child: DataNotFound(
                                textMessage: 'Tidak Ada Notifikasi'));
                  } else {
                    return Center(
                        child: Loading(
                            loadingTitle: 'Notifikasi',
                            loadingSubTitle: 'Sedang Mengambil Data'));
                  }
                })
            : SizedBox());
  }
}

import 'package:e_lapor/FilterPencarian.dart';
import 'package:e_lapor/GPSGrantPermission.dart';
import 'package:e_lapor/Laporanku.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/DataNotFound.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

import 'package:e_lapor/DetailAkun.dart';
import 'package:e_lapor/Beranda.dart';
import 'package:e_lapor/TambahLaporan.dart';

class ListTombol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextButton(
          onPressed: () async {
            await Alert.textComponent(context,
                isDismissible: true,
                icon: ClientPath.iconPath + '/danger.png',
                subTitle: 'Apakah anda yakin untuk keluar dari aplikasi?',
                title: null,
                actions: Column(children: [
                  Button.button(context, 'YA, KELUARKAN SAYA', () {
                    Navigator.pop(context, 'keluar');
                  },
                      isBlock: true,
                      color: CustomColors.eLaporGreen,
                      trailing: IconButton(
                          color: CustomColors.eLaporWhite,
                          icon: Icon(Icons.arrow_forward_ios_sharp),
                          onPressed: () => null)),
                  SizedBox(height: 10.0),
                  Button.button(context, 'BATAL', () {
                    Navigator.pop(context, 'batal');
                  },
                      outline: true,
                      isBlock: true,
                      useBorder: false,
                      color: CustomColors.eLaporRed)
                ]));
          },
          child: Text('SignOut')),
      TextButton(
          onPressed: () async {
            Widget _actions = Button.button(context, 'OKE', () {},
                size: Button.lgSize,
                color: CustomColors.eLaporGreen,
                isBlock: true,
                trailing: GestureDetector(
                  child: Icon(Icons.arrow_forward_ios_sharp,
                      color: CustomColors.eLaporWhite),
                ));
            await Alert.textComponent(context,
                icon: ClientPath.iconPath + '/danger.png',
                title: 'Wohooo/Whoops!',
                subTitle: 'Ini adalah pesan dari alert',
                actions: _actions);
          },
          child: Text('Alert Message')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 350),
                    pageBuilder: (_pRBContext, _opacity, _) => FadeTransition(
                        opacity: _opacity,
                        child: Scaffold(
                            body: Center(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DataNotFound(textMessage: 'Data Tidak Ditemukan'),
                          ],
                        ))))));
          },
          child: Text('Dana Not Found')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => DetailAkun()));
          },
          child: Text('Detail Akun')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Beranda()));
          },
          child: Text('BERANDA')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => TambahLaporan()));
          },
          child: Text('Tambah Laporan')),
      TextButton(
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
                icon: ClientPath.iconPath + '/search.png',
                body: _body,
                actions: _actions);
          },
          child: Text('Filter Pencarian')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 350),
                    pageBuilder: (_pRBContext, opacity, _) => Scaffold(
                        backgroundColor: CustomColors.eLaporWhite,
                        body: GPSGrantPermission())));
          },
          child: Text('GPS Grant Permission')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 350),
                    pageBuilder: (_pRBContext, opacity, _) => LaporanKu()));
          },
          child: Text('Laporanku'))
    ])));
  }
}

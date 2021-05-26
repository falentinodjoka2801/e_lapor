import 'package:e_lapor/TambahLaporan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/Object/Laporan.dart';

import 'package:e_lapor/DPI/Banjir.dart';
import 'package:e_lapor/DPI/BencanaAlam.dart';
import 'package:e_lapor/DPI/GangguanFisiologis.dart';
import 'package:e_lapor/DPI/Kekeringan.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

class LaporankuItem extends StatelessWidget {
  final Laporan laporan;
  final TabItem tabItem;
  LaporankuItem(this.laporan, {@required this.tabItem});

  Widget build(BuildContext context) {
    int _idLaporan = laporan.id;
    String _statusLaporan = laporan.statusLaporan;
    String _statusLaporanLC = _statusLaporan.toLowerCase();

    Widget _statusIcon =
        (_statusLaporanLC != statusLaporanReadable['pending'].toLowerCase())
            ? SvgPicture.asset(statusLaporanIcon[_statusLaporanLC])
            : null;

    String _text = laporan.statusLaporan;
    Text _statusText = Text(_text,
        style: TextStyle(
            color: statusLaporanColor[_text.toLowerCase()],
            fontSize: SizeConfig.horizontalBlock * 4.5,
            fontWeight: FontWeight.w700));

    String _tipeLaporan = laporan.tipeLaporan;
    String _tipeLaporanLC = _tipeLaporan.toLowerCase();

    return GestureDetector(
      onTap: () {
        print(_idLaporan);
        Navigator.push(navigatesKey[tabItem].currentState.context,
            MaterialPageRoute(builder: (context) {
          if (_tipeLaporanLC == 'opt') {
            return TambahLaporan(
                tabItem: TabItem.laporanKu,
                idLaporan: _idLaporan,
                state: TambahLaporanState.detail);
          }
          if (_tipeLaporanLC == 'gangguan fisiologis') {
            return GangguanFisiologis(
                tabItem: TabItem.laporanKu,
                idLaporan: _idLaporan,
                action: GangguanFisiologisAction.detail);
          }
          if (_tipeLaporanLC == 'banjir') {
            return Banjir(
                tabItem: TabItem.laporanKu,
                idLaporan: _idLaporan,
                action: BanjirAction.detail);
          }
          if (_tipeLaporanLC == 'kekeringan') {
            return Kekeringan(
                tabItem: TabItem.laporanKu,
                idLaporan: _idLaporan,
                action: KekeringanAction.detail);
          }
          if (_tipeLaporanLC == 'bencana') {
            return BencanaAlam(
                tabItem: TabItem.laporanKu,
                idLaporan: _idLaporan,
                action: BencanaAlamAction.detail);
          }

          return null;
        }));
      },
      child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.horizontalBlock * 4.0),
          child: Card(
              margin: EdgeInsets.zero,
              elevation: 4.0,
              shadowColor: CustomColors.eLaporShadowColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0XFFCBD2D9), width: 1.5),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.horizontalBlock * 4.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(laporan.waktu,
                              style: TextStyle(
                                  color: CustomColors.eLaporBlack,
                                  fontSize: SizeConfig.horizontalBlock * 3.0,
                                  fontWeight: FontWeight.w500)),
                          (_statusLaporanLC ==
                                  statusLaporanReadable['pending']
                                      .toLowerCase())
                              ? Spacer()
                              : SizedBox(),
                          (_statusLaporanLC ==
                                  statusLaporanReadable['pending']
                                      .toLowerCase())
                              ? GestureDetector(
                                  child: Icon(Icons.edit,
                                      size: SizeConfig.horizontalBlock * 5.5,
                                      color: CustomColors.eLaporDarkGreen),
                                  onTap: () {
                                    print(_idLaporan);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      if (_tipeLaporanLC == 'opt') {
                                        return TambahLaporan(
                                            tabItem: TabItem.laporanKu,
                                            idLaporan: _idLaporan,
                                            state: TambahLaporanState.edit);
                                      }
                                      if (_tipeLaporanLC ==
                                          'gangguan fisiologis') {
                                        return GangguanFisiologis(
                                            tabItem: TabItem.laporanKu,
                                            idLaporan: _idLaporan,
                                            action:
                                                GangguanFisiologisAction.edit);
                                      }
                                      if (_tipeLaporanLC == 'banjir') {
                                        return Banjir(
                                            tabItem: TabItem.laporanKu,
                                            idLaporan: _idLaporan,
                                            action: BanjirAction.edit);
                                      }
                                      if (_tipeLaporanLC == 'kekeringan') {
                                        return Kekeringan(
                                            tabItem: TabItem.laporanKu,
                                            idLaporan: _idLaporan,
                                            action: KekeringanAction.edit);
                                      }
                                      if (_tipeLaporanLC == 'bencana') {
                                        return BencanaAlam(
                                            tabItem: TabItem.laporanKu,
                                            idLaporan: _idLaporan,
                                            action: BencanaAlamAction.edit);
                                      }

                                      return null;
                                    }));
                                  },
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(height: 2.0),
                      Text(laporan.judul,
                          style: TextStyle(
                              color: CustomColors.eLaporBlack,
                              fontSize: SizeConfig.horizontalBlock * 5.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 3.5),
                      Row(children: [
                        Image.asset(
                            ClientPath.laporanIconPath + '/pin-gmaps.png'),
                        SizedBox(width: SizeConfig.horizontalBlock * 3.0),
                        Text(laporan.lokasi,
                            style: TextStyle(
                                color: CustomColors.eLaporBlack,
                                fontSize: SizeConfig.horizontalBlock * 3.5,
                                fontWeight: FontWeight.w500))
                      ]),
                      (_statusLaporanLC !=
                              statusLaporanReadable['pending'].toLowerCase())
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.horizontalBlock * 3.25),
                              child: Container(
                                height: 0.5,
                                decoration: BoxDecoration(
                                    color: CustomColors.eLaporBlack),
                              ))
                          : SizedBox(),
                      (_statusLaporanLC !=
                              statusLaporanReadable['pending'].toLowerCase())
                          ? Row(children: [
                              _statusIcon,
                              SizedBox(width: SizeConfig.horizontalBlock * 3.0),
                              Expanded(child: _statusText)
                            ])
                          : SizedBox()
                    ]),
              ))),
    );
  }
}

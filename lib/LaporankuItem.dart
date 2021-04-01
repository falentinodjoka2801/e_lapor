import 'package:e_lapor/TambahLaporan.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/Object/Laporan.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

class LaporankuItem extends StatelessWidget {
  final Laporan laporan;
  LaporankuItem(this.laporan);

  Widget build(BuildContext context) {
    Widget _statusIcon = Image.asset(statusLaporanIcon[laporan.statusLaporan]);
    String _text = statusLaporanReadable[laporan.statusLaporan];
    Text _statusText = Text(_text,
        style: TextStyle(
            color: statusLaporanColor[laporan.statusLaporan],
            fontSize: SizeConfig.horizontalBlock * 5.0,
            fontWeight: FontWeight.w700));

    StatusLaporan statusLaporan = laporan.statusLaporan;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => TambahLaporan(
                    idLaporan: 'tes', state: TambahLaporanState.detail)));
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
                          Text(laporan.waktu + ' - ' + laporan.jam,
                              style: TextStyle(
                                  color: CustomColors.eLaporBlack,
                                  fontSize: SizeConfig.horizontalBlock * 3.0,
                                  fontWeight: FontWeight.w500)),
                          (statusLaporan == StatusLaporan.pending)
                              ? Spacer()
                              : SizedBox(),
                          (statusLaporan == StatusLaporan.pending)
                              ? GestureDetector(
                                  child: Icon(Icons.edit,
                                      size: SizeConfig.horizontalBlock * 4.0,
                                      color: CustomColors.eLaporDarkGreen),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => TambahLaporan(
                                              idLaporan: 'Tes',
                                              state: TambahLaporanState.edit))),
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
                      (laporan.statusLaporan != StatusLaporan.pending)
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.horizontalBlock * 3.25),
                              child: Container(
                                height: 0.5,
                                decoration: BoxDecoration(
                                    color: CustomColors.eLaporBlack),
                              ))
                          : SizedBox(),
                      (laporan.statusLaporan != StatusLaporan.pending)
                          ? Row(children: [
                              _statusIcon,
                              SizedBox(width: SizeConfig.horizontalBlock * 3.5),
                              _statusText
                            ])
                          : SizedBox()
                    ]),
              ))),
    );
  }
}

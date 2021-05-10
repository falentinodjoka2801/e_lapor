import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/TambahLaporan.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/Object/Notifikasi.dart';
import 'package:e_lapor/Object/Laporan.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotifikasiItem extends StatelessWidget {
  final NotifikasiObject notifikasi;
  final TabItem tabItem;
  NotifikasiItem(this.notifikasi, {@required this.tabItem});

  Widget build(BuildContext context) {
    NotifikasiContent _content = notifikasi.content;

    bool _isPending = _content.status.toLowerCase() == 'pending';

    Widget _statusIcon = SvgPicture.asset(ClientPath.svgPath + '/check.svg',
        color: CustomColors.eLaporGreen);

    int _idLaporan = _content.id;

    return Padding(
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
                        Text(notifikasi.date,
                            style: TextStyle(
                                color: CustomColors.eLaporBlack,
                                fontSize: SizeConfig.horizontalBlock * 3.0,
                                fontWeight: FontWeight.w500)),
                        (_isPending) ? Spacer() : SizedBox(),
                        (_isPending)
                            ? GestureDetector(
                                child: Icon(Icons.edit,
                                    size: SizeConfig.horizontalBlock * 4.0,
                                    color: CustomColors.eLaporDarkGreen),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TambahLaporan(
                                            idLaporan: _idLaporan,
                                            state: TambahLaporanState.edit))),
                              )
                            : SizedBox()
                      ],
                    ),
                    SizedBox(height: 2.0),
                    Text(_content.title,
                        style: TextStyle(
                            color: CustomColors.eLaporBlack,
                            fontSize: SizeConfig.horizontalBlock * 5.0,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 3.5),
                    Row(children: [
                      SvgPicture.asset(ClientPath.svgPath + '/map-pin.svg',
                          color: CustomColors.dangerColor),
                      SizedBox(width: SizeConfig.horizontalBlock * 3.0),
                      Text(_content.desa,
                          style: TextStyle(
                              color: CustomColors.eLaporBlack,
                              fontSize: SizeConfig.horizontalBlock * 3.5,
                              fontWeight: FontWeight.w500))
                    ]),
                    (!_isPending)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.horizontalBlock * 3.25),
                            child: Container(
                              height: 0.5,
                              decoration: BoxDecoration(
                                  color: CustomColors.eLaporBlack),
                            ))
                        : SizedBox(),
                    (!_isPending)
                        ? Row(children: [
                            _statusIcon,
                            SizedBox(width: SizeConfig.horizontalBlock * 3.0),
                            Expanded(
                                child: Text(_content.status,
                                    style: TextStyle(
                                        color: statusLaporanColor[
                                            _content.status.toLowerCase()],
                                        fontSize:
                                            SizeConfig.horizontalBlock * 4.5,
                                        fontWeight: FontWeight.w700)))
                          ])
                        : SizedBox()
                  ]),
            )));
  }
}

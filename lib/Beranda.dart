import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/Navigation/CustomBottomNavigationBar.dart';
import 'package:e_lapor/Navigation/TabItem.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/ClientPath.dart';

import 'package:e_lapor/LaporanOPT.dart';
import 'package:e_lapor/LaporanDPI.dart';
import 'package:e_lapor/MenuLainnya.dart';
import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/ListTombol.dart';
import 'package:e_lapor/Notifikasi.dart';

class Beranda extends StatefulWidget {
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _iconSize = SizeConfig.horizontalBlock * 7.5;
    double _containerWidthAndHeight = SizeConfig.horizontalBlock * 18.75;
    double _iconAndTitleSpace = SizeConfig.horizontalBlock * 3.15;
    double _paddingTop = SizeConfig.horizontalBlock * 4.0;

    TextStyle _titleStyle = TextStyle(
        fontSize: SizeConfig.horizontalBlock * 5.0,
        color: CustomColors.eLaporBlack,
        fontWeight: FontWeight.w700);

    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            Positioned(
              top: -25.0,
              left: -25.0,
              child: Container(
                width: SizeConfig.horizontalBlock * 80.0,
                height: SizeConfig.horizontalBlock * 80.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ClientPath.iconPath + '/bptp.png'))),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: kToolbarHeight,
                    right: SizeConfig.leftAndRightContentContainerPadding,
                    left: SizeConfig.leftAndRightContentContainerPadding),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(52, 195, 105, 0.95)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Notifikasi())),
                          child: Icon(Icons.notifications_outlined,
                              size: _iconSize, color: CustomColors.eLaporWhite),
                        )
                      ]),
                      Row(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(_containerWidthAndHeight)),
                            child: Container(
                                width: _containerWidthAndHeight,
                                height: _containerWidthAndHeight,
                                decoration: BoxDecoration(
                                    color: CustomColors.eLaporWhite),
                                child: Center(
                                  child: Text('DY',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.horizontalBlock * 7.25,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.eLaporBlack)),
                                ))),
                        SizedBox(width: SizeConfig.horizontalBlock * 4.25),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dadang Yeager',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          SizeConfig.horizontalBlock * 5.0,
                                      color: CustomColors.eLaporWhite)),
                              SizedBox(height: 5.85),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(ClientPath.laporanIconPath +
                                        '/' +
                                        AssetImageName.pinGmapsWhite),
                                    SizedBox(width: 12.5),
                                    Text('PETUGAS OPT',
                                        style: TextStyle(
                                            color: CustomColors.eLaporWhite,
                                            fontSize:
                                                SizeConfig.horizontalBlock *
                                                    3.0,
                                            letterSpacing: 1.5,
                                            fontWeight: FontWeight.w500))
                                  ])
                            ])
                      ])
                    ])),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.horizontalBlock * 35.0 + kToolbarHeight),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  child: Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.topAndBottomContentContainerPadding,
                          left: SizeConfig.leftAndRightContentContainerPadding,
                          right:
                              SizeConfig.leftAndRightContentContainerPadding),
                      decoration:
                          BoxDecoration(color: CustomColors.eLaporWhite),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(children: [
                                Icon(Icons.add_outlined,
                                    color: CustomColors.eLaporGreen),
                                SizedBox(width: _iconAndTitleSpace),
                                Text('Laporan OPT', style: _titleStyle),
                                Spacer(),
                                GestureDetector(
                                    child: Text('All Page'),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ListTombol())))
                              ]),
                              Padding(
                                  padding: EdgeInsets.only(top: _paddingTop),
                                  child: Container(
                                    color: CustomColors.eLaporBlack,
                                    height: 0.35,
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: _paddingTop),
                                  child: LaporanOPT()),
                              SizedBox(height: 4.0),
                              Row(children: [
                                Icon(Icons.add_outlined,
                                    color: CustomColors.eLaporGreen),
                                SizedBox(width: _iconAndTitleSpace),
                                Text('Laporan DPI', style: _titleStyle)
                              ]),
                              Padding(
                                  padding: EdgeInsets.only(top: _paddingTop),
                                  child: Container(
                                    color: CustomColors.eLaporBlack,
                                    height: 0.35,
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: _paddingTop),
                                  child: LaporanDPI()),
                              SizedBox(height: 4.0),
                              Row(children: [
                                Icon(Icons.add_outlined,
                                    color: CustomColors.eLaporGreen),
                                SizedBox(width: _iconAndTitleSpace),
                                Text('Menu Lainnya', style: _titleStyle)
                              ]),
                              Padding(
                                  padding: EdgeInsets.only(top: _paddingTop),
                                  child: Container(
                                    color: CustomColors.eLaporBlack,
                                    height: 0.35,
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: _paddingTop),
                                  child: MenuLainnya())
                            ]),
                      ))),
            )
          ]),
        ),
        CustomBottomNavigationBar(
            currenTabItem: TabItem.beranda,
            onTap: (tabItem) => Provider.of<GlobalState>(context, listen: false)
                .currentTabItem = tabItem)
      ],
    );
  }
}

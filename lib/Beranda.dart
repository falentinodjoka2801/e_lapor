import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/libraries/SPKey.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/ClientPath.dart';

import 'package:e_lapor/LaporanOPT.dart';
import 'package:e_lapor/LaporanDPI.dart';
import 'package:e_lapor/MenuLainnya.dart';
import 'package:e_lapor/Notifikasi.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum WhitePanelState { normal, slided }

class Beranda extends StatefulWidget {
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  ScrollController _whitePanelSingleChildController = ScrollController();
  WhitePanelState _whitePanelState = WhitePanelState.normal;

  String _userNameState = '';
  String _userPrivilegesNameState = '';

  void initState() {
    super.initState();
    _stateInitialization();
    _whitePanelListenerInitialization();
  }

  Future<void> _stateInitialization() async {
    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    Map<String, dynamic> _userPrivileges = _dataLogin[SPKey.privilegesUser];

    print(_dataLogin);

    setState(() {
      _userNameState = _dataLogin[SPKey.namaUser];
      _userPrivilegesNameState = _userPrivileges['name'];
    });
  }

  void _whitePanelListenerInitialization() {
    _whitePanelSingleChildController.addListener(() {
      double _currentPosition = _whitePanelSingleChildController.offset;
      double _offsetToSlided =
          _whitePanelSingleChildController.position.maxScrollExtent / 3;

      WhitePanelState _whitePanelStateOnListener =
          (_currentPosition >= _offsetToSlided)
              ? WhitePanelState.slided
              : WhitePanelState.normal;
      setState(() {
        _whitePanelState = _whitePanelStateOnListener;
      });
    });
  }

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

    Duration _slideDuration = Duration(milliseconds: 350);

    Widget _plusSquare = SvgPicture.asset(
      ClientPath.svgPath + '/plus-square.svg',
      color: CustomColors.eLaporGreen,
      width: _iconSize,
    );

    return Scaffold(
        body: Stack(children: [
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
          decoration: BoxDecoration(color: Color.fromRGBO(52, 195, 105, 0.95)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Notifikasi()));
                },
                child: SvgPicture.asset(ClientPath.svgPath + '/bell.svg',
                    color: CustomColors.eLaporWhite),
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
                        image: DecorationImage(
                            image: AssetImage(
                                ClientPath.iconPath + '/elapor-opt-dpi.png')),
                        color: CustomColors.eLaporWhite),
                  )),
              SizedBox(width: SizeConfig.horizontalBlock * 4.25),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_userNameState,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.horizontalBlock * 5.0,
                        color: CustomColors.eLaporWhite)),
                SizedBox(height: 5.85),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SvgPicture.asset(ClientPath.svgPath + '/map-pin.svg',
                      color: CustomColors.eLaporWhite),
                  SizedBox(width: 10.0),
                  Text(_userPrivilegesNameState,
                      style: TextStyle(
                          color: CustomColors.eLaporWhite,
                          fontSize: SizeConfig.horizontalBlock * 3.25,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700))
                ])
              ])
            ])
          ])),
      AnimatedPositioned(
          height: SizeConfig.verticalBlock * 100.0,
          duration: _slideDuration,
          curve: Curves.easeIn,
          top: (_whitePanelState == WhitePanelState.normal)
              ? SizeConfig.horizontalBlock * 35.0 + kToolbarHeight
              : 0.0,
          left: 0.0,
          right: 0.0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: SizeConfig.topAndBottomContentContainerPadding * 5.0,
                  top: SizeConfig.topAndBottomContentContainerPadding,
                  left: SizeConfig.leftAndRightContentContainerPadding,
                  right: SizeConfig.leftAndRightContentContainerPadding),
              decoration: BoxDecoration(color: CustomColors.eLaporWhite),
              child: ListView(
                  padding: EdgeInsets.zero,
                  controller: _whitePanelSingleChildController,
                  children: [
                    Row(children: [
                      _plusSquare,
                      SizedBox(width: _iconAndTitleSpace),
                      Text('Laporan OPT', style: _titleStyle)
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
                      _plusSquare,
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
                      _plusSquare,
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
            ),
          )),
    ]));
  }
}

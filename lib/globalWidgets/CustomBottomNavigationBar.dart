import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    TextStyle _labelStyle = TextStyle(
        fontSize: SizeConfig.horizontalBlock * 3.25,
        color: CustomColors.eLaporWhite,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5);

    double _topPadding = SizeConfig.horizontalBlock * 1.25;
    double _sizedBoxHeight = SizeConfig.horizontalBlock * 3.15;

    return BottomNavigationBar(
        currentIndex: 2,
        backgroundColor: CustomColors.eLaporGreen,
        selectedItemColor: CustomColors.eLaporBlack,
        unselectedItemColor: CustomColors.eLaporWhite,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: EdgeInsets.only(top: _topPadding),
                child: Column(
                  children: [
                    Image.asset(ClientPath.tabbarIconPath + '/home.png'),
                    SizedBox(height: _sizedBoxHeight),
                    Text('BERANDA', style: _labelStyle)
                  ],
                ),
              )),
          BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: EdgeInsets.only(top: _topPadding),
                child: Column(
                  children: [
                    Image.asset(ClientPath.tabbarIconPath + '/folder.png'),
                    SizedBox(height: _sizedBoxHeight),
                    Text('LAPORAN KU', style: _labelStyle)
                  ],
                ),
              )),
          BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: EdgeInsets.only(top: _topPadding),
                child: Column(
                  children: [
                    Image.asset(ClientPath.tabbarIconPath + '/user.png'),
                    SizedBox(height: _sizedBoxHeight),
                    Text('AKUN', style: _labelStyle)
                  ],
                ),
              ))
        ]);
  }
}

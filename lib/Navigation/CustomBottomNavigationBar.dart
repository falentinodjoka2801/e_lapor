import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final TabItem currenTabItem;
  final void Function(TabItem tabItem) onTap;

  CustomBottomNavigationBar(
      {@required this.currenTabItem, @required this.onTap});

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _topPadding = SizeConfig.horizontalBlock * 1.25;
    double _sizedBoxHeight = SizeConfig.horizontalBlock * 3.15;

    return BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: CustomColors.eLaporGreen,
        selectedItemColor: CustomColors.eLaporBlack,
        unselectedItemColor: CustomColors.eLaporWhite,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (indexInt) => onTap(TabItem.values[indexInt]),
        items: <BottomNavigationBarItem>[
          _buildMenu(TabItem.beranda,
              topPadding: _topPadding, sizedBoxHeight: _sizedBoxHeight),
          _buildMenu(TabItem.laporanKu,
              topPadding: _topPadding, sizedBoxHeight: _sizedBoxHeight),
          _buildMenu(TabItem.akun,
              topPadding: _topPadding, sizedBoxHeight: _sizedBoxHeight)
        ]);
  }

  BottomNavigationBarItem _buildMenu(TabItem tabItem,
      {double topPadding = 0.0, double sizedBoxHeight = 0.0}) {
    bool isActive = currenTabItem == tabItem;

    TextStyle _labelStyle = TextStyle(
        fontSize: SizeConfig.horizontalBlock * 3.25,
        color: (isActive)
            ? CustomColors.eLaporDarkGreen
            : CustomColors.eLaporWhite,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5);

    return BottomNavigationBarItem(
        label: '',
        tooltip: tabTooltip[tabItem],
        icon: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Column(
            children: [
              SvgPicture.asset(tabIcons[tabItem],
                  color: (isActive)
                      ? CustomColors.eLaporDarkGreen
                      : CustomColors.eLaporWhite),
              SizedBox(height: sizedBoxHeight),
              Text(tabName[tabItem].toUpperCase(), style: _labelStyle)
            ],
          ),
        ));
  }
}

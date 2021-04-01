import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/Navigation/TabItem.dart';

import 'package:e_lapor/GlobalState.dart';

class CustomNavigation {
  static Widget appBar(
      {@required BuildContext appBarContext,
      @required String title,
      @required TabItem currentTabItem,
      Color backgroundColor,
      double elevation = 0.0,
      Widget actions}) {
    Color _backgroundColor = CustomColors.eLaporGreen;
    if (backgroundColor != null) {
      _backgroundColor = backgroundColor;
    }

    SizeConfig().initSize(appBarContext);

    bool _isActionNull = actions != null;

    void _selectTab(TabItem tabItem, TabItem currentTab) {
      if (tabItem == currentTab) {
        navigatesKey[tabItem].currentState.popUntil((route) => route.isFirst);
      } else {
        Provider.of<GlobalState>(appBarContext, listen: false).currentTabItem =
            tabItem;
      }
    }

    Future<bool> _onBackButtonPressed(TabItem currentTabItem) async {
      bool isItTheFirstPageInCurrentTab =
          !await navigatesKey[currentTabItem].currentState.maybePop();
      if (currentTabItem != TabItem.beranda) {
        _selectTab(TabItem.beranda, currentTabItem);

        return false;
      }

      return isItTheFirstPageInCurrentTab;
    }

    return Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(appBarContext).viewPadding.top),
        decoration: BoxDecoration(color: _backgroundColor),
        child: Row(children: [
          BackButton(
              color: CustomColors.eLaporWhite,
              onPressed: () {
                _onBackButtonPressed(currentTabItem);
              }),
          Expanded(
              flex: (!_isActionNull) ? 10 : 7,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeConfig.horizontalBlock * 4.75,
                        color: CustomColors.eLaporWhite,
                        fontWeight: FontWeight.w700)),
              ))),
          Expanded(flex: 1, child: (_isActionNull) ? actions : SizedBox())
        ]));
  }
}

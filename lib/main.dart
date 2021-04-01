import 'package:e_lapor/AuthenticatedPages.dart';
import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/Login.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/Navigation/TabItem.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalState>(
        create: (changeNotifierProviderContext) => GlobalState(),
        child: MaterialApp(
          title: 'E-Lapor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              platform: TargetPlatform.macOS,
              primarySwatch: Colors.blue,
              fontFamily: 'QuickSand'),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasLoggedIn = false;

  Widget build(BuildContext context) {
    void _selectTab(TabItem tabItem, TabItem currentTab) {
      if (tabItem == currentTab) {
        navigatesKey[tabItem].currentState.popUntil((route) => route.isFirst);
      } else {
        Provider.of<GlobalState>(context, listen: false).currentTabItem =
            tabItem;
      }
    }

    return Consumer<GlobalState>(builder: (consumerContext, globalState, _) {
      TabItem _currentTab = globalState.currentTabItem;

      return WillPopScope(
          onWillPop: () async {
            bool isItTheFirstPageInCurrentTab =
                !await navigatesKey[_currentTab].currentState.maybePop();
            if (_currentTab != TabItem.beranda) {
              _selectTab(TabItem.beranda, _currentTab);

              return false;
            }

            return isItTheFirstPageInCurrentTab;
          },
          child: Scaffold(
            backgroundColor: CustomColors.eLaporWhite,
            body: (!_hasLoggedIn)
                ? Login(() {
                    setState(() {
                      _hasLoggedIn = true;
                    });
                  })
                : AuthenticatedPages(currentTab: _currentTab),
          ));
    });
  }
}

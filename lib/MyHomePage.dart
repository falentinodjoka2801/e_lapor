import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/Navigation/TabNavigator.dart';
import 'package:e_lapor/Navigation/CustomBottomNavigationBar.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    'This channel is used for important notifications.',
    importance: Importance.high);

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime currentBackPressTime;
  TabItem _currentTab = TabItem.beranda;

  void initState() {
    super.initState();
    _initialization();
  }

  void _initialization() {
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      //TODO
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channel.id,
                _channel.name,
                _channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //TODO
    });
  }

  Widget _buildBody(TabItem currentTab, TabItem tabItem) {
    return Offstage(
        offstage: currentTab != tabItem,
        child: TabNavigator(
            navigatorKey: navigatesKey[tabItem], tabItem: tabItem));
  }

  void _selectTab(TabItem currentTab, TabItem tabItem) {
    if (tabItem == currentTab) {
      navigatesKey[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return WillPopScope(
        onWillPop: () async {
          bool isItTheFirstPageInCurrentTab =
              !await navigatesKey[_currentTab].currentState.maybePop();

          if (_currentTab != TabItem.beranda) {
            _selectTab(_currentTab, TabItem.beranda);

            return false;
          }

          if (isItTheFirstPageInCurrentTab) {
            Widget _icon = SvgPicture.asset(ClientPath.svgPath + '/danger.svg');
            Widget _actions = Row(children: [
              Expanded(
                  child: Button.button(context, 'Ya', () {
                Navigator.pop(context, true);
              },
                      color: CustomColors.dangerColor,
                      outline: true,
                      isBlock: true)),
              SizedBox(width: 10.0),
              Expanded(
                  child: Button.button(context, 'Tidak', () {
                Navigator.pop(context, false);
              }, color: CustomColors.eLaporGreen, isBlock: true))
            ]);
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime) > Duration(seconds: 2)) {
              currentBackPressTime = now;
              bool _exit = await Alert.textComponent(context,
                  icon: _icon,
                  title: 'Keluar Aplikasi',
                  subTitle: 'Apakah anda yakin akan keluar dari aplikasi?',
                  actions: _actions);

              return Future.value(_exit);
            }
            return Future.value(true);
          }

          return isItTheFirstPageInCurrentTab;
        },
        child: Scaffold(
            body: Stack(children: [
              _buildBody(_currentTab, TabItem.beranda),
              _buildBody(_currentTab, TabItem.laporanKu),
              _buildBody(_currentTab, TabItem.akun)
            ]),
            bottomNavigationBar: CustomBottomNavigationBar(
                currenTabItem: _currentTab,
                onTap: (TabItem selectedTabItem) =>
                    _selectTab(_currentTab, selectedTabItem))));
  }
}

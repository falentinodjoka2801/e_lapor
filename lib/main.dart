import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/SplashScreen.dart';
import 'package:e_lapor/libraries/NavigatorKey.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    'This channel is used for important notifications.',
    importance: Importance.high);

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey _globalKey = GlobalKey<NavigatorState>();

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalState>(
      create: (changeNotifierProviderContext) => GlobalState(),
      builder: (builderContext, child) {
        return NavigatorKey(
            globalKey: _globalKey,
            child: MaterialApp(
              navigatorKey: _globalKey,
              title: 'E-Lapor',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  platform: TargetPlatform.macOS,
                  primarySwatch: Colors.blue,
                  fontFamily: 'QuickSand'),
              home: SplashScreen(),
            ));
      },
    );
  }
}

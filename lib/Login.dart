import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/Future/AuthFuture.dart';
import 'package:e_lapor/SplashScreen.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/LocalStorage.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _nomorHandphoneController = TextEditingController();
  TextEditingController _kataSandiController = TextEditingController();

  bool _showPassword = false;
  bool _isButtonMasukBusy = false;
  String _token;
  bool _rememberMe = false;

  void initState() {
    super.initState();
    _initialization();
    _initPhoneAndPassword();
  }

  Future<void> _initialization() async {
    FirebaseMessaging _fcm = FirebaseMessaging.instance;
    String _fcmToken = await _fcm.getToken();
    await LocalStorage.setFCMToken(token: _fcmToken);

    setState(() {
      _token = _fcmToken;
    });
  }

  Future<void> _initPhoneAndPassword() async {
    Map<String, String> _savedUsernameAndPassword =
        await AuthFuture.getSavedUsernameAndPassword();
    if (_savedUsernameAndPassword != null) {
      _nomorHandphoneController.text = _savedUsernameAndPassword['username'];
      _kataSandiController.text = _savedUsernameAndPassword['password'];
    }
  }

  void dispose() {
    super.dispose();
    _nomorHandphoneController.dispose();
    _kataSandiController.dispose();
  }

  Future<String> _getAppVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo.version;
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    ClientPath.assetsImg + '/background_login.png'))),
      ),
      Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.leftAndRightContentContainerPadding),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(ClientPath.iconPath + '/bptp.png',
                  width: SizeConfig.horizontalBlock * 45.0),
              SizedBox(height: SizeConfig.horizontalBlock * 5.0),
              Text(
                'eLapor OPT DPI',
                style: TextStyle(
                    fontSize: SizeConfig.horizontalBlock * 6.25,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF1A6234)),
              ),
              Text('Mobile Apps',
                  style: TextStyle(
                      color: Color(0xFF323F4B),
                      fontSize: SizeConfig.horizontalBlock * 5.0)),
              SizedBox(height: SizeConfig.verticalBlock * 1.25),
              FutureBuilder(
                  future: _getAppVersion(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String _version = snapshot.data;

                      return Text(_version,
                          style: TextStyle(
                              color: Color(0xFF323F4B),
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.horizontalBlock * 3.5));
                    } else {
                      return SizedBox(
                          height: SizeConfig.horizontalBlock * 2.5,
                          width: SizeConfig.horizontalBlock * 2.5,
                          child: CircularProgressIndicator(strokeWidth: 1.5));
                    }
                  }),
              SizedBox(height: SizeConfig.horizontalBlock * 7.5),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomForm.textFieldLabel(context, label: 'NO. HANDPHONE'),
                SizedBox(height: 7.0),
                CustomForm.textField(context,
                    controller: _nomorHandphoneController,
                    keyboardType: TextInputType.phone,
                    hintText: 'Masukkan Nomor Handphone',
                    leading: SvgPicture.asset(ClientPath.svgPath + '/phone.svg',
                        color: CustomColors.eLaporIconColor),
                    leadingAndHintTextSpacing: 15.0)
              ]),
              SizedBox(height: SizeConfig.horizontalBlock * 5.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomForm.textFieldLabel(context, label: 'KATA SANDI'),
                SizedBox(height: 7.0),
                CustomForm.textField(context,
                    controller: _kataSandiController,
                    hintText: 'Masukkan Kata Sandi',
                    obsecureText: !_showPassword,
                    leading: SvgPicture.asset(ClientPath.svgPath + '/lock.svg',
                        color: CustomColors.eLaporIconColor),
                    leadingAndHintTextSpacing: 15.0,
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: SvgPicture.asset(ClientPath.svgPath + '/eye.svg',
                          color: CustomColors.eLaporIconColor),
                    )),
              ]),
              SizedBox(height: SizeConfig.horizontalBlock * 3.0),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: CustomColors.eLaporWhite,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Checkbox(
                        checkColor: CustomColors.eLaporGreen,
                        activeColor: CustomColors.eLaporWhite,
                        value: _rememberMe,
                        onChanged: (isChecked) {
                          setState(() {
                            _rememberMe = isChecked;
                          });
                        }),
                  ),
                  SizedBox(width: SizeConfig.horizontalBlock * 3.5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberMe = !_rememberMe;
                      });
                    },
                    child: Text('Remember Me',
                        style: TextStyle(
                            color: CustomColors.eLaporWhite,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.horizontalBlock * 5.0),
              Button.submitButton(context, 'MASUK', () async {
                setState(() {
                  _isButtonMasukBusy = true;
                });

                String _phone = _nomorHandphoneController.text;
                String _password = _kataSandiController.text;

                if (_rememberMe) {
                  await AuthFuture.saveUsernameAndPassword(_phone, _password);
                } else {
                  await AuthFuture.removeSavedUsernameAndPassword();
                }

                Map<String, dynamic> _formData = {
                  'phone': _phone,
                  'password': _password,
                  'token': _token
                };
                Map<String, dynamic> _authResponse =
                    await AkunFuture.autentikasiLogin(_formData);
                setState(() {
                  _isButtonMasukBusy = false;
                });
                if (_authResponse != null) {
                  String _statusLogin = _authResponse['status'];
                  if (_statusLogin.toLowerCase() ==
                      AkunFuture.loginSuccess.toLowerCase()) {
                    Map<String, dynamic> _dataLogin = _authResponse['data'];

                    await AkunFuture.setDataLogin(_dataLogin);

                    await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => SplashScreen()),
                        (route) => false);
                  } else {
                    String _subTitle = _authResponse['message'];
                    Widget _icons = Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button.button(context, 'Coba Lagi!', () {
                            Navigator.pop(context);
                          }, color: CustomColors.eLaporGreen)
                        ]);
                    await Alert.textComponent(context,
                        icon: SvgPicture.asset(
                            ClientPath.svgPath + '/danger.svg'),
                        title: 'Login Gagal',
                        subTitle: _subTitle,
                        actions: _icons);
                  }
                }
              },
                  color: CustomColors.eLaporGreen,
                  borderWidth: 1.0,
                  borderColor: CustomColors.eLaporGreen,
                  isBusy: _isButtonMasukBusy)
            ]),
          ),
        ),
      )
    ]));
  }
}

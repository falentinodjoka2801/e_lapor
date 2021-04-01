import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';

class Login extends StatefulWidget {
  final void Function() masuk;
  Login(this.masuk);
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = false;

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return Stack(children: [
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
              SizedBox(height: SizeConfig.horizontalBlock * 7.5),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomForm.textFieldLabel(context, label: 'NO. HANDPHONE'),
                SizedBox(height: 7.0),
                CustomForm.textField(context,
                    keyboardType: TextInputType.phone,
                    hintText: 'Masukkan Nomor Handphone',
                    leading:
                        Icon(Icons.phone, color: CustomColors.eLaporIconColor),
                    leadingAndHintTextSpacing: 15.0)
              ]),
              SizedBox(height: SizeConfig.horizontalBlock * 5.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomForm.textFieldLabel(context, label: 'KATA SANDI'),
                SizedBox(height: 7.0),
                CustomForm.textField(context,
                    hintText: 'Masukkan Kata Sandi',
                    obsecureText: !_showPassword,
                    leading:
                        Icon(Icons.lock, color: CustomColors.eLaporIconColor),
                    leadingAndHintTextSpacing: 15.0,
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                          (_showPassword)
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: CustomColors.eLaporIconColor),
                    )),
              ]),
              SizedBox(height: SizeConfig.horizontalBlock * 5.0),
              Button.submitButton(context, 'MASUK', () {
                widget.masuk();
              },
                  color: CustomColors.eLaporGreen,
                  borderWidth: 1.0,
                  borderColor: CustomColors.eLaporGreen)
            ]),
          ),
        ),
      )
    ]);
  }
}

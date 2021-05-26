import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Alert {
  static const double _borderRadiusCircular = 15.0;

  static dynamic alertServerBermasalah(BuildContext context) async {
    Widget _icon = SvgPicture.asset(ClientPath.svgPath + '/danger.svg');
    String _title = 'Server Tidak Merespon!';
    String _subTitle = 'Silahkan ulangi kembali !';
    Widget _actions = Button.button(context, 'OK', () {
      Navigator.pop(context);
    }, color: CustomColors.dangerColor);
    return await Alert.textComponent(context,
        icon: _icon, title: _title, subTitle: _subTitle, actions: _actions);
  }

  static dynamic textComponent(BuildContext _alertBuildContext,
      {@required Widget icon,
      @required String title,
      @required String subTitle,
      @required Widget actions,
      bool isDismissible = false,
      bool useRouteNavigator = false}) {
    return showDialog(
        barrierDismissible: isDismissible,
        context: _alertBuildContext,
        useRootNavigator: useRouteNavigator,
        builder: (_showDialogContext) {
          return Dialog(
              elevation: 0.0,
              insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_borderRadiusCircular)),
              child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(_borderRadiusCircular)),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (icon != null) ? icon : SizedBox(),
                        SizedBox(height: 25.0),
                        (title != null)
                            ? Text(title,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700))
                            : SizedBox(),
                        SizedBox(height: (title != null) ? 22.4 : 0.0),
                        Text(subTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0)),
                        SizedBox(height: 16.0),
                        actions
                      ])));
        });
  }

  static dynamic widgetComponent(BuildContext _alertBuildContext,
      {@required Widget icon,
      @required Widget body,
      @required Widget actions,
      bool isDismissible = false,
      bool useRouteNavigator = false,
      bool showCloseButton = false}) {
    return showDialog(
        barrierDismissible: isDismissible,
        context: _alertBuildContext,
        useRootNavigator: useRouteNavigator,
        builder: (_showDialogContext) {
          return Stack(
            children: [
              Dialog(
                  elevation: 0.0,
                  insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(_borderRadiusCircular)),
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(_borderRadiusCircular)),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              (icon != null) ? icon : SizedBox(),
                              SizedBox(height: 26.0),
                              body,
                              (actions != null)
                                  ? SizedBox(height: 16.0)
                                  : SizedBox(),
                              (actions != null) ? actions : SizedBox()
                            ]),
                      ))),
              Positioned(
                  top: 0.0,
                  right: 15.0,
                  child: IconButton(
                      icon: Icon(Icons.close_rounded,
                          color: CustomColors.dangerColor),
                      onPressed: () => Navigator.pop(_alertBuildContext)))
            ],
          );
        });
  }
}

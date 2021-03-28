import 'package:flutter/material.dart';

class Alert {
  static const double _borderRadiusCircular = 15.0;

  static dynamic textComponent(BuildContext _alertBuildContext,
      {@required String icon,
      @required String title,
      @required String subTitle,
      @required Widget actions,
      bool isDismissible = false}) {
    return showDialog(
        barrierDismissible: isDismissible,
        context: _alertBuildContext,
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
                        ClipRRect(
                            borderRadius: BorderRadius.circular(77.0),
                            child:
                                Image.asset(icon, width: 77.0, height: 77.0)),
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
      {@required String icon,
      @required Widget body,
      @required Widget actions,
      bool isDismissible = false}) {
    return showDialog(
        barrierDismissible: isDismissible,
        context: _alertBuildContext,
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
                        ClipRRect(
                            borderRadius: BorderRadius.circular(77.0),
                            child:
                                Image.asset(icon, width: 77.0, height: 77.0)),
                        SizedBox(height: 26.0),
                        body,
                        SizedBox(height: 16.0),
                        actions
                      ])));
        });
  }
}

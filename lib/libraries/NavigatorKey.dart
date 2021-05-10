import 'package:flutter/material.dart';

class NavigatorKey extends InheritedWidget {
  final GlobalKey globalKey;
  final Widget child;

  NavigatorKey({@required this.globalKey, @required this.child})
      : super(child: child);

  static NavigatorKey of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NavigatorKey>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

import 'package:flutter/material.dart';

import 'package:e_lapor/Navigation/TabItem.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  TabNavigator({@required this.navigatorKey, @required this.tabItem});

  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> _routeBuilder = _routeBuilderFunction(context);
    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (setting) {
          return MaterialPageRoute(
              builder: (materialPageRouteContext) =>
                  _routeBuilder[setting.name](materialPageRouteContext));
        });
  }

  Map<String, WidgetBuilder> _routeBuilderFunction(
      BuildContext routeBuilderFunctionContext) {
    return {TabNavigatorRoutes.root: (context) => tabRootWidget[tabItem]};
  }
}

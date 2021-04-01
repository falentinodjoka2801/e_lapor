import 'package:flutter/foundation.dart';

import 'package:e_lapor/Navigation/TabItem.dart';

class GlobalState with ChangeNotifier {
  TabItem _currentTabItem = TabItem.beranda;
  TabItem get currentTabItem => _currentTabItem;
  set currentTabItem(TabItem newTabItem) {
    _currentTabItem = newTabItem;
    notifyListeners();
  }
}

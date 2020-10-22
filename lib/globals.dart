import 'package:flutter/cupertino.dart';

class AppGlobals {
  static final GlobalKey<NavigatorState> _rootNavKey = GlobalKey();

  static NavigatorState get nav => _rootNavKey.currentState;
}

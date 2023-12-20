import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intenWithData(String routeName, Object argument) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: argument);
  }
}
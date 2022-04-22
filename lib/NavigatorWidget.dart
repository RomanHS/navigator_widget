import 'package:flutter/material.dart';

class NavigatorWidgetModel {
  final GlobalKey<NavigatorState> navigatorStateKey;
  final GlobalKey<NavigatorState>? perentNavigatorStateKey;

  NavigatorWidgetModel({
    required this.perentNavigatorStateKey,
    required this.navigatorStateKey,
  });

  void perentNavigatorPop(BuildContext context) {
    if (perentNavigatorStateKey == null) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      perentNavigatorStateKey?.currentState?.pop();
    }
  }
}

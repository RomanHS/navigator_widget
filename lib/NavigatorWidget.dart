import 'package:flutter/material.dart';

class NavigatorWidgetModel {
  final GlobalKey<NavigatorState> navigatorStateKey;
  final GlobalKey<NavigatorState>? perentNavigatorStateKey;
  final Future<bool> Function()? onWillPop;

  NavigatorWidgetModel({
    required this.perentNavigatorStateKey,
    required this.navigatorStateKey,
    this.onWillPop,
  });

  void perentNavigatorPop(BuildContext context) async {
    final Future<bool> Function()? _onWillPop = onWillPop;

    if (_onWillPop != null) {
      final bool res = await _onWillPop();

      if (res == false) return;
    }

    if (perentNavigatorStateKey == null) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      perentNavigatorStateKey?.currentState?.pop();
    }
  }
}

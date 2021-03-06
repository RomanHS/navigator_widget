library navigator_widget;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NavigatorWidget.dart';

class NavigatorWidget extends StatefulWidget {
  final String initialRoute;

  final GlobalKey<NavigatorState>? navigatorKey;

  final Route<dynamic>? Function(RouteSettings) onGenerateRoute;

  final Future<bool> Function()? onWillPop;

  const NavigatorWidget({
    Key? key,
    required this.onGenerateRoute,
    required this.initialRoute,
    this.onWillPop,
    this.navigatorKey,
  }) : super(key: key);

  @override
  State<NavigatorWidget> createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  late final GlobalKey<NavigatorState> key;

  @override
  void initState() {
    key = widget.navigatorKey ?? GlobalKey<NavigatorState>();
    super.initState();
  }

  // late final NavigatorProvider navigatorProvider;

  // @override
  // void initState() {
  //   navigatorProvider = context.read<NavigatorProvider>();
  //   navigatorProvider.add(key);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   navigatorProvider.remove(key);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => NavigatorWidgetModel(
        onWillPop: widget.onWillPop,
        navigatorStateKey: key,
        perentNavigatorStateKey: context.read<NavigatorWidgetModel?>()?.navigatorStateKey,
      ),

      ///
      child: WillPopScope(
        ///
        onWillPop: () async {
          final bool res = !(await key.currentState!.maybePop());

          if (res == false) return false;

          final Future<bool> Function()? _onWillPop = widget.onWillPop;

          if (_onWillPop == null) return res;

          return _onWillPop();
        },

        ///
        child: Navigator(
          initialRoute: widget.initialRoute,
          key: key,
          onGenerateRoute: widget.onGenerateRoute,
        ),
      ),
    );
  }
}

class CloseButtonWidget extends StatelessWidget {
  final Widget? icon;

  const CloseButtonWidget({
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<NavigatorWidgetModel>().perentNavigatorPop(context),
      icon: icon ?? const Icon(Icons.close),
    );
  }
}

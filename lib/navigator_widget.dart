library navigator_widget;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NavigatorWidget.dart';

class NavigatorWidget extends StatefulWidget {
  final String initialRoute;

  final Route<dynamic>? Function(RouteSettings) onGenerateRoute;

  const NavigatorWidget({
    Key? key,
    required this.onGenerateRoute,
    required this.initialRoute,
  }) : super(key: key);

  @override
  State<NavigatorWidget> createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  final key = GlobalKey<NavigatorState>();
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
        navigatorStateKey: key,
        perentNavigatorStateKey: context.read<NavigatorWidgetModel?>()?.navigatorStateKey,
      ),

      ///
      child: WillPopScope(
        ///
        onWillPop: () async => !(await key.currentState!.maybePop()),

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
  const CloseButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<NavigatorWidgetModel>().perentNavigatorPop(context),
      icon: const Icon(Icons.close),
    );
  }
}

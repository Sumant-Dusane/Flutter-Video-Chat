import 'package:flutter/material.dart';

class Router extends MaterialPageRoute {
  Router({required WidgetBuilder builder, required RouteSettings settings})
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
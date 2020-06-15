import 'package:bsttest/app/logger.dart';
import 'package:bsttest/constants/app_routes.dart';
import 'package:bsttest/ui/views/login/login_view.dart';
import 'package:bsttest/ui/views/signals/signals_view.dart';
import 'package:flutter/material.dart';

var logger = getLogger("Routes");

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    logger.i(
        'generateRoute | name: ${settings.name} arguments: ${settings.arguments}');

    switch (settings.name) {
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.Signals:
        return MaterialPageRoute(builder: (_) => SignalsView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

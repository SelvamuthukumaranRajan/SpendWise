import 'package:flutter/material.dart';
import 'package:spend_wise/utils/routes/routes_names.dart';
import 'package:spend_wise/views/summary_screen.dart';

import '../../views/auth_screen.dart';
import '../../views/home_screen.dart';
import '../../views/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case (RouteNames.authScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const AuthScreen());
      case (RouteNames.homeScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case (RouteNames.summaryScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SummaryScreen(),
            settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}

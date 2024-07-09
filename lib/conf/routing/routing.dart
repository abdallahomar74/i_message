import 'package:flutter/material.dart';
import 'package:i_message/pages/auth_screens/login_screen.dart';
import 'package:i_message/pages/auth_screens/register_screen.dart';
import 'package:i_message/pages/home_screen/home_screen.dart';
import 'package:i_message/pages/settings_screen/settings_screen.dart';
import 'package:i_message/pages/splash_screen/splash_screen.dart';

class MyRouting {
  static List<Route> initRoutes = [
    MaterialPageRoute<dynamic>(
      builder: (context) => const SplashScreen(),
    )
  ];
  static Route<dynamic> onGenrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case 'login':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        );
      case 'register':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => RegisterScreen(),
        );
      case 'home':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const HomeSreen(),
        );
      case 'settings':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SettingsScreen(),
        );
      
      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        );
    }
  }
}

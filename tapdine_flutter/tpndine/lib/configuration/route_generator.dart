import 'package:flutter/material.dart';
import 'package:tpndine/view/auth/login_page.dart';
import 'package:tpndine/view/auth/root_page.dart';
import 'package:tpndine/view/auth/signup_page.dart';
import 'package:tpndine/view/home/home_page.dart';
import 'package:tpndine/view/home/restaurant_view/item_view.dart';

/// This class managaes the routing for the app.
/// All the routes are encapsulated in this class to make it
/// more efficient to route.
///
/// All mentions of the MaterialPageRoute are only mentioned here and
/// nowhere in the app.
///
/// To access a route from this class, one has to call Navigator.pushNamed()
/// The pushNamed() maethod takes a the name of the route such as
/// Navigator.of(context).pushNamed('/login);
///
/// Passing multiple paramaeters is only possible through a map since the constructors
/// only take 1 parameter.
///
/// @author [Aditya Pratap]
/// @version 1.0
///
class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final _args = settings.arguments as Map;

    // settings.name contains the name(path) of the route.
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const RootPage());

      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginPage(
                  auth: null,
                ));

      case '/signup':
        return MaterialPageRoute(
            builder: (_) => SignUpPage(
                  loginCallback: _args['loginCallback'],
                  auth: _args['auth'],
                ));

      case '/home':
        return MaterialPageRoute(
            builder: (_) => HomePage(
                  thisUser: _args['thisUser'],
                ));

      case '/details':
        return MaterialPageRoute(
            builder: (_) => DetailsPage(
                  heroTag: _args['heroTag'],
                ));

      default:
        return null;
    }
  }
}

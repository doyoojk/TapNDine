import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpndine/configuration/constraints.dart';
import 'package:tpndine/view/auth/root_page.dart';
import 'configuration/locator.dart';
import 'configuration/route_generator.dart';

Future main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(RestartWidget(child: MyApp()));
}

/// This class is the entry point into the application.
///
/// @author [Aditya Pratap]
/// @version 1.0
class MyApp extends StatelessWidget with ChangeNotifier {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap N Dine',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backGroundColor,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const RootPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

/// This class is utilized to restart the app or deep clean the app.
///
/// When a user logs out of their account, there remain few objects which
/// still hold data from the previos user.
///
/// Restarting the app cleans all the objects and any other data stored and alllows
/// for a fresh login.
///
/// @author [Aditya Pratap]
/// @modified []
/// @verision 1.0
class RestartWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RestartWidget({required this.child});
  final Widget child;
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

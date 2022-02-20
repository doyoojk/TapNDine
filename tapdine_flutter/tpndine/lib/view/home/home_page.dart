import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpndine/configuration/constraints.dart';
import 'package:tpndine/configuration/size_config.dart';
import 'package:tpndine/models/user.dart';
import 'package:tpndine/view/home/profile_page.dart';
import 'package:tpndine/view/home/restaurant_page.dart';
import 'package:tpndine/view_models/navigation_model.dart';

import 'cart_page.dart';
import 'info_page.dart';
import 'nfc_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  UserModel thisUser;
  HomePage({Key? key, required this.thisUser}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _height;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: 2, viewportFraction: 1.0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _height = SizeConfig.screenHeight;

    return ChangeNotifierProvider<NavigationModel>(
      create: (context) => NavigationModel(),
      child: Consumer<NavigationModel>(
        builder: (context, navigationModel, _) => Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              index: navigationModel.currentPage,
              items: <Widget>[
                Icon(Icons.info, size: _height * .04, color: Colors.black),
                Icon(Icons.person, size: _height * .04, color: Colors.black),
                Icon(Icons.dashboard, size: _height * .04, color: Colors.black),
                Icon(Icons.shopping_bag,
                    size: _height * .04, color: Colors.black),
                Icon(
                  Icons.nfc,
                  size: _height * .04,
                  color: Colors.black,
                ),
              ],
              color: backGroundColor,
              height: _height * .06,
              buttonBackgroundColor: Colors.lightGreenAccent,
              backgroundColor: primaryColor,
              animationCurve: Curves.easeInOut,
              onTap: (index) {
                navigationModel.currentPage = index;
                _pageController.animateToPage(navigationModel.currentPage,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
            ),
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      navigationModel.currentPage = page;
                    },
                    children: [
                      InfoPage(),
                      ProfilePage(),
                      RestaurantPage(),
                      CartPage(),
                      NFCPage()
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tpndine/models/user.dart';
import 'package:tpndine/services/user_authentication.dart';
import 'package:tpndine/view/home/home_page.dart';

import 'login_page.dart';

/// This enumeration keeps track of a user's authentication status.
/// The status types include user email verification and authentication.
///
/// If the user logs in , it is convinient to keep the user logged in
/// whenever they open the app, hence, [LOGGED_IN], [NOT_LOGGED_IN], and [NOT_DETERMINED].
///
/// The verification status checks if a user's email is verified
/// The tags are [NOT_DETERMINED], [NOT_VERIFIED], and [VERIFIED].
///
/// @author [Aditya Pratap]
/// @modified[]
/// @version 1.0
///
enum AuthStatus { NOT_DETERMINED, NOT_LOGGED_IN, LOGGED_IN }

enum VerifyStatus {
  NOT_DETERMINED,
  NOT_VERIFIED,
  VERIFIED,
}

/// The root page class controls the destination of the user when they open the ap.
///
/// If the user is already logged in, the user is directed to the home page.
/// If the user is not logged in, then the user is directed to the login page.
/// If the user's status is not verified or not determined, the user is directed to a pop up the prompts
/// the user to verify their email.
///
/// @auhtor [Aditya Pratap]
/// @version 1.0
class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.NOT_DETERMINED;
  VerifyStatus _verifyStatus = VerifyStatus.NOT_DETERMINED;

  late BaseAuth _auth;
  late UserModel _thisUser;

  // Changes authStatus from NOT_DETERMINED to either LOGGED_IN or NOT_LOGGED_IN
  @override
  void initState() {
    super.initState();
    _auth = Auth();
    _thisUser = UserModel();
    _auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _thisUser.setUserId = user.uid;
        }

        //if user or uid is null then the status is NOT_LOGGED_IN, otherwise it's LOGGED_IN
        _authStatus =
            user == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
        if (user != null && _authStatus == AuthStatus.LOGGED_IN) {
          _verifyStatus = user.emailVerified
              ? VerifyStatus.VERIFIED
              : VerifyStatus.VERIFIED;
        }
      });
    });
  }

  /// This method executes when the user tries to log in to the app.
  /// After the user logs in to the app, the login status and the
  /// verification status are updated (depending on whether the user verified).
  ///
  /// Depending upon the status, the user is directed to the corresponding page.
  ///
  /// @precondition none.
  /// @postcondition The authentication and the verification status' are updated.
  void loginCallback() {
    _auth.getCurrentUser().then((user) {
      setState(() {
        _thisUser.setUserId = user!.uid.toString();

        // Since user logged in, set the log in status to log in.
        _authStatus = AuthStatus.LOGGED_IN;

        // Check if the user is verified and set respectful status.
        _verifyStatus =
            user.emailVerified ? VerifyStatus.VERIFIED : VerifyStatus.VERIFIED;
      });
    });
  }

  /// This method executes when the user tries to log out of the app.
  /// After the user logs out, the login status and the
  /// verification status are updated (depending on whether the user verified).
  ///
  /// Depending upon the status, the user is directed to the corresponding page.
  ///
  /// @precondition none.
  /// @postcondition The authentication and the verification status' are updated.
  void logoutCallback() {
    setState(() {
      // Since user has logged out, set status to NOT_LOGGED_IN.
      _authStatus = AuthStatus.NOT_LOGGED_IN;
      _verifyStatus = VerifyStatus.NOT_DETERMINED;
      _thisUser.setUserId = "";
    });
  }

  /// This method builds circulr progress indicator/ loading indicator.
  /// When a user logs in or out, it takes some time to execute that function in the cloud.
  /// During that time, the waiting screen is displayed.
  ///
  /// @precondition none
  /// @return A scaffold containing the circular progress indicator.
  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  /// This method gets the destination page depending uopn the auth status of the user.
  ///
  /// @param [context] The location of the widget in the widget tree.
  /// @precondition The context cannot be null.
  ///
  /// @return A widget that is the corresponding page.
  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
      case AuthStatus.NOT_LOGGED_IN:

        // If the user is not logged in, return the LoginPage.
        return LoginPage(
          auth: _auth,
          loginCallback: loginCallback,
        );
      case AuthStatus.LOGGED_IN:
        if (_thisUser.getUserId.length == 0 || _thisUser.getUserId == null) {
          return buildWaitingScreen();
        }

        if (_verifyStatus == VerifyStatus.VERIFIED) {
          // If user is verified and logged in, return the HomePage.
          return HomePage(
            thisUser: _thisUser,
          );
        }

        return Text(
            "Uh oh buddy, if you're seeing this, something must be FUBAR :(.");
      default:
        return buildWaitingScreen();
    }
  }
}

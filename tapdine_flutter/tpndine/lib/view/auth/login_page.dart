// ignore_for_file: unnecessary_this
import 'package:flutter/material.dart';
import 'package:tpndine/configuration/constraints.dart';
import 'package:tpndine/configuration/input_validator.dart';
import 'package:tpndine/configuration/size_config.dart';
import 'package:tpndine/services/user_authentication.dart';

/// This is the login authentication page of the application.
/// This page contains the login, signup, forgot password, and google sign in buttons.
/// This is the landing page of the application when first opened.
///
/// @author [Aditya Pratap]
/// @version 1.0
class LoginPage extends StatefulWidget {
  final BaseAuth? auth;
  final VoidCallback? loginCallback;

  LoginPage({required this.auth, this.loginCallback});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

/// This is the statefull class and child of the LoginPage
/// This class maintains state changes that may occur.
///
/// @author [Aditya Pratap]
/// @modified []
/// @version 1.0
class _LoginPageState extends State<LoginPage> {
  // Height and width of the screen.
  double _height = 0;
  double _width = 0;

  String _errorMessage = "";

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // Initialize the instance variables.
    _height = SizeConfig.screenHeight;
    _width = SizeConfig.screenWidth;
    return Scaffold(
      body: ListView(
        children: <Widget>[this._showLogo(context), this._showForm(context)],
      ),
    );
  }

  /// This method creates and displays the logo of the app on the login page.
  /// The logo contains the name of the app, a one-sentence description and LogIn text.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains childre.
  Widget _showLogo(BuildContext context) {
    // A nice animation that slides in the logo in a second's duration.
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: this._width * .02, top: this._height * .10),
            child: Text("Tap'N Dine",
                style: TextStyle(
                    fontSize: this._width * .20,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat')),
          ),
          RichText(
              text: const TextSpan(
                  text: "Restaurant Made Easy!",
                  style: TextStyle(color: Colors.green))),
          SizedBox(height: this._height * .05),
          RichText(
              text: TextSpan(
                  text: "LOG IN",
                  style: TextStyle(fontSize: this._width * .05)))
        ],
      ),
    );
  }

  /// This method builds and returns the log in authentication form.
  /// The form contains a email address input, a password input, the log in method,
  /// and the sign up button in a column.
  ///
  /// The buttons are included in _showForm becasue the login and signup buttons
  /// are directly related to user authentication.
  ///
  /// This form will contain an form key [_formkey] that will save the fields,
  /// and submit for authentication with firebase.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new container widget that contains children.
  Widget _showForm(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Form(
          key: this._formKey,
          child: Column(
            children: <Widget>[
              // Input fields
              this._showEmailAndPasswordInputs(context),

              // Log In button
              this._showLoginButton(context),

              this._showErrorMessage(),

              // Sign Up  button
              this._showSignUpButton(context),
            ],
          ),
        ));
  }

  /// This method builds and returns the input fields that are email address
  /// and password.
  ///
  /// The input fields are TextFormFields, that means the fields can have validators
  /// that can validate the format of the input.
  ///
  /// The passowrd field is obscured that is the text will not show to maintain privacy.
  /// Instead, a standard password hiding dots will display.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the input fields.
  Widget _showEmailAndPasswordInputs(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(30, this._height * .02, 30, this._height * .05),
      child: Column(
        children: <Widget>[
          TextFormField(
            cursorColor: primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email Address",
              labelStyle: const TextStyle(color: Colors.green),
              prefixIcon: const Icon(
                Icons.mail,
                color: primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: this._emailController,
            onSaved: (value) => this._emailController.text = value!.trim(),
            validator: (value) => InputValidator.email(value!),
            style: const TextStyle(
                color: Colors.black, decorationColor: Colors.white),
          ),
          SizedBox(
            height: this._height * .05,
          ),
          TextFormField(
            obscureText: true,
            cursorColor: primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: const TextStyle(color: primaryColor),
              prefixIcon: const Icon(
                Icons.vpn_key,
                color: primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: this._passwordController,
            onSaved: (value) => this._passwordController.text = value!.trim(),
            validator: (value) => InputValidator.password(value!),
            style: const TextStyle(
                color: Colors.black, decorationColor: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.only(left: this._width * .40),
              child: const Text(
                "Forgot Password?",
                maxLines: 1,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                ),
              )),
        ],
      ),
    );
  }

  /// This method builds and returns the Log In button that authenticates
  /// a user into the app.
  ///
  /// Once clicked, the app routes to the HomePage.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the button.
  Widget _showLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // On login button pressed, validate the fields and log in.
        this._validateAndLogIn();
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: this._width * .05, right: this._width * .05),
        child: Container(
          height: .07 * this._height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: primaryColor),
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                  color: backGroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: this._width * .07),
            ),
          ),
        ),
      ),
    );
  }

  /// This method builds and returns the Sign Up button that registers
  /// the user to the app.
  ///
  /// Once clicked, the app routes back to the Log In page.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the button.
  Widget _showSignUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Named route to the sign up page.
        Navigator.of(context).pushNamed('/signup', arguments: {
          'loginCallback': this.widget.loginCallback,
          'auth': this.widget.auth
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: this._width * .05,
            right: this._width * .05,
            top: this._height * .05),
        child: Container(
          height: .07 * this._height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.transparent,
            border: Border.all(
                color: primaryColor, style: BorderStyle.solid, width: 2.0),
          ),
          child: Center(
            child: Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: this._width * .07),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showErrorMessage() {
    //If there is an error message, display it.
    if (this._errorMessage.isNotEmpty) {
      return Text(
        this._errorMessage,
        style: const TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  /// This method verifies if all the inputs for the fields have been entered appropriately,
  /// and saves the vales.
  ///
  /// @precondition none.
  /// @return A boolean indicating if all the inputs have been eneterd appropriately.
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// This method signs user into the app by calling the SignIn method and the logincallback method from the Auth class.
  ///
  /// @precondition none
  /// @postcondition The user is validated, and signed in to the app.
  void _validateAndLogIn() async {
    if (this._validateAndSave()) {
      setState(() {
        this._errorMessage = "";
      });

      try {
        // Sign In using the entered email and password.
        String? uId = await widget.auth
            ?.signIn(this._emailController.text, this._passwordController.text);

        setState(() {});

        //if user was successfully logged in, execute loginCallback()
        if (await this.widget.auth?.getCurrentUser() != null) {
          widget.loginCallback!();
        }
      } catch (e) {
        // If log in is unsuccessful, print the error message and reset the form.
        setState(() {
          this._errorMessage = e.toString();
          this._formKey.currentState?.reset();
        });
      }
    }
  }
}

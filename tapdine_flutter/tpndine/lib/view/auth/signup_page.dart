import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpndine/configuration/constraints.dart';
import 'package:tpndine/configuration/fade_animation.dart';
import 'package:tpndine/configuration/input_validator.dart';
import 'package:tpndine/configuration/size_config.dart';
import 'package:tpndine/models/user.dart';
import 'package:tpndine/services/user_authentication.dart';

/// This is the Sign Up registration page of the application.
/// This class contains the sign up form and the sign up button.
///
/// The user signs up using first name, last name, email address, password.
///
/// @author [Aditya Pratap]
/// @version 1.0
class SignUpPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  const SignUpPage({Key? key, required this.auth, required this.loginCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

/// This is the statefull class and child of the SignUpPage.
/// This class maintains state changes that may occur.
///
/// @author [Aditya Pratap]
/// @modified []
/// @version 1.0
class SignUpPageState extends State<SignUpPage> {
  late double _height;
  late double _width;

  late String _errorMessage;
  late bool _isLoading;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  late UserModel _thisUser;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    //executes after build is done
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _thisUser = UserModel();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize instance varibales
    SizeConfig().init(context);
    _height = SizeConfig.screenHeight;
    _width = SizeConfig.screenWidth;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          _showBackButton(context),
          _showSignUpText(context),
          _showSignUpForm(context)
        ],
      ),
    );
  }

  /// This method builds the back button to navigate to the previous screen.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  ///
  /// @precondition none
  /// @return A new padding containing the IconButton.
  Widget _showBackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: _width * .10, top: _height * .02),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
            size: _width * .1,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  /// This method creates and displays the 'Sign Up' text on the Sign Up page.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains children.
  Widget _showSignUpText(BuildContext context) {
    // A neat fade in animation af all the contained children.
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: _height * .01),
        child: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.green,
              fontSize: _width * .15,
              fontFamily: 'Montserrat'),
        ),
      ),
    );
  }

  /// This method builds and returns the sign up registration form.
  /// The form contains a first name, last name, email address, password, and
  /// a confirm password text fields. Additionally, the page also contains a
  /// sign up button.
  ///
  /// The buttons are included in _showForm becasue the signup button
  /// is directly related to user registration.
  ///
  /// This form will contain an form key [_formkey] that will save the fields,
  /// and submit for authentication with firebase.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new container widget that contains children.
  _showSignUpForm(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _showFirstAndLastNameInputs(context),
              // Input fields
              _showEmailAndPasswordInputs(context),
              // Sign Up  button
              _showSignUpButton(context),
            ],
          ),
        ));
  }

  /// This method builds and returns the input fields that are first name and last name.
  ///
  /// The input fields are TextFormFields, that means the fields can have validators
  /// that can validate the format of the input.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the input fields.
  Widget _showFirstAndLastNameInputs(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, _height * .05, 30, _height * .05),
      child: Column(
        children: <Widget>[
          TextFormField(
            cursorColor: primaryColor,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: "First Name",
              labelStyle: const TextStyle(color: primaryColor),
              prefixIcon: const Icon(
                Icons.person,
                color: primaryColor,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: _firstNameController,
            validator: (value) => InputValidator.fname(value!),
            style: const TextStyle(
                color: Colors.black, decorationColor: Colors.white),
            onSaved: (value) => _firstNameController.text = value!.trim(),
          ),
          SizedBox(
            height: _height * .05,
          ),
          TextFormField(
            cursorColor: primaryColor,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: "Last Name",
              labelStyle: const TextStyle(color: primaryColor),
              prefixIcon: const Icon(
                Icons.person,
                color: primaryColor,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: _lastNameController,
            validator: (value) => InputValidator.lname(value!),
            onSaved: (value) => _lastNameController.text = value!.trim(),
            style: const TextStyle(
                color: Colors.black, decorationColor: Colors.white),
          ),
        ],
      ),
    );
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
  /// The confirm password textfield checks for equality with the passsword field to make
  /// sure the user entered an intnded password.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the input fields.
  Widget _showEmailAndPasswordInputs(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, _height * .05),
      child: Column(
        children: <Widget>[
          TextFormField(
            cursorColor: primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email Address",
              labelStyle: const TextStyle(color: primaryColor),
              prefixIcon: const Icon(
                Icons.mail,
                color: primaryColor,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: _emailController,
            validator: (value) => InputValidator.email(value!),
            onSaved: (value) => _emailController.text = value!.trim(),
            style: const TextStyle(
                color: Colors.black, decorationColor: Colors.white),
          ),
          SizedBox(
            height: _height * .05,
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
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: _passwordController,
            validator: (value) => InputValidator.password(value!),
            onSaved: (value) => _passwordController.text = value!.trim(),
            style: const TextStyle(
                color: Colors.black, decorationColor: Colors.white),
          ),
          SizedBox(
            height: _height * .05,
          ),
          TextFormField(
            obscureText: true,
            cursorColor: primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              labelStyle: const TextStyle(color: primaryColor),
              prefixIcon: const Icon(
                Icons.vpn_key,
                color: primaryColor,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: _confirmPasswordController,
            validator: (value) => value != _passwordController.text
                ? 'Passwords do not match'
                : null,
            onSaved: (value) => _confirmPasswordController.text = value!.trim(),
            style: const TextStyle(
                color: Colors.black, decorationColor: Colors.white),
          ),
        ],
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
        // TO-DO Lead the user to the sign up page for registration.
        _validateAndSignUp();
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: _width * .05, right: _width * .05, top: _height * .01),
        child: Container(
          height: .07 * _height,
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
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: _width * .07),
            ),
          ),
        ),
      ),
    );
  }

  /// This method verifies if all the inputs for the fields have been entered appropriately,
  /// and saves the vales.
  ///
  /// @precondition none.
  /// @return A boolean indicating if all the inputs have been eneterd appropriately.
  ///
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// This method registers the user into the app by calling the signUp method and the logincallback method from the Auth class.
  ///
  /// @precondition none
  /// @postcondition The user is validated, registered, and signed in to the app.
  void _validateAndSignUp() async {
    if (_validateAndSave()) {
      setState(() {
        _errorMessage = "";
        _isLoading = true;
      });

      try {
        _thisUser.setUserId = await widget.auth
            .signUp(_emailController.text, _passwordController.text);

        //check if user has been successfully signed up
        if (widget.auth.getCurrentUser() != null) {
          //finish loading
          setState(() {
            _isLoading = false;
          });

          //Log in
          widget.loginCallback();
        }
      } catch (e) {
        if (e is PlatformException) {
          // Check if the current emial already exists.
          if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            // If email already exists, warn user using an alert dialog from the GeneralWidgets class.
          }
        }
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
          _formKey.currentState?.reset();
        });
      }
    }
  }
}

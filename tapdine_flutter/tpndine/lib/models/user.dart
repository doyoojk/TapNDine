import 'package:flutter/cupertino.dart';

/// This model class keeps track of the User's attributes.
///
/// @author [Aditya Pratap]
/// @version 1.0
class UserModel extends ChangeNotifier {
  String firstName = "";
  String lastName = "";
  String userId = "";

  /// This 3-parameter optional named prameters constructors initializes the instance variables.
  ///
  /// @param [firstName] The first name of the current user.
  /// @param [lastName] The last name of the current user.
  /// @param [userId] The firebase user id of the current user.
  ///
  /// @precondition The parameters cannot be null or empty.
  /// @postcondition A new User object with initialized values.

  /// This setter method sets the firstName instance variable with
  /// the specified value.
  ///
  /// @param [fname] The first name to be set.
  ///
  /// @precondition The parameter cannot be null or empty.
  /// @postcondition The [_firstName] instance variable is assigned.
  set setFirstName(String fname) {
    if (fname.isEmpty) {
      throw ArgumentError("The first name cannot be null or empty");
    }
    firstName = fname;
  }

  /// This getter method gets the first name of the current user.
  ///
  /// @precondition none
  /// @return The first name of the current user.
  get getFirstName {
    return firstName;
  }

  /// This setter method sets the lastName instance variable with
  /// the specified value.
  ///
  /// @param [lname] The last name to be set.
  ///
  /// @precondition The parameter cannot be null or empty.
  /// @postcondition The [_lastName] instance variable is assigned.
  ///
  set setLastName(String lname) {
    if (lname.isEmpty) {
      throw ArgumentError("The last name cannot be null or empty");
    }
    lastName = lname;
  }

  /// This getter method gets the last name of the current user.
  ///
  /// @precondition none
  /// @return The last name of the current user.
  get getLastName {
    return lastName;
  }

  /// This setter method sets the userId instance variable with
  /// the specified value.
  ///
  /// @param [uId] The user id to be set.
  ///
  /// @precondition The parameter cannot be null or empty.
  /// @postcondition The [_userId] instance variable is assigned.
  set setUserId(String uId) {
    userId = uId;
  }

  /// This getter method gets the user Id of the current user.
  ///
  /// @precondition none
  /// @return The user Id of the current user.
  get getUserId {
    return userId;
  }
}

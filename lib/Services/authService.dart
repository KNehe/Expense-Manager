import 'package:expensetracker/Utilities/errorHandler.dart';
import 'package:expensetracker/models/user.dart';
import 'package:expensetracker/screens/authenticate/sign_in_up.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating a custom user object from a FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get getUser {
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }

  Future<bool> signInUser(String email, String password,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      saveToSharedPreferences();

      return true;
    } catch (signUpError) {
      ErrorHandler.determineAuthError(signUpError, scaffoldKey);

      return false;
    }
  }

  Future signUpUser(String email, String password,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      saveToSharedPreferences();

      Navigator.pushReplacementNamed(context, Home.id);
    } catch (signUpError) {
//      print('firebase signin error is: $signUpError');
      ErrorHandler.determineAuthError(signUpError, scaffoldKey);
    }
  }

  Future signOutUser(
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    try {
      await _auth.signOut();
      deleteFromSharedPreferences();

      return Navigator.pushReplacementNamed(context, SignIn.id);
    } catch (signOutError) {
      return ErrorHandler.determineAuthError(signOutError, scaffoldKey);
    }
  }

  Future sendResetPasswordLink(
      String email, GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      ErrorHandler.determineAuthError(e, scaffoldKey);
    }
  }

  Future<bool> saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool('loginState', true);
  }

  Future<bool> deleteFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove('loginState');
  }

  static Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loginState = prefs.getBool('loginState') ?? false;
    return loginState;
  }

  Future changeEmail(String email, GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      await user.updateEmail(email);
    } catch (changeEmailError) {
      ErrorHandler.determineAuthError(changeEmailError, scaffoldKey);
    }
  }

  Future changePassword(String password, GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      await user.updatePassword(password);
    } catch (changePasswordError) {
      ErrorHandler.determineAuthError(changePasswordError, scaffoldKey);
    }
  }

  Future deleteAccount(
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      await user.delete();
    } catch (changePasswordError) {
      ErrorHandler.determineAuthError(changePasswordError, scaffoldKey);
    }
  }
} //class

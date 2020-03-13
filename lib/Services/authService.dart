import 'package:expensetracker/Utilities/authErrorHandler.dart';
import 'package:expensetracker/models/user.dart';
import 'package:expensetracker/screens/authenticate/sign_in_up.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthService{

  final FirebaseAuth _auth =  FirebaseAuth.instance;
  

  //creating a custom user object from a FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

   Stream<User> get getUser {
    return  _auth.onAuthStateChanged
        .map(_userFromFireBaseUser);
  }

  Future signInUser(String email, String password, GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {

    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;

      saveToSharedPreferences();

      Navigator.pushReplacementNamed(context,Home.id);

      return _userFromFireBaseUser(firebaseUser);

    } catch (signUpError) {
      AuthErrorHandler.determineAuthError(signUpError, scaffoldKey);
    }

  }

  Future signUpUser(String email, String password,  GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {

    try{

      AuthResult authResult =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;

      saveToSharedPreferences();

      Navigator.pushReplacementNamed(context,Home.id);

      return _userFromFireBaseUser(firebaseUser);

    }catch(signUpError){
      AuthErrorHandler.determineAuthError(signUpError, scaffoldKey);
    }
  }

  Future signOutUser (GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async{

    try{

       await _auth.signOut();
       deleteFromSharedPreferences();

       return Navigator.pushReplacementNamed(context, SignIn.id);

    }catch(signOutError){
      return  AuthErrorHandler.determineAuthError(signOutError, scaffoldKey);
    }
  }

  Future sendResetPasswordLink(String email, GlobalKey<ScaffoldState> scaffoldKey) async{
    try{
       return _auth.sendPasswordResetEmail(email: email) ;

    }catch(e){
      AuthErrorHandler.determineAuthError(e, scaffoldKey);
    }
  }

  Future<bool> saveToSharedPreferences() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return  prefs.setBool('loginState',true);
  }

  Future<bool>  deleteFromSharedPreferences() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return  prefs.remove('loginState');
  }

  static Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loginState = prefs.getBool('loginState')?? false;
    return loginState;
  }


}//class


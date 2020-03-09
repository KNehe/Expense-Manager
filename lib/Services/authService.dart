import 'package:expensetracker/Utilities/authErrorHandler.dart';
import 'package:expensetracker/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AuthService{

  final FirebaseAuth _auth =  FirebaseAuth.instance;
  

  //creating a custom user object from a FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid) : null;

  }

  //auth changes using stream
  Stream<User> get getUser {
    return  _auth.onAuthStateChanged
        .map(_userFromFireBaseUser);
  }

  Future signInUser(String email, String password, GlobalKey<ScaffoldState> scaffoldKey) async {

    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFireBaseUser(firebaseUser);

    } catch (signUpError) {
      AuthErrorHandler.determineAuthError(signUpError, scaffoldKey);
    }

  }

  Future signUpUser(String email, String password,  GlobalKey<ScaffoldState> scaffoldKey) async {

    try{

      AuthResult authResult =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFireBaseUser(firebaseUser);

    }catch(signUpError){
      AuthErrorHandler.determineAuthError(signUpError, scaffoldKey);
    }
  }

  Future signOutUser () async{

    try{
      return await _auth.signOut();

    }catch(e){
      print("Sign Out Error: " + e.toString());
      return null;
    }
  }

  Future sendResetPasswordLink(String email, GlobalKey<ScaffoldState> scaffoldKey) async{
    try{
       return _auth.sendPasswordResetEmail(email: email) ;

    }catch(e){
      AuthErrorHandler.determineAuthError(e, scaffoldKey);
    }
  }

}//class


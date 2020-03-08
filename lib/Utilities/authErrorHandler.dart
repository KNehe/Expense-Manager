import 'package:expensetracker/Components/customSnackbar.dart';
import 'package:flutter/material.dart';

class AuthErrorHandler{

  static  determineAuthError(dynamic error, GlobalKey<ScaffoldState> scaffoldKey){

    switch(error.code){
      case 'ERROR_EMAIL_ALREADY_IN_USE':  CustomSnackBar.showSnackBar(scaffoldKey, 'Email already registered');
      break;
      case 'ERROR_WEAK_PASSWORD':  CustomSnackBar.showSnackBar(scaffoldKey, 'Weak Password');
      break;
      case 'ERROR_INVALID_EMAIL':   CustomSnackBar.showSnackBar(scaffoldKey, 'Invalid email');
      break;
      case 'ERROR_USER_NOT_FOUND':   CustomSnackBar.showSnackBar(scaffoldKey, 'Email not recognised');
      break;
      case 'ERROR_USER_DISABLED':  CustomSnackBar.showSnackBar(scaffoldKey, 'Your account has been disabled');
      break;
      case 'ERROR_WRONG_PASSWORD': CustomSnackBar.showSnackBar(scaffoldKey, 'Wrong password');
      break;
      default : CustomSnackBar.showSnackBar(scaffoldKey, 'An error occurred try again!! ');

    }

  }
}
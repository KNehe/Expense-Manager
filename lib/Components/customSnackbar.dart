import 'package:expensetracker/Constants/Colors.dart';
import 'package:flutter/material.dart';


class CustomSnackBar {

  CustomSnackBar._();

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message){

    scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text(message),
            backgroundColor: snackBarColor,
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: (){ scaffoldKey.currentState.hideCurrentSnackBar(); },
          ),
        ),
    );

  }

}


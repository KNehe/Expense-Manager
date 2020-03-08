import 'package:expensetracker/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CustomProgressDialog {

  ProgressDialog progressDialog;

  BuildContext context;

  CustomProgressDialog({this.context});



  void showDialog(String message) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);

    progressDialog.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: clipColor,
      progressWidget: CircularProgressIndicator(),
      elevation: 5.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(color: Colors.white),
      messageTextStyle: TextStyle(color: Colors.white),
    );

    progressDialog.show();
  }


  void hideDialog() {

    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    Future.delayed(Duration(seconds: 1)).then((onValue){
      if(progressDialog.isShowing())
        progressDialog.hide();
    });


  }


}
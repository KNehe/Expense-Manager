import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {

  static String id = 'forgot_password'; // This class's identifier // used when routing

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Container( child: Text('forgot password'),);
  }
}

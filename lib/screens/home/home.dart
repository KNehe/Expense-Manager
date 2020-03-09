import 'package:expensetracker/Services/authService.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  static String id = 'home';

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () { _authService.signOutUser();},
                child: Icon(
                  Icons.close,
                  size: 26.0,
                ),
              )
          )
        ],
      ),
      body: Container(
        child: Text('home'),
    ),
    );
  }
}

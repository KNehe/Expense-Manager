import 'package:expensetracker/Services/authService.dart';
import 'package:expensetracker/models/user.dart';
import 'package:expensetracker/screens/authenticate/authenticate.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Wrapper extends StatefulWidget {

  static String id = 'wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

//   AuthService authService = AuthService();
//   var user;

bool isLoggedIn;

  @override
  void initState() {
//    user = authService.getUser;
    FirebaseAuth.instance.currentUser().then( (user) => user != null?
     setState((){
       isLoggedIn = true;
     }):
    setState((){
      isLoggedIn = false;
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return isLoggedIn ? Home() : Authenticate();
  }


}






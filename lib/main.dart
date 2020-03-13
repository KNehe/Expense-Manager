import 'package:expensetracker/Services/authService.dart';
import 'package:expensetracker/models/user.dart';
import 'package:expensetracker/screens/authenticate/forgotPassword.dart';
import 'package:expensetracker/screens/authenticate/sign_in_up.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:expensetracker/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Constants/Colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
      
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:  clipColor
      ));
      //TODO splashscreen app logo

    return StreamProvider<User>.value(
      value: AuthService().getUser,
      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: THEME_COLOR,
            ),
            home: Wrapper(),
            routes: {
              Wrapper.id: (context)=> Wrapper(),
              ForgotPassword.id : (context) => ForgotPassword(),
              SignIn.id : (context) => SignIn(),
              Home.id: (context) => Home()
            },
          ),
    );


  }
}



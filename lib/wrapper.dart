import 'package:expensetracker/Services/authService.dart';
import 'package:expensetracker/screens/authenticate/authenticate.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {

  static String id = 'wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: AuthService.getLoginState(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Scaffold( body: Center( child: Text('Loading ...'),),);
          case ConnectionState.none:
          case ConnectionState.done:
            if(snapshot.hasData){
              bool loginState = snapshot.data;
              if(loginState){
                return Home();
              }else{
                return Authenticate();
              }
            }else{
              return Authenticate();
            }
        }
        return Authenticate();
      },

    );

  }

}

import 'dart:math';

import 'package:expensetracker/models/user.dart';
import 'package:expensetracker/screens/authenticate/authenticate.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  static String id = 'wrapper';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //Depending on login status of user return home or authenticate widget

    if(user == null){

      return  Authenticate();

    }else{

      return  Home();

    }
  }


}




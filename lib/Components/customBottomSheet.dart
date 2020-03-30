import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/Utilities/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomBottomSheet{

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String task;
  CustomBottomSheet({@required this.scaffoldKey,@required this.task});

  String _email;
  GlobalKey<FormState> _securityForm1;

  void show(){

    if(task =='ChangeEmail'){

      scaffoldKey.currentState.showBottomSheet((context)=> Container(

        color:  scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height/3 ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            SizedBox(height: 15.0,),

            Center(
              child: CustomText(
                text: 'CHANGE EMAIL',
                textColor: buttonColor,
                fontFamily: 'open sans',
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),

            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left:10,right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Email',hintText: 'e.g john@gmail.com', icon: Icon(Icons.email)),
                    validator: (value) =>  Validation.emailValidation(value),
                    keyboardType: TextInputType.emailAddress,
                    onSaved:(value) => _email = value  ,
                  ),
                ),

                SizedBox(height: 10.0,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 45, right: 15),
                  child: ButtonTheme(
                    height: 10.0,
                    child: RaisedButton(
                      child: Text('Save changes', style: TextStyle(color: buttonTextColor),),
                      color: buttonColor,
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),),
                      onPressed: () {
                        print(_email);
                      },
                    ),
                  ),
                ),
              ],
            )

          ],

        ),

      ));

    }



    if(task =='ChangePassword'){

      scaffoldKey.currentState.showBottomSheet((context)=> Container(

        child: Text('Password'),

      ));

    }

  }


}
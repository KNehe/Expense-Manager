import 'package:expensetracker/Components/customProgressDialog.dart';
import 'package:expensetracker/Components/customSnackbar.dart';
import 'package:expensetracker/Services/authService.dart';
import 'package:expensetracker/Utilities/errorHandler.dart';
import 'package:expensetracker/Utilities/validations.dart';
import 'package:expensetracker/screens/authenticate/sign_in_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/Components/customClipPath.dart';



class ForgotPassword extends StatefulWidget {

  static String id = 'forgot_password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

CustomProgressDialog progressDialog;

class _ForgotPasswordState extends State<ForgotPassword> {

  AuthService _authService = AuthService();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _email;


  @override
  Widget build(BuildContext context) {


    progressDialog = CustomProgressDialog(context: context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              CustomClipPath(),

              SizedBox(height: MediaQuery.of(context).size.height/10,),

              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email',hintText: 'e.g john@gmail.com', icon: Icon(Icons.email)),
                        validator: (value) =>  Validation.emailValidation(value),
                        keyboardType: TextInputType.emailAddress,
                        onSaved:(value) => _email = value  ,
                      ),

                      SizedBox(height: 10.0,),

                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: RaisedButton(
                          child: Text('Reset password', style: TextStyle(color: buttonTextColor),),
                          color: buttonColor,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              resetPassword();

                              progressDialog.showDialog('Processing ...');
                                                          }
                          },
                        ),
                      ),

                      FlatButton(
                        child: Text('Back ?',
                          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),),
                        onPressed: () {
                          Navigator.pushNamed(context, SignIn.id);
                        },
                      )

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }//build

  void resetPassword() async{
    try{
      await _authService.sendResetPasswordLink(_email, _scaffoldKey);
      progressDialog.hideDialog();
      CustomSnackBar.showSnackBar(_scaffoldKey, 'Check the email you provided to reset');
      _formKey.currentState.reset();

    }catch(error){
      progressDialog.hideDialog();
      ErrorHandler.determineResetError(error, _scaffoldKey);
    }
  }
}

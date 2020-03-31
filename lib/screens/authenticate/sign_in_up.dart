import 'package:expensetracker/Components/customClipPath.dart';
import 'package:expensetracker/Components/customProgressDialog.dart';
import 'package:expensetracker/Services/authService.dart';
import 'package:expensetracker/screens/authenticate/forgotPassword.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/Utilities/validations.dart';



class SignIn extends StatefulWidget {
  static String id = 'auth';
  @override
  _SignInState createState() => _SignInState();
}

enum FormShown{
  signInForm,
  signUpForm
}

CustomProgressDialog progressDialog;


class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _authService = AuthService();

  String _email='email', _password ='passowrd';

  //show signing form by default
  FormShown _formShown = FormShown.signInForm;


  @override
  Widget build(BuildContext context) {


    progressDialog = CustomProgressDialog(context: context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: scaffoldBackgroundColor,
     body: SafeArea(

        child: Container(

          child: ListView(

            children: <Widget>[

              CustomClipPath(),

              SizedBox(height: 50),

              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  textFormFields() + formButtons()
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }//build()


 //email and password input fields
  List<Widget> textFormFields(){
    return[

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

      Container(
        margin: EdgeInsets.only(left: 10,right: 15),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Password',icon: Icon(Icons.lock)),
          validator: (value) {

              if(_formShown == FormShown.signUpForm){
                return Validation.passwordValidation(value,true);
              }
              return Validation.passwordValidation(value,false);

          },
          obscureText: true,
          onSaved:(value) => _password = value  ,
        ),
      ),

        SizedBox( height: 20),
    ];
  }//textFormFields()

  //signIn and signUp buttons
  List<Widget> formButtons(){

    if(_formShown == FormShown.signInForm) {
      return [

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 45, right: 15),
            child: RaisedButton(
              child: Text('SignIn', style: TextStyle(color: buttonTextColor),),
              color: buttonColor,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),),
              onPressed: () async {

                if (saveAndValidate()) {
                   progressDialog.showDialog('Signing you in ...');
                   await _authService.signInUser(_email, _password, _scaffoldKey,context);
                   progressDialog.hideDialog();
                   Navigator.pushReplacementNamed(context,Home.id);
                }
              },
            ),
          ),

        SizedBox( height: 5.0),

        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text('Forgot password?', style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(0, 0, 0, 0.7)),),
                onPressed: () {
                  Navigator.pushNamed(context, ForgotPassword.id);

                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),

              FlatButton(
                child: Text('Create an account',
                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),),
                onPressed: () {
                  setState(() {
                     resetForm();
                    _formShown = FormShown.signUpForm;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),

            ],
          ) ,
        ),


      ];
    }


    if(_formShown == FormShown.signUpForm) {
      return [

        Container(
          width: MediaQuery.of(context).size.width,
          margin:  EdgeInsets.only(left: 45, right: 15),
          child: RaisedButton(
              child: Text('SignUp', style: TextStyle(color: buttonTextColor),),
              color: buttonColor,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),),
              onPressed: () async {
                if (saveAndValidate()) {

                  progressDialog.showDialog('Signing you up ...');
                  await _authService.signUpUser(_email, _password,_scaffoldKey,context);
                  progressDialog.hideDialog();
                  Navigator.pushReplacementNamed(context,Home.id);

                }
              },
            ),
        ),

        SizedBox( height: MediaQuery.of(context).size.width/12,),

          Container(
            child: Center(
              child: FlatButton(
                child: Text('Have an account ?',
                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),),
                onPressed: () {
                  setState(() {
                     resetForm();
                    _formShown = FormShown.signInForm;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          )

      ];
    }
    return null;
  }//formButtons()

  bool saveAndValidate(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      return true;
    }
    return false;
  }//saveAndValidate()

  void resetForm(){
    _formKey.currentState.reset();
  }

}//class



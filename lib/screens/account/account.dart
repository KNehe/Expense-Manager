import 'package:expensetracker/Components/customButton.dart';
import 'package:expensetracker/Components/customCard.dart';
import 'package:expensetracker/Components/customProgressDialog.dart';
import 'package:expensetracker/Components/customSnackbar.dart';
import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/Constants/Decorations.dart';
import 'package:expensetracker/Services/authService.dart';
import 'package:expensetracker/Utilities/validations.dart';
import 'package:expensetracker/screens/authenticate/sign_in_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Account extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  Account({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

CustomProgressDialog progressDialog;

class _AccountState extends State<Account> {
  String _email;
  String _password;
  FirebaseUser _currentUser;

  final _changeEmailForm = GlobalKey<FormState>();
  final _changePasswordForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this._currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = CustomProgressDialog(context: context);

    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //display email, sign out button
              CustomCard(
                  cardHeight: MediaQuery.of(context).size.height / 4,
                  cardPadding: EdgeInsets.all(15.0),
                  cardColor: cardColor,
                  gradientColor1: clipColor,
                  gradientColor2: cardColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 40.0,
                              color: clipColor,
                            ),
                            backgroundColor: scaffoldBackgroundColor,
                            minRadius: 30.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          CustomText(
                            text:
                                '${_currentUser != null ? _currentUser.email : ''}',
                            textColor: Colors.white,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ButtonTheme(
                            height: 10,
                            child: RaisedButton(
                              child: Text(
                                'SIGN OUT',
                                style: TextStyle(
                                    color: buttonTextColor,
                                    fontWeight: FontWeight.w900),
                              ),
                              color: cardColor,
                              padding: EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () async {
                                progressDialog.showDialog('Signing out...');

                                await AuthService()
                                    .signOutUser(widget.scaffoldKey, context);

                                progressDialog.hideDialog();
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),

              SizedBox(
                height: 20.0,
              ),

              //Change email, password,delete account
              CustomCard(
                cardHeight: MediaQuery.of(context).size.height / 2 - 20,
                cardPadding: EdgeInsets.all(15.0),
                cardColor: cardColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: Column(
                  children: <Widget>[
                    //Title
                    CustomText(
                      text: 'CHANGE CREDENTIALS',
                      textColor: Colors.white,
                      fontFamily: 'open sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    //Change email
                    Form(
                      key: _changeEmailForm,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: textInputDecorationT1.copyWith(
                                  hintText: 'Change email',
                                  icon: Icon(
                                    Icons.email,
                                    color: clipColor,
                                  )),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) =>
                                  Validation.emailValidation(value),
                              onSaved: (value) => _email = value,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0),
                                child: CustomButton(
                                  buttonText: 'Save',
                                  buttonColor: buttonColor,
                                  buttonPadding: EdgeInsets.all(5.0),
                                  buttonBorderRadius: 5.0,
                                  buttonTextColor: buttonTextColor,
                                  onPressed: () async {
                                    if (_changeEmailForm.currentState
                                        .validate()) {
                                      _changeEmailForm.currentState.save();

                                      progressDialog
                                          .showDialog('Saving changes...');

                                      await AuthService().changeEmail(
                                          _email, widget.scaffoldKey, context);

                                      progressDialog.hideDialog();
                                      _changeEmailForm.currentState.reset();
                                      CustomSnackBar.showSnackBar(
                                          widget.scaffoldKey,
                                          'Operation Successfull !');
                                    }
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    //Change password
                    Form(
                      key: _changePasswordForm,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: textInputDecorationT1.copyWith(
                                  hintText: 'Change password',
                                  icon: Icon(
                                    Icons.lock_outline,
                                    color: clipColor,
                                  )),
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  Validation.passwordValidation(value, true),
                              onSaved: (value) => _password = value,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0),
                                child: CustomButton(
                                  buttonText: 'Save',
                                  buttonColor: buttonColor,
                                  buttonPadding: EdgeInsets.all(5.0),
                                  buttonBorderRadius: 5.0,
                                  buttonTextColor: buttonTextColor,
                                  onPressed: () async {
                                    if (_changePasswordForm.currentState
                                        .validate()) {
                                      _changePasswordForm.currentState.save();

                                      progressDialog
                                          .showDialog('Saving changes...');

                                      await AuthService().changePassword(
                                          _password,
                                          widget.scaffoldKey,
                                          context);

                                      progressDialog.hideDialog();
                                      _changePasswordForm.currentState.reset();
                                      CustomSnackBar.showSnackBar(
                                          widget.scaffoldKey,
                                          'Operation Successfull !');
                                    }
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    //Delete Account
                    ButtonTheme(
                      height: 10.0,
                      child: RaisedButton(
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                              color: buttonTextColor,
                              fontWeight: FontWeight.w900),
                        ),
                        color: buttonColor,
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () async {
                          progressDialog.showDialog('Deleting account...');

                          await AuthService()
                              .deleteAccount(widget.scaffoldKey, context);

                          progressDialog.hideDialog();

                          CustomSnackBar.showSnackBar(
                              widget.scaffoldKey, 'Account deleted');
                          Navigator.pushReplacementNamed(context, SignIn.id);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

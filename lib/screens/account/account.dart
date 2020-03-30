import 'package:expensetracker/Components/customBottomSheet.dart';
import 'package:expensetracker/Components/customCard.dart';
import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Account extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  Account({@required this.scaffoldKey});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              CustomCard(
                cardHeight: MediaQuery.of(context).size.height/4,
                cardPadding: EdgeInsets.all(15.0),
                cardColor: cardColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[

                        CircleAvatar(
                          child: Icon( Icons.person, size: 40.0,color: clipColor,),
                          backgroundColor: scaffoldBackgroundColor,
                          minRadius: 30.0,
                        ),

                        SizedBox(width: 10.0,),

                        CustomText(
                          text: 'kamolunehemiah@gmail.com',
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
                            child: Text('SIGN OUT', style: TextStyle(color: buttonTextColor,fontWeight: FontWeight.w900),),
                            color: cardColor,
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),),
                            onPressed: (){
                              print('signOut');
                            },
                          ),
                        )

                      ],
                    )
                  ],
                )
              ),

              SizedBox(height: 10.0,),

              CustomCard(
                cardHeight: MediaQuery.of(context).size.height/3 - 20,
                cardPadding: EdgeInsets.all(15.0),
                cardColor: cardColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: Column(
                  children: <Widget>[
                   
                    //Title
                    CustomText(
                      text: 'SECURITY',
                      textColor: Colors.white,
                      fontFamily: 'open sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),

                    SizedBox(height: 20.0,),
                    
                    //Changed Email
                    InkWell(
                      child: Row(
                        children: <Widget>[
                          CustomText(
                            text: 'Change Email',
                            textColor: Colors.white,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                          SizedBox(width: 5.0,),
                          Icon(Icons.edit,color: Colors.white,size: 16.0,)
                        ],
                      ),
                      onTap: (){ CustomBottomSheet(scaffoldKey: widget.scaffoldKey,task: "ChangeEmail").show(); },
                    ),

                    SizedBox(height: 10.0,),

                    //Change Password
                    InkWell(
                      child: Row(
                        children: <Widget>[
                          CustomText(
                            text: 'Change Password',
                            textColor: Colors.white,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                          SizedBox(width: 5.0,),
                          Icon(Icons.edit,color: Colors.white,size: 16.0,)
                        ],
                      ),
                        onTap: (){ CustomBottomSheet(scaffoldKey: widget.scaffoldKey,task: "ChangePassword").show(); },
                    ),

                    SizedBox(height: 10.0,),
                    
                    //Delete Account
                    Row(
                      children: <Widget>[
                        ButtonTheme(
                          height: 10.0,
                          child: RaisedButton(
                            child: Text('Delete Account', style: TextStyle(color: buttonTextColor,fontWeight: FontWeight.w900),),
                            color: buttonColor,
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),),
                            onPressed: (){
                              print('delete account');
                            },
                          ),
                        ),
                      ],
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

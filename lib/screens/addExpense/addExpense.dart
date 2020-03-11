import 'package:expensetracker/Components/customCard.dart';
import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              CustomCard(
                cardHeight: MediaQuery.of(context).size.width/3,
                cardPadding: EdgeInsets.all(20.0),
                cardColor: cardColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      CustomText(
                        text: 'TODAY\'s INCOME',
                        textColor: Colors.white,
                        fontFamily: 'open sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 25.0,
                      ),

                      SizedBox(height: 10.0,),

                      CustomText(
                        text: '/= 10,000',
                        textColor: scaffoldBackgroundColor,
                        fontFamily: 'open sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.0,),

              CustomCard(
                cardPadding: EdgeInsets.all(20.0),
                cardHeight: MediaQuery.of(context).size.width - 100,
                cardColor: clipColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: Column(
                  children: <Widget>[
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(),
                          RaisedButton()
                        ],
                      ),
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
      ],
    );
  }
}





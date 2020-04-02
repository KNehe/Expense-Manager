import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/Components/customButton.dart';
import 'package:expensetracker/Components/customCard.dart';
import 'package:expensetracker/Components/customProgressDialog.dart';
import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/Constants/Decorations.dart';
import 'package:expensetracker/Constants/titleRow.dart';
import 'package:expensetracker/Services/databaseService.dart';
import 'package:expensetracker/Utilities/validations.dart';
import 'package:expensetracker/models/income.dart';
import 'package:expensetracker/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  AddExpense({ @required this.scaffoldKey});

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

CustomProgressDialog progressDialog;

class _AddExpenseState extends State<AddExpense> {

  int _income, _itemBoughtPrice;
  String _itemName;


  final _formIncome = GlobalKey<FormState>();

  final _formExpense = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    progressDialog = CustomProgressDialog(context: context);

    final user = Provider.of<User>(context);


    return  ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              //Container with today's income
              CustomCard(
                cardHeight: MediaQuery.of(context).size.height/6,
                cardPadding: EdgeInsets.all(20.0),
                cardColor: cardColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child:Column(
                  children: <Widget>[
                    CustomText(
                          text: 'TODAY\'s INCOME',
                          textColor: Colors.white,
                          fontFamily: 'open sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0,
                          ),

                    SizedBox(height: 5.0,),

                    StreamBuilder<Income>(
                      stream: DatabaseService(userId: user.uid).getIncome,
                      builder: (context,snapshot){
                        var newIncome = 0;
                        if(snapshot.hasData){
                          newIncome = snapshot.data.income;
                        }
                          return CustomText(
                            text: 'UGX $newIncome',
                            textColor: scaffoldBackgroundColor,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          );

                      },
                    )
                  ],
                ),

              ),

              SizedBox(height: 10.0,),

              //Container with addIncome
              CustomCard(
                cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                cardHeight: MediaQuery.of(context).size.height /6,
                cardColor: clipColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formIncome,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: textInputDecorationT1
                                  .copyWith(hintText: 'Income',icon: Icon(Icons.adjust,color: clipColor,)),
                              keyboardType: TextInputType.number,
                              validator: (value) => Validation.incomeValidation(value),
                              onSaved: (value) => _income = int.parse(value),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0),
                                child: CustomButton(
                                  buttonText:'Add Income',
                                  buttonColor: buttonColor,
                                  buttonPadding: EdgeInsets.all(5.0),
                                  buttonBorderRadius: 5.0,
                                  buttonTextColor: buttonTextColor,
                                  onPressed: () async{
                                    if(_formIncome.currentState.validate()){
                                      _formIncome.currentState.save();

                                      progressDialog.showDialog('Adding Income');

                                      await  DatabaseService(userId: user.uid).addIncome(_income,widget.scaffoldKey);

                                      progressDialog.hideDialog();
                                      _formIncome.currentState.reset();
                                    }

                                  },
                                ),
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10.0,),

              //Container with save expense
              CustomCard(
                cardHeight: 280,
                cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                cardColor: cardColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formExpense,
                      child: Column(
                        children: <Widget>[

                          SizedBox(height: 10.0,),

                          CustomText(
                                text: 'REGISTER AN EXPENSE',
                                textColor: Colors.white,
                                fontFamily: 'open sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                              ),


                          SizedBox(height: 20.0,),

                          TextFormField(
                                  decoration: textInputDecorationT1
                                      .copyWith(hintText: 'Item\'s name',icon: Icon(Icons.input,color: clipColor,)),
                                  keyboardType: TextInputType.text,
                                  validator: (value) => Validation.itemNameValidation(value),
                                  onSaved: (value) => _itemName = value ,
                              ),

                          SizedBox(height: 5.0,),

                          TextFormField(
                            decoration: textInputDecorationT1
                                .copyWith(hintText: 'Item\'s price',icon: Icon(Icons.input,color: clipColor,)),
                            keyboardType: TextInputType.number,
                            validator: (value) => Validation.itemPriceValidation(value),
                            onSaved: (value) => _itemBoughtPrice = int.parse(value),
                          ),

                          SizedBox(height: 5.0,),

                          Container(
                            margin: EdgeInsets.only(left: 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                CustomButton(
                                  buttonText:'Save Expense',
                                  buttonColor: buttonColorThicker,
                                  buttonPadding: EdgeInsets.all(10.0),
                                  buttonBorderRadius: 5.0,
                                  buttonTextColor: buttonTextColor,
                                  onPressed: () async{

                                    if(_formExpense.currentState.validate()){
                                      _formExpense.currentState.save();
                                        progressDialog.showDialog('Saving Expense');
                                        await  DatabaseService(userId: user.uid).saveExpense(_itemName, _itemBoughtPrice, widget.scaffoldKey);                                        progressDialog.hideDialog();
                                      _formExpense.currentState.reset();
                                    }

                                  },
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10.0,),

              //card with recent expenses
              CustomCard(
                cardHeight: 280.0,
                cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                cardColor: cardColor,
                gradientColor1: clipColor,
                gradientColor2: cardColor,
                child: StreamBuilder(
                  stream:  DatabaseService(userId: user.uid).getRecentExpenses,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){

                    if(!snapshot.hasData|| snapshot.data.documents.isEmpty || snapshot.data.documents.length == 0){
                     return Column(
                       children: <Widget>[
                         CustomText(
                           text: 'RECENT EXPENSES TODAY',
                           textColor: Colors.white,
                           fontFamily: 'open sans',
                           fontWeight: FontWeight.w700,
                           fontSize: 20.0,
                         ),

                         SizedBox(height:15.0),

                         CustomText(
                            text: 'You haven\'t recorded any expenses today!',
                            textColor: Colors.white,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                          ),
                       ],
                     );

                    }

                    List<TableRow> expenses = [];

                    expenses.add(titleRow);

                    if(snapshot.hasData){

                      for(var doc in snapshot.data.documents){

                        final itemName = doc['Item'];
                        final itemPrice = doc['Price'];
                        final timeBought = doc['TimeRecorded'];

                        final expense = TableRow(
                          children: [
                             Container(
                                padding: EdgeInsets.all(5.0),
                                child: CustomText(
                                        text: '$itemName',
                                        textColor: Colors.white,
                                        fontFamily: 'open sans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                 ),
                              ) ,


                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: 'UGX $itemPrice',
                                  textColor: Colors.white,
                                  fontFamily: 'open sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                ),
                              ) ,


                             Container(
                                 padding: EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: '$timeBought',
                                  textColor: Colors.white,
                                  fontFamily: 'open sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                ),
                              ) ,

                          ]
                        );

                        expenses.add(expense);
                      }
                    }


                    return

                    Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        //title
                     CustomText(
                     text: 'RECENT EXPENSES TODAY',
                       textColor: Colors.white,
                       fontFamily: 'open sans',
                       fontWeight: FontWeight.w700,
                       fontSize: 20.0,
                     ),
                        SizedBox(height: 15.0,),

                        Expanded(
                          child: Table(
                            border: TableBorder.all(color: Colors.white),
                            defaultVerticalAlignment: TableCellVerticalAlignment.top,
                            children: expenses,
                          ),
                        )
                      ],
                    );

                  },
                ) ,
              ),

          SizedBox(height: 10.0,)


            ],
          ),
        ),
      ],
    );
  }
}







import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/Components/customCard.dart';
import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Components/datePicker.dart';
import 'package:expensetracker/Components/todayGraph.dart';
import 'package:expensetracker/Components/weekDaySummary.dart';
import 'package:expensetracker/Components/weekGraph.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/Services/databaseService.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/models/income.dart';
import 'package:expensetracker/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';


class Statistics extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  Statistics({this.scaffoldKey});


  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  Future _getThisWeekExpenditure;

  var _itemPrice;
  var _item;

  var _selectedDate;

  var _itemPrice2;
  var _item2;


  _onTodayGraphSelected(charts.SelectionModel model){

    final selectedDatum = model.selectedDatum;

    var itemPrice;
    var item;

    if (selectedDatum.isNotEmpty) {
      itemPrice = selectedDatum.first.datum.price;
      item = selectedDatum.first.datum.item;
    }

    setState(() {
      _itemPrice = itemPrice;
      _item = item;
    });
  }

  _onWeekGraphSelected(charts.SelectionModel model){

    final selectedDatum = model.selectedDatum;

    var expenditure;
    var weekDayDate;
    var weekDay;

    if(selectedDatum.isNotEmpty){
      expenditure = selectedDatum.first.datum.expenditure;
      weekDayDate = selectedDatum.first.datum.weekDayDate;
      weekDay = selectedDatum.first.datum.weekDay;
    }

    final user = Provider.of<User>(context,listen: false);

    if(expenditure != 0 && expenditure != null){
     WeekDaySummary(user: user,scaffoldKey: widget.scaffoldKey,
                    weekDay:  weekDay, expenditure: expenditure,
                    weekDayDate: weekDayDate).showWeekDaySummary();
    }

  }

  _onResultGraphSelected(charts.SelectionModel model){

    final selectedDatum = model.selectedDatum;

    var itemPrice;
    var item;

    if (selectedDatum.isNotEmpty) {
      itemPrice = selectedDatum.first.datum.price;
      item = selectedDatum.first.datum.item;
    }

    setState(() {
      _itemPrice2 = itemPrice;
      _item2 = item;
    });
  }


  @override
  void initState() {
    super.initState();

    final user = Provider.of<User>(context,listen: false);

    _getThisWeekExpenditure = DatabaseService(userId:  user.uid).getThisWeekExpenditure(widget.scaffoldKey);
  }



  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return ListView(
      children: <Widget>[

        //today's statistics
        StreamBuilder(
              stream: DatabaseService(userId: user.uid).getTodayStats,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                final List<Expense> todayExpenses =[];
                int totalExpenses = 0;

                if(snapshot .hasData ){
                  int count = 0;
                    for(var doc in snapshot.data.documents) {
                      final itemName = doc['Item'];
                      final itemPrice = doc['Price'];

                      totalExpenses += itemPrice;

                      count +=1;

                     final expense = Expense(
                          item: '$itemName',
                          price: itemPrice,
                          barColor: count %2 ==0? charts.ColorUtil.fromDartColor(Colors.orange[900]) :charts.ColorUtil.fromDartColor(Colors.purple)
                      );

                     todayExpenses.add(expense);

                    }
//loop
                }

                if(!snapshot.hasData || snapshot.data.documents.isEmpty || snapshot.data.documents.length == 0){
                  return Container(
                    margin: EdgeInsets.only(left: 5.0,right: 5.0,top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        SizedBox(height: 10.0,),

                        CustomCard(
                        cardHeight: 300.0,
                        cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        cardColor: cardColor,
                        gradientColor1: clipColor,
                        gradientColor2: cardColor,
                        child: Column(
                          children: <Widget>[

                            CustomText(
                              text: 'TODAY\'S STATISICS',
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
                        )
                    )
                      ],
                    ),
                  );
                }
                
                return  Container(
                  margin: EdgeInsets.only(left: 5.0,right: 5.0,top: 10.0),
                  child: CustomCard(
                      cardHeight: 300.0,
                      cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      cardColor: clipColor,
                      gradientColor1: clipColor,
                      gradientColor2: clipColor,
                      child: Column(
                        children: <Widget>[
                          //Title
                          CustomText(
                            text: 'TODAY\'S STATISICS',
                            textColor: Colors.white,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),

                          SizedBox(height: 15.0,),
                          //Show Income and Expenditure
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: StreamBuilder<Income>(
                                  stream: DatabaseService(userId: user.uid).getIncome,
                                  builder: (context, snapshot) {
                                    var income =0;
                                    if(snapshot.hasData){
                                      income = snapshot.data.income;
                                    }
                                    return CustomText(
                                      text: 'Income: $income',
                                      textColor: Colors.white,
                                      fontFamily: 'open sans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                    );
                                  }
                                ),
                              ),

                              Expanded(
                                child: CustomText(
                                  text: 'Expenditure: $totalExpenses',
                                  textColor: Colors.white,
                                  fontFamily: 'open sans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 15.0,),

                          //Graph
                          Expanded(child: TodayGraph(data: todayExpenses,onTodayGraphSelected: _onTodayGraphSelected,)),

                          //Item selected's price
                          _itemPrice != null ? CustomText(
                          text: '$_item : $_itemPrice',
                          textColor: Colors.white,
                          fontFamily: 'open sans',
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          ): Visibility(child: Text(''), visible: false,),

                          SizedBox(height:10.0),
                        ],)
                  ),
                );

              },
            ),

        SizedBox(height:10.0 ,),

        //this week's statistics
        FutureBuilder(
          future: _getThisWeekExpenditure ,
          builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Container(
                    margin: EdgeInsets.only(left: 5.0,right: 5.0),
                    child: CustomCard(
                        cardHeight: 300.0,
                        cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        cardColor: cardColor,
                        gradientColor1: clipColor,
                        gradientColor2: cardColor,
                        child: Column(
                          children: <Widget>[
                            CustomText(
                              text: 'THIS WEEK\'S EXPENDITURE',
                              textColor: Colors.white,
                              fontFamily: 'open sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                            SizedBox(height: 5.0,),
                            Center(
                              child:  CircularProgressIndicator(backgroundColor: scaffoldBackgroundColor,)
                            ),
                          ],
                        )
                    )
                );
              case ConnectionState.none:
              case ConnectionState.done:

              if(!snapshot.hasData ){
                return Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: CustomCard(
                      cardHeight: 200.0,
                      cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      cardColor: cardColor,
                      gradientColor1: clipColor,
                      gradientColor2: cardColor,
                      child: Column(
                        children: <Widget>[
                          CustomText(
                            text: 'THIS WEEK\'S EXPENDITURE',
                            textColor: Colors.white,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),

                          SizedBox(height: 5.0,),

                          CustomText(
                            text: 'No expenses recorded this week',
                            textColor: Colors.white,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          )

                        ],
                      )),
                );
              }

              if(snapshot.hasData){
                  var data = snapshot.data;
                  return Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: CustomCard(
                        cardHeight: 300.0,
                        cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        cardColor: cardColor,
                        gradientColor1: clipColor,
                        gradientColor2: cardColor,
                        child: Column(
                          children: <Widget>[
                            //Graph Title
                            CustomText(
                              text: 'THIS WEEK\'S EXPENDITURE',
                              textColor: Colors.white,
                              fontFamily: 'open sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                            Expanded(child: WeekGraph(data: data,onWeekGraphSelected: _onWeekGraphSelected,)),
                          ],
                        )),
                  );
                }

            }
            return  Center( child: Text('No Content'),);
          },
        ),

        SizedBox(height:10.0 ,),

        //Search expense and income of a particular date
        Container(
          margin: EdgeInsets.only(left: 5.0, right: 5.0),
          child: CustomCard(
              cardHeight: _selectedDate !=null ? 350.0 : 200,
              cardPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              cardColor: cardColor,
              gradientColor1: clipColor,
              gradientColor2: cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Section Title
                  CustomText(
                    text: 'SEARCH FOR ANY RECORDS',
                    textColor: Colors.white,
                    fontFamily: 'open sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  SizedBox(height: 10.0,),
                  //Button to show datetime picker
                  ButtonTheme(
                    minWidth: 250.0,
                    child: RaisedButton(
                      child: Text('Select A Date',style: TextStyle(color: buttonTextColor),),
                      color: buttonColor,
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),),
                      onPressed: ()  async {
                        var selectedDate = await DatePicker().showDateTimePicker(context: context);
                        setState(() {
                          _selectedDate = selectedDate;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 5.0,),

                  _itemPrice2 != null ? Row(
                    children: <Widget>[
                       StreamBuilder<Income>(
                          stream: DatabaseService(userId: user.uid).searchIncomeByDate(_selectedDate),
                          builder: (context, snapshot) {
                            var income =0;
                            if(snapshot.hasData){
                              income = snapshot.data.income;
                            }
                            return CustomText(
                              text: ' $Income: $income',
                              textColor: Colors.white,
                              fontFamily: 'open sans',
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            );
                          }
                      ),

                      SizedBox(width: 5.0,),

                      //Item selected's price
                      CustomText(
                        text: '$_item2 : $_itemPrice2',
                        textColor: Colors.white,
                        fontFamily: 'open sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      )
                    ],
                  ): Visibility(child: Text(''), visible: false,),

                  //Show the results in graph
                  _selectedDate != null ?
                       StreamBuilder(
                         stream: DatabaseService(userId: user.uid).searchExpenseByDateTime(scaffoldKey: widget.scaffoldKey, dateTime: _selectedDate),
                         builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                           List<Expense> expenses = [];

                           if(snapshot.hasData && snapshot.data.documents.isNotEmpty){

                             int count = 0;

                             for(var doc in snapshot.data.documents){
                               var price = doc.data['Price'];
                               var item = doc.data['Item'];

                               count += 1;

                               var expense = Expense(item: item,price: price,
                                             barColor: count %2 ==0? charts.ColorUtil.fromDartColor(Colors.orange[900])
                                                       :charts.ColorUtil.fromDartColor(Colors.purple)
                                              );

                               expenses.add(expense);
                             }
                             return Expanded(child: TodayGraph(data: expenses,onTodayGraphSelected: _onResultGraphSelected,));

                           }else{

                             return  CustomText(
                               text: 'No records for selected date',
                               textColor: Colors.white,
                               fontFamily: 'open sans',
                               fontWeight: FontWeight.w700,
                               fontSize: 15.0,
                             );
                           }


                         },
                       )
                      :Visibility(child: Text(''),visible: false,)

                ],
              )
          ),
        ),

        SizedBox(height:10.0 ,),








      ],
    );


  }
}

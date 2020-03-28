import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/Components/customCard.dart';
import 'package:expensetracker/Components/customText.dart';
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


  @override
  void initState() {
    super.initState();

    final user = Provider.of<User>(context,listen: false);

    _getThisWeekExpenditure = DatabaseService(userId:  user.uid).getThisWeekExpenditure();
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
                  return Column(
                    children: <Widget>[

                      SizedBox(height: 10.0,),

                      CustomCard(
                      cardHeight: 280.0,
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






      ],
    );


  }
}

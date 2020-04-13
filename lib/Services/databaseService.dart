import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:date_util/date_util.dart';
import 'package:expensetracker/Components/customSnackbar.dart';
import 'package:expensetracker/Utilities/errorHandler.dart';
import 'package:expensetracker/Utilities/dateUtils.dart';
import 'package:expensetracker/models/income.dart';
import 'package:expensetracker/models/monthExpense.dart';
import 'package:expensetracker/models/range.dart';
import 'package:expensetracker/models/weekDataSummary.dart';
import 'package:expensetracker/models/weekExpense.dart';
import 'package:expensetracker/models/weekMonthData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class DatabaseService {

  final String userId;

  DatabaseService({this.userId});


  final CollectionReference reference = Firestore.instance.collection('users');


  var todayDate= formatDate(DateTime.now(),[dd, '-', mm, '-', yyyy]);
  var todayTime = formatDate(DateTime.now(), [HH, ':', nn, ':', ss]);

  Income mapSnapshotToIncome(DocumentSnapshot snapshot) {
    return snapshot != null ? Income(income: snapshot.data['Income']) : null;
  }

  //Today's income
  Stream<Income> get getIncome {
    return reference.document(userId).collection(todayDate)
        .document('Income')
        .snapshots()
        .map(mapSnapshotToIncome);
  }


  //add income to db
  Future addIncome(int income, GlobalKey<ScaffoldState> scaffoldKey) async {

    int oldIncome = 0;

    try {
      await reference.document(userId).collection(todayDate).document('Income')
          .get().then((value) {
        if (value.data == null) {
          oldIncome = 0;
        } else {
          oldIncome = value.data['Income'];
        }
      })
          .catchError((error) {
            print('addIcome1 $error');
         ErrorHandler.determineError(error, scaffoldKey);
      });

      int newIncome = oldIncome + income;

      await reference.document(userId).collection(todayDate).document('Income')
          .setData({
        'Income': newIncome
      });

      CustomSnackBar.showSnackBar(scaffoldKey, 'Income added');

    } catch (error) {
      print('addIcome2 $error');
      ErrorHandler.determineError(error, scaffoldKey);
    }
  }

  //add expense to db
  Future saveExpense(String itemName, int itemPrice,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      await reference.document(userId).collection(todayDate).document(
          'Expenses').collection('Expenses')
          .add({
        'Item': itemName,
        'Price': itemPrice,
        'TimeRecorded': todayTime
      });

      CustomSnackBar.showSnackBar(scaffoldKey, 'Expense saved ');
    } catch (error) {
      CustomSnackBar.showSnackBar(scaffoldKey, 'An eror occured! Try again');
    }
  }


  Stream<QuerySnapshot> get getRecentExpenses {
    return reference.document(userId).collection(todayDate).document('Expenses')
        .collection('Expenses').limit(5).orderBy('TimeRecorded')
        .snapshots();
  }


  Stream<QuerySnapshot> get getTodayStats {
    return reference.document(userId).collection(todayDate).document('Expenses')
        .collection('Expenses').orderBy('TimeRecorded')
        .snapshots();
  }


  getThisWeekExpenditure(GlobalKey<ScaffoldState> scaffoldKey)  async{

    List<WeekExpense> weekExpenses =  new List<WeekExpense>();

    var weekDayDate;
    int weekDay;

    for(int i = 0; i < DateTime.now().weekday ; i ++ ){

      var dateToday = DateTime.now().subtract(Duration(days: i));
       weekDay = dateToday.weekday;
       weekDayDate = formatDate(dateToday,[dd, '-', mm, '-', yyyy]);


      int totalExpenditure = 0;

      //get the expenses for each day and sum them
      await reference.document(userId).collection(weekDayDate).document('Expenses')
          .collection('Expenses').getDocuments().then((QuerySnapshot snapshot){

        for(var doc in snapshot.documents){
          if(doc.data.containsKey('Price'))
          {
            var price = doc.data['Price'];
            totalExpenditure = totalExpenditure + price;
          }else{
            totalExpenditure = totalExpenditure + 0;
          }

        }

        var weekExpense = WeekExpense(
            weekDay: DateUtils().getWeekDayName(weekDay),
            expenditure: totalExpenditure,
            barColor: i %2 ==0? charts.ColorUtil.fromDartColor(Colors.orange[900])
                :charts.ColorUtil.fromDartColor(Colors.purple),
            weekDayDate: weekDayDate
        );

        weekExpenses.add( weekExpense);



      }).catchError((error){
        ErrorHandler.determineError(error, scaffoldKey);
      });


    }

    return weekExpenses;
  }


  Stream<QuerySnapshot> searchByWeekDayDate(String weekDayDate){

    return reference.document(userId).collection(weekDayDate).document('Expenses')
        .collection('Expenses').orderBy('TimeRecorded')
        .snapshots();


  }

  //when date is a String
  Stream<Income> getIncomeByDate(String date) {
    return reference.document(userId).collection(date)
        .document('Income')
        .snapshots()
        .map(mapSnapshotToIncome);
  }

  Stream<QuerySnapshot> searchExpenseByDateTime({@required GlobalKey<ScaffoldState> scaffoldKey, @required DateTime dateTime}) {

    var searchValue = formatDate(dateTime,[dd, '-', mm, '-', yyyy]);

    return reference.document(userId).collection(searchValue).document('Expenses')
        .collection('Expenses').snapshots();
  }

  //when date is  DateTime
  Stream<Income> searchIncomeByDate(DateTime dateTime) {

    var searchValue = formatDate(dateTime,[dd, '-', mm, '-', yyyy]);

    return reference.document(userId).collection(searchValue)
        .document('Income')
        .snapshots()
        .map(mapSnapshotToIncome);
  }

  getThisMonthExpenditure(DateTime dateTime) async {


    var dateUtility = DateUtil();

    var no0fDaysInMonth = dateUtility.daysInMonth( dateTime.month, dateTime.year);

    List<MonthExpense> monthExpenses = [];

    var collection;

    int totalExpenditure= 0;

    
    for( int i = 1 ; i <= no0fDaysInMonth ; i ++){

     
        collection =  DateUtils().formatIntDayValue(i) + '-'  + DateUtils().formatIntMonthValue( dateTime.month ) + '-'  + dateTime.year.toString();

        await reference.document(userId).collection(collection).document('Expenses')
            .collection('Expenses').getDocuments().then((QuerySnapshot snapshot) {


                if(i <= 7){
                  totalExpenditure = getExpenditureFromSnapshot(snapshot,totalExpenditure);
                }

                if( i == 7){

                  var monthExpense = MonthExpense( weekName: 'Week 1',
                                                  weekExpenditure: totalExpenditure,
                                                  range:  Range(firstDay: 1,lastDay: 7),
                                                  barColor: charts.ColorUtil.fromDartColor(Colors.orange[900])
                                                  );

                  monthExpenses.add(monthExpense);

                  totalExpenditure = 0;
                }

                if( i > 7 && i  <= 14){
                  totalExpenditure = getExpenditureFromSnapshot(snapshot,totalExpenditure);

                }

                if( i == 14){

                  var monthExpense = MonthExpense( weekName: 'Week 2',
                      weekExpenditure: totalExpenditure,
                      range:  Range(firstDay: 8,lastDay: 14),
                      barColor: charts.ColorUtil.fromDartColor(Colors.purple)
                  );

                  monthExpenses.add(monthExpense);

                  totalExpenditure = 0;

                }

                if( i > 14 && i  <= 21 ){
                  totalExpenditure = getExpenditureFromSnapshot(snapshot,totalExpenditure);

                }

                if( i == 21){

                  var monthExpense = MonthExpense( weekName: 'Week 3',
                      weekExpenditure: totalExpenditure,
                      range:  Range(firstDay: 15,lastDay: 21),
                      barColor: charts.ColorUtil.fromDartColor(Colors.orange[600])
                  );

                  monthExpenses.add(monthExpense);

                  totalExpenditure = 0;
                }

                if( i > 21 && i  <= 28 ){
                  totalExpenditure = getExpenditureFromSnapshot(snapshot,totalExpenditure);

                }

                if( i == 28){

                  var monthExpense = MonthExpense( weekName: 'Week 4',
                      weekExpenditure: totalExpenditure,
                      range:  Range(firstDay: 22,lastDay: 28),
                      barColor: charts.ColorUtil.fromDartColor(Colors.purple[400])
                  );

                  monthExpenses.add(monthExpense);

                  totalExpenditure = 0;
                }

                if( i > 28 && i  <= 29 && no0fDaysInMonth == 29 ){

                  totalExpenditure = getExpenditureFromSnapshot(snapshot,totalExpenditure);

                  var monthExpense = MonthExpense( weekName: '29th',
                      weekExpenditure: totalExpenditure,
                      range:  Range(firstDay: 29,lastDay: 29),
                      barColor: charts.ColorUtil.fromDartColor(Colors.orange)
                  );

                  monthExpenses.add(monthExpense);

                  totalExpenditure = 0;

                }

                if( i > 28 && i  <= 30 && no0fDaysInMonth == 30 ){

                  totalExpenditure = getExpenditureFromSnapshot(snapshot,totalExpenditure);

                }

                if(i == 30 && no0fDaysInMonth == 30 ){

                  var monthExpense = MonthExpense( weekName: ' 29th - 30th',
                      weekExpenditure: totalExpenditure,
                      range:  Range(firstDay: 29,lastDay: 30),
                      barColor: charts.ColorUtil.fromDartColor(Colors.purple[900])
                  );

                  monthExpenses.add(monthExpense);

                  totalExpenditure = 0;
                }

                if( i > 28 && i  <= 31 && no0fDaysInMonth == 31 ){
                  totalExpenditure = getExpenditureFromSnapshot(snapshot,totalExpenditure);

                }

                if(i == 31 ){

                  var monthExpense = MonthExpense( weekName: ' 29th - 31st',
                      weekExpenditure: totalExpenditure,
                      range:  Range(firstDay: 29,lastDay: 31),
                      barColor: charts.ColorUtil.fromDartColor(Colors.purple[900])
                  );

                  monthExpenses.add(monthExpense);


                  totalExpenditure = 0;
                }

        });

    }

    return monthExpenses;

  }

  //called in the above method
  //use to reduce boiler plate code
  int getExpenditureFromSnapshot(QuerySnapshot snapshot ,totalExpenditure){

    for(var doc in snapshot.documents){

      if(doc.data.containsKey('Price'))
      {
        var price = doc.data['Price'];
        totalExpenditure = totalExpenditure + price;

      }else{

        totalExpenditure = totalExpenditure + 0;

      }

    }
    return totalExpenditure;

  }

  //get week data using range
  getWeekDataFromRange({ WeekMonthData weekMonthData }) async {

    Range range = DateUtils().getRangeFromWeekName(weekMonthData.weekName);

    var collection;

    List<WeekDataSummary> weekSummary = [];


    for (int start = range.firstDay; start <= range.lastDay; start ++) {

      collection = DateUtils().formatIntDayValue(start) + '-' +
                   DateUtils().formatIntMonthValue(weekMonthData.dateTime.month) + '-'
                  + weekMonthData.dateTime.year.toString();

      await reference.document(weekMonthData.user.uid).collection(collection)
          .document('Expenses')
          .collection('Expenses').getDocuments()
          .then((QuerySnapshot snapshot) {

        for(var doc in snapshot.documents){

          if(doc.data.containsKey('Price'))
          {

            var price = doc.data['Price'];
            var item = doc.data['Item'];
            var timeRecorded = doc.data['TimeRecorded'];
            var dateRecorded = collection;

            var weekDataSummary = WeekDataSummary(price: price, item:  item, timeRecorded:  timeRecorded, dateRecorded:  dateRecorded );

            weekSummary.add(weekDataSummary);
          }

        }


      });
    }

    return weekSummary;
  }

  //get total income using range
  getWeekTotalIncome( { WeekMonthData weekMonthData}) async {

    Range range = DateUtils().getRangeFromWeekName(weekMonthData.weekName);

    var collection;

    int totalIncome = 0;

    for (int start = range.firstDay; start <= range.lastDay; start ++) {

      collection = DateUtils().formatIntDayValue(start) + '-' +
                   DateUtils().formatIntMonthValue(weekMonthData.dateTime.month) + '-'
                   + weekMonthData.dateTime.year.toString();

      await reference.document(weekMonthData.user.uid).collection(collection).document('Income')
          .get().then((value) {

        if (value.data == null) {
          totalIncome = totalIncome + 0;

        } else {
          totalIncome = totalIncome + value.data['Income'];
        }

      });
    }

    return totalIncome;
  }






}//class
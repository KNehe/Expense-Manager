import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:expensetracker/Components/customSnackbar.dart';
import 'package:expensetracker/Utilities/dateUtils.dart';
import 'package:expensetracker/models/income.dart';
import 'package:expensetracker/models/weekExpense.dart';
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
    int oldIncome;
    try {
      await reference.document(userId).collection(todayDate).document('Income')
          .get().then((value) {
        if (value.data == null) {
          oldIncome = 0;
        } else {
          oldIncome = value.data['Income'];
        }
      })
          .catchError((e) {
        CustomSnackBar.showSnackBar(scaffoldKey, e.toString());
      });

      int newIncome = oldIncome + income;

      await reference.document(userId).collection(todayDate).document('Income')
          .setData({
        'Income': newIncome
      });


      CustomSnackBar.showSnackBar(scaffoldKey, 'Income added');
    } catch (e) {
      CustomSnackBar.showSnackBar(scaffoldKey, e.toString());
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
    } catch (e) {
      CustomSnackBar.showSnackBar(scaffoldKey, e.toString());
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


  getThisWeekExpenditure()  async{

    List<WeekExpense> weekExpenses =  new List<WeekExpense>();

    var day;
    var weekDayDate;
    int weekDay;

    for(int i = 0; i < DateTime.now().weekday ; i ++ ){

      weekDay = DateTime.now().weekday;
      day = (DateTime.now().day - i ).toString();
      weekDayDate =  day + "-0" + DateTime.now().month.toString() + "-"  + DateTime.now().year.toString();

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
             weekDay: DateUtils().getWeekDayName(weekDay - i),
             expenditure: totalExpenditure,
             barColor: i %2 ==0? charts.ColorUtil.fromDartColor(Colors.orange[900])
                 :charts.ColorUtil.fromDartColor(Colors.purple),
             weekDayDate: weekDayDate
         );

         weekExpenses.add( weekExpense);

         if( i == DateTime.now().weekday) {
           totalExpenditure = 0;
         }


       }).catchError((error){
         print('WeekExpenditure $error');
       });


    }

    return weekExpenses;
  }


  Stream<QuerySnapshot> searchByWeekDayDate(String weekDayDate){
    print('Weekdaydate : $weekDayDate');
    return reference.document(userId).collection(weekDayDate).document('Expenses')
        .collection('Expenses').orderBy('TimeRecorded')
        .snapshots();


  }


  searchByDateTime(DateTime dateTime){

    var dateSearch = dateTime.day.toString() + "-" + dateTime.month.toString() + "-"+ dateTime.year.toString();

    return reference.document(userId).collection(dateSearch).document('Expenses')
        .collection('Expenses').orderBy('TimeRecorded')
        .snapshots();

  }



}//class
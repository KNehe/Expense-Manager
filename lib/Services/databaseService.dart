import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:expensetracker/Components/customSnackbar.dart';
import 'package:expensetracker/models/income.dart';
import 'package:flutter/material.dart';


class DatabaseService {

  final String userId;

  DatabaseService({this.userId});


  final CollectionReference reference = Firestore.instance.collection('users');


  var todayDate= formatDate(DateTime.now(),[dd, '-', mm, '-', yyyy]);
  var todayTime = formatDate(DateTime.now(), [HH, ':', nn, ':', ss]);

  Income mapSnapshotToIncome(DocumentSnapshot snapshot) {
    return snapshot != null ? Income(income: snapshot.data['Income']) : null;
  }

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

}
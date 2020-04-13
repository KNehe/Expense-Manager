import 'package:expensetracker/models/user.dart';
import 'package:flutter/foundation.dart';

class WeekMonthData{

  String weekName;
  DateTime dateTime;
  int expenditure;
  User user;

  WeekMonthData({ @required this.weekName, @required this.dateTime, @required this.user , @required this.expenditure});

}
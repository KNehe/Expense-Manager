import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class WeekExpense{

  final String weekDay;
  final int expenditure;
  final charts.Color barColor;
  String weekDayDate;

  WeekExpense({
    @required this.weekDay,
    @required this.expenditure,
    @required this.barColor,
    @required this.weekDayDate
});
}
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';


class TodayGraph extends StatelessWidget {

  final List<Expense> data;

  TodayGraph({@required this.data});

  @override
  Widget build(BuildContext context) {

    List<charts.Series<Expense,String>> series = [

      charts.Series(
        id: "TodayExpenses",
        data: data,
        domainFn: (Expense expense,_)=> expense.item,
        measureFn: (Expense expense, _) => expense.price,
        colorFn: (Expense expense,_) => expense.barColor,
        labelAccessorFn: (Expense expense, _) => 'Expenses'
      )
    ];


    return charts.BarChart(series, animate: true);
  }
}

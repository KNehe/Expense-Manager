import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class TodayGraph extends StatefulWidget {

  final List<Expense> data;
  final Function onTodayGraphSelected;

  TodayGraph({@required this.data, @required this.onTodayGraphSelected});

  @override
  _TodayGraphState createState() => _TodayGraphState();
}

class _TodayGraphState extends State<TodayGraph> {

  @override
  Widget build(BuildContext context) {

    List<charts.Series<Expense,String>> series = [

      charts.Series(
          id: "TodayExpenses",
          data: widget.data,
          domainFn: (Expense expense,_)=> expense.item,
          measureFn: (Expense expense, _) => expense.price,
          colorFn: (Expense expense,_) => expense.barColor,
          labelAccessorFn: (Expense expense, _) => 'Expenses'
      )
    ];


    return charts.BarChart(
          series,
          animate: true,
          selectionModels: [
            new charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: widget.onTodayGraphSelected
            )
          ],
    );
  }
}





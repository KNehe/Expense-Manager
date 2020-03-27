import 'package:expensetracker/models/weekExpense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class WeekGraph extends StatefulWidget {


  final List<WeekExpense> data;
  final Function onWeekGraphSelected;

  WeekGraph({@required this.data, @required this.onWeekGraphSelected});

  @override
  _WeekGraphState createState() => _WeekGraphState();
}

class _WeekGraphState extends State<WeekGraph> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<WeekExpense,String>> series  = [

      charts.Series(
          id: "WeekExpenses",
          data: widget.data,
          domainFn: (WeekExpense weekExpense,_)=> weekExpense.weekDay,
          measureFn: (WeekExpense weekExpense,_) => weekExpense.expenditure,
          colorFn: (WeekExpense weekExpense,_) => weekExpense.barColor
      )
    ];

    return charts.BarChart(
            series,
            animate: true,
      selectionModels: [
        new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: widget.onWeekGraphSelected
        )
      ],);
  }
}


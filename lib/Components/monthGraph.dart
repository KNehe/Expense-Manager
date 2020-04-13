import 'package:expensetracker/models/monthExpense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class MonthGraph extends StatefulWidget {


  final List<MonthExpense> data;
  final Function onMonthGraphSelected;

  MonthGraph({@required this.data, @required this.onMonthGraphSelected});

  @override
  _MonthGraphState createState() => _MonthGraphState();
}

class _MonthGraphState extends State<MonthGraph> {

  @override
  Widget build(BuildContext context) {

    List<charts.Series<MonthExpense,String>> series  = [

      charts.Series(
          id: "MonthExpenses",
          data: widget.data,
          domainFn: (MonthExpense monthExpense,_)=> monthExpense.weekName,
          measureFn: (MonthExpense monthExpense,_) => monthExpense.weekExpenditure,
          colorFn: (MonthExpense monthExpense,_) => monthExpense.barColor
      )
    ];

    return charts.BarChart(
            series,
            animate: true,
      selectionModels: [
        new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: widget.onMonthGraphSelected
        )
      ],);
  }
}


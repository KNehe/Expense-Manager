import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expensetracker/models/range.dart';
import 'package:flutter/foundation.dart';

class MonthExpense{

  final String weekName;
  final int weekExpenditure;
  // e.g (1,7 ) from 1st to 7th which must be a period of 7 days
  //if start is 29th then period is (29-29)
  //if start is 30th then period is (29-30)
  //if start is 31st then period is (29-31st)
  final Range range;
  final charts.Color barColor;

  MonthExpense({ @required this.weekName, @required this.weekExpenditure, @required this.range, @required this.barColor });

}



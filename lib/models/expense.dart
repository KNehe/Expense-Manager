import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

//Used to draw graph
class Expense{

  final String item;
  final int price;
  final charts.Color barColor;


  Expense({
    @required this.item,
    @required this.price,
    @required this.barColor});

}


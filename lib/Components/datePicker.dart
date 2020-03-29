import 'package:expensetracker/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DatePicker{

   showDateTimePicker({@required BuildContext context}) async{

    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData( primarySwatch: Colors.green) ,
          child: child,
        );
      },
    );

    return await selectedDate;


  }

}
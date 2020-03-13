import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:flutter/material.dart';

final titleRow = TableRow(
    children: [

       Container(
          padding: EdgeInsets.all(5.0),
          child: CustomText(
            text: 'Name',
            textColor: buttonColorThicker,
            fontFamily: 'open sans',
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ) ,


       Container(
          padding: EdgeInsets.all(5.0),
          child: CustomText(
            text: 'Price',
            textColor: buttonColorThicker,
            fontFamily: 'open sans',
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
      ),

       Container(
          padding: EdgeInsets.all(5.0),
          child: CustomText(
            text: 'Time',
            textColor: buttonColorThicker,
            fontFamily: 'open sans',
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        )

    ]
);
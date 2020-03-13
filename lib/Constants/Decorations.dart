import 'package:flutter/material.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'Colors.dart';

var textInputDecorationT1 = InputDecoration(
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textFormFieldFillColor,width: 2.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: clipColor,width: 2.0)
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
                          );
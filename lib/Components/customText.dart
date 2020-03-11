import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double fontSize;
  final String fontFamily;
  final Color textColor;
  final FontWeight fontWeight;

  CustomText({this.text, this.fontSize,this.fontFamily, this.fontWeight, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(this.text,
      style: TextStyle(
          fontSize: this.fontSize,
          fontFamily: 'open sans',
          color: this.textColor,
          fontWeight: this.fontWeight
      ),
    );
  }
}
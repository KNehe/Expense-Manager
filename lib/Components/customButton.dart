import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final double buttonBorderRadius;
  final EdgeInsetsGeometry buttonPadding;
  final Function onPressed;

  CustomButton({this.buttonText, this.buttonColor,
    this.buttonTextColor, this.buttonBorderRadius, this.buttonPadding, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('${this.buttonText}', style: TextStyle(color: this.buttonTextColor),),
      color: this.buttonColor,
      padding: this.buttonPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.buttonBorderRadius),),
      onPressed: this.onPressed
    );
  }
}
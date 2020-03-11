import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final Color cardColor;
  final Widget child;
  final Color  gradientColor1;
  final Color  gradientColor2;
  final double cardHeight ;
  final EdgeInsetsGeometry cardPadding;

  CustomCard({this.cardColor, this.cardHeight, this.child, this.gradientColor1,this.gradientColor2, this.cardPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.cardPadding,
      height: this.cardHeight,
      child: this.child,
      decoration: BoxDecoration(
          color: cardColor,
          gradient: LinearGradient(
              colors: [this.gradientColor1, this.gradientColor2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
    );
  }
}
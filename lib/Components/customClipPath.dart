import 'package:flutter/material.dart';
import 'package:expensetracker/Utilities/clipperClass.dart';
import 'package:expensetracker/Constants/Colors.dart';

class CustomClipPath extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipPath(
              clipper: ClippingClass(),
              child: Container(
                    height: 250,
                    decoration: BoxDecoration(
              color: clipColor
                     ),
              ),
          );
  }
}

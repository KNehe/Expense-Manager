import 'package:flutter/material.dart';
import 'package:expensetracker/Utilities/clipperClass.dart';
import 'package:expensetracker/Constants/Colors.dart';

class CustomClipPath extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipPath(
              clipper: ClippingClass(),
              child: Container(
                    height: MediaQuery.of(context).size.height/2.4,
                    decoration: BoxDecoration(
              color: clipColor
                     ),
              ),
          );
  }
}

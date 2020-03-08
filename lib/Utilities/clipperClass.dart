import 'package:flutter/material.dart';


class ClippingClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    var path = Path();

    path.lineTo(size.width, 0.0);

    path.lineTo(size.width, size.height);


    return path ;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}
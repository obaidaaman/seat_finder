import 'package:flutter/material.dart';

class CustomClipperTop extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    double height = size.height * 0.7;
    double width = size.width;
    path.moveTo(0, height);
    path.lineTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(width - 10, height);
    path.lineTo(width - 10, 10);
    path.lineTo(10, 10);
    path.lineTo(10, height);
    path.lineTo(0, height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class MyCustomCliperFromBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height * 0.3;
    double width = size.width;
    Path path = Path()
      ..moveTo(0, height)
      ..lineTo(0, size.height)

      ..lineTo(width, size.height)
      ..lineTo(width, height)

      ..lineTo(width - 10, height)
      ..lineTo(width - 10, size.height - 10)

      ..lineTo(10, size.height - 10)
      ..lineTo(10, height)

      ..lineTo(0, height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

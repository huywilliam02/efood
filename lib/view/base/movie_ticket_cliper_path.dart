import 'package:flutter/material.dart';

class MovieTicketClipperPath extends CustomClipper<Path> {
  @override

  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(-5, size.height);
    double x = -5;
    double y = size.height;
    double yControlPoint = size.height * .40;
    double increment = size.width / 40;

    while (x < size.width) {
      path.quadraticBezierTo(
        x + increment / 2, yControlPoint, x + increment, y,
      );
      x += increment;
    }

    path.lineTo(size.width, 0.0);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}

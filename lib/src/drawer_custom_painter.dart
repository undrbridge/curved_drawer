import 'package:flutter/material.dart';

class DrawerCustomPainter extends CustomPainter {
  double loc;
  double s;
  Color color;
  TextDirection textDirection;
  double width;
  bool isEndDrawer;

  DrawerCustomPainter(double startingLoc, int itemsLength, this.color,
      this.textDirection, this.width, this.isEndDrawer) {
    //Determine % for each item
    final span = 1.0 / itemsLength;
    //standard deviation from location
    s = width / 100 * .1;
    double l = startingLoc + (span - s) / 2;
    loc = l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final leftPath = Path()
      ..moveTo(width, 0)
      ..lineTo(width, (loc - 0.02) * size.height)
      ..cubicTo(
        width * 0.90,
        (loc + s * 0.2) * size.height,
        width * 0.50,
        loc * size.height,
        width * 0.500,
        (loc + s * 0.50) * size.height,
      )
      ..cubicTo(
        width * 0.50,
        (loc + s) * size.height,
        width,
        (loc + s - s * 0.10) * size.height,
        width,
        (loc + s + 0.02) * size.height,
      )
      ..lineTo(width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
    final rightPath = Path()
      ..moveTo(size.width - width, 0)
      ..lineTo(size.width - width, (loc - 0.02) * size.height)
      ..cubicTo(
        size.width - width * 0.90,
        (loc + s * 0.2) * size.height,
        size.width - (width * 0.50),
        loc * size.height,
        size.width - (width * 0.500),
        (loc + s * 0.50) * size.height,
      )
      ..cubicTo(
        size.width - (width * 0.50),
        (loc + s) * size.height,
        size.width - width,
        (loc + s - s * 0.10) * size.height,
        size.width - width,
        (loc + s + 0.02) * size.height,
      )
      ..lineTo(size.width - width, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    final path = isEndDrawer ? rightPath : leftPath;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

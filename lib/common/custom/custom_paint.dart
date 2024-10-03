import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  DashedBorderPainter({
    this.color = Colors.grey,
    this.strokeWidth = 2.0,
    this.dashLength = 4.0,
    this.gapLength = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    const double startY = 0;
    final double endX = size.width;
    final double endY = size.height;

    while (startX < endX) {
      canvas.drawLine(Offset(startX, startY), Offset(startX + dashLength, startY), paint);
      startX += dashLength + gapLength;
    }

    double startY2 = 0;
    while (startY2 < endY) {
      canvas.drawLine(Offset(startX, startY2), Offset(startX, startY2 + dashLength), paint);
      startY2 += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

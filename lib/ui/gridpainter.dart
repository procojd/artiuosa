import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double imageWidth;
  final double imageHeight;
  final double scale;

  GridPainter({required this.imageWidth, required this.imageHeight,required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 0.3/scale
      ..style = PaintingStyle.stroke;

    double step = 50.0;

    for (double i = 0; i < imageWidth; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, imageHeight), paint);
    }

    for (double i = 0; i < imageHeight; i += step) {
      canvas.drawLine(Offset(0, i), Offset(imageWidth, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
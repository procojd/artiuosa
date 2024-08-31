import 'dart:math';

import 'package:artiuosa/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class GridPainter extends CustomPainter {
  final double imageWidth;
  final double imageHeight;
  final bool scale;
  final double width;

  GridPainter({
    required this.imageWidth,
    required this.imageHeight,
    required this.scale,
    required this.width,
  });
  final controller ac = Get.put(controller());

  @override
  void paint(Canvas canvas, Size size) {
    print('this is the  size of painting ${imageWidth}');
    print(ac.paperWidth);
    final paint = Paint()
      ..color = ac.color.value.toColor() ?? Colors.white
      // ..strokeWidth = width
      ..strokeWidth = ac.strokeWidth.value
      ..style = PaintingStyle.stroke;

    double step = (imageWidth / ac.paperWidth.value) * ac.lineDistance.value;

    if (ac.squareGrid.value) {
      for (double i = 0; i < imageWidth; i += step) {
        canvas.drawLine(Offset(i, 0), Offset(i, imageHeight), paint);
        //  _drawVerticalText(canvas, Offset(i, 0), (i/step).toInt().toString());
      }

      for (double i = 0; i < imageHeight; i += step) {
        canvas.drawLine(Offset(0, i), Offset(imageWidth, i), paint);
        // _drawHorizontalText(canvas, Offset(0, i), (i/step).toInt().toString());
      }
    }
    double margin = imageHeight % step;
    // print(size.height);
    // print(size.width);
    // print(imageHeight);
    // print(imageWidth);
    // print(step);
    // print(margin);
    if (ac.diagonalLines.value) {
      for (double i = 0; i <= imageWidth + step; i += step) {
        for (double j = 0; j <= imageHeight; j += step) {
          if (i + step <= imageWidth && j + step <= imageHeight) {
            // Top-left to bottom-right diagonal
            canvas.drawLine(Offset(i, j), Offset(i + step, j + step), paint);

            // Top-right to bottom-left diagonal
            canvas.drawLine(Offset(i + step, j), Offset(i, j + step), paint);
          }
          //handling edge cases
          else {
//handling  "\" in right most column
            if (i > imageWidth - step && j <= imageHeight - step) {
              canvas.drawLine(Offset(i, j), Offset(i + step, j + step), paint);
            } else {
              canvas.drawLine(
                  Offset(i, j), Offset(i + margin, j + margin), paint);
            }
            // print(i);
            if (i < imageWidth - step) {
              canvas.drawLine(Offset(i + step, j),
                  Offset(i + step - margin, j + margin), paint);
            } else {
              if (i >= imageWidth - step && j <= imageHeight - step) {
                canvas.drawLine(
                    Offset(i + step, j), Offset(i, j + step), paint);
              } else {
                canvas.drawLine(Offset(i + step, j),
                    Offset(i + step - margin, j + margin), paint);
              }
            }
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

final controller ac = Get.put(controller());
void _drawHorizontalText(Canvas canvas, Offset offset, String text) {
  final textStyle = TextStyle(
    color: Color.fromARGB(136, 255, 255, 255),
    fontSize: 8,
  );
  final textSpan = TextSpan(
    text: text,
    style: textStyle,
  );
  final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right);
  textPainter.layout(
    minWidth: 0,
    maxWidth: double.infinity,
  );
  final labelOffset = offset.translate(4, 0); // Adjust as needed
  textPainter.paint(canvas, labelOffset);
}

void _drawVerticalText(Canvas canvas, Offset offset, String text) {
  final textStyle = TextStyle(
    color: Color.fromARGB(145, 255, 255, 255),
    fontSize: 8,
  );
  final textSpan = TextSpan(
    text: text,
    style: textStyle,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.rtl,
  );
  textPainter.layout(
    minWidth: 0,
    maxWidth: double.infinity,
  );

  canvas.save();
  canvas.translate(offset.dx, offset.dy);
  canvas.rotate(-pi / 2); // Rotate 90 degrees counter-clockwise
  textPainter.paint(canvas, Offset(-12, 0)); // Adjust as needed
  canvas.restore();
}

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
      }
    }
    double margin = imageHeight % step;
    double margin2 = imageWidth % step;
    // print(size.height);
    // print(size.width);
    // print(imageHeight);
    // print(imageWidth);
    // print(step);
    // print(margin);
    if (ac.diagonalLines.value) {
      for (double i = 0; i <= imageWidth ; i += step) {
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
              canvas.drawLine(Offset(i, j), Offset(i + margin2, j + margin2), paint);
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
                    Offset(i + margin2, j+step-margin2), Offset(i, j + step), paint);
              } else {
                canvas.drawLine(Offset(i + step, j),
                    Offset(i + step - margin, j + margin), paint);
              }
            }
          }
        }
      }
    }
if(ac.labels.value){    int j = 1;
    for (double i = 0; i < imageWidth; i += step) {
      //  _drawVerticalText(canvas, Offset(i, 0), (i/step).toInt().toString());
      
        _drawHorizontalText(canvas, Offset(i, 0), (j).toInt().toString(), step);

      j++;
    }
    int k = 1;

    for (double i = 0; i < imageHeight; i += step) {
      if (i != 0)
        _drawHorizontalText(canvas, Offset(0, i), (k).toInt().toString(), step);

      k++;
    }}
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

final controller ac = Get.put(controller());

void _drawHorizontalText(
    Canvas canvas, Offset offset, String text, double step) {
  final textStyle = TextStyle(
    color: const Color.fromARGB(255, 255, 255, 255), // Set text color to black
    fontSize: 8,
  );
  final textSpan = TextSpan(
    text: text,
    style: textStyle,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  textPainter.layout(
    minWidth: 0,
    maxWidth: double.infinity,
  );

  // Calculate the size and position for the grey line (rectangle)
  final lineThickness = 10.0; // Adjust the thickness of the line as needed
  // final lineHeight =
  //     ac.lineDistance.value.toDouble(); // Height of the rectangle (line)
  // final lineWidth = ac.lineDistance.value
  //     .toDouble(); // Width of the rectangle (line) with padding
  final lineOffset =
      offset.translate(0, textPainter.height / 2 - lineThickness / 2);

  // Draw the grey line (rectangle) behind the text
  final linePaint = Paint()
    ..color =
        Color.fromARGB(74, 28, 28, 28); // Set the line color to grey
  final rect = Rect.fromLTWH(lineOffset.dx, lineOffset.dy, step, step);
  canvas.drawRect(rect, linePaint);

  // Paint the text on top of the line
  textPainter.paint(
      canvas, offset.translate(2, 0)); // Adjust the offset if needed
}

// final controller ac = Get.put(controller());
// void _drawHorizontalText(Canvas canvas, Offset offset, String text) {
//   final textStyle = TextStyle(
//     color: Color.fromARGB(136, 255, 255, 255),
//     fontSize: 8,
//   );
//   final textSpan = TextSpan(
//     text: text,
//     style: textStyle,
//   );
//   final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.right);
//   textPainter.layout(
//     minWidth: 0,
//     maxWidth: double.infinity,
//   );
//   final labelOffset = offset.translate(4, 2); // Adjust as needed
//   textPainter.paint(canvas, labelOffset);
// }

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

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MandalaHomePage extends StatefulWidget {
  @override
  _MandalaHomePageState createState() => _MandalaHomePageState();
}

class _MandalaHomePageState extends State<MandalaHomePage> {
  int _symmetryLines = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complex Mandala Art'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CustomPaint(
                size: Size(300, 300),
                painter: MandalaPainter(_symmetryLines),
              ),
            ),
          ),
          Slider(
            min: 2,
            max: 20,
            divisions: 18,
            value: _symmetryLines.toDouble(),
            label: 'Symmetry Lines: $_symmetryLines',
            onChanged: (value) {
              setState(() {
                _symmetryLines = value.toInt();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Use the slider to change the number of symmetry lines.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class MandalaPainter extends CustomPainter {
  final int symmetryLines;
  MandalaPainter(this.symmetryLines);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final random = Random();

    // Draw multiple layers of mandala
    for (int layer = 0; layer < 6; layer++) {
      final shapeSize = radius * (layer + 1) / 6;
      final color = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );

      for (int i = 0; i < symmetryLines; i++) {
        final angle = (2 * pi / symmetryLines) * i;
        final shapeCenter = Offset(
          center.dx + shapeSize * cos(angle),
          center.dy + shapeSize * sin(angle),
        );
        drawKaleidoscopePattern(canvas, shapeCenter, shapeSize / 2, color, symmetryLines, random);
      }
    }
  }

  void drawKaleidoscopePattern(Canvas canvas, Offset center, double size, Color color, int symmetryLines, Random random) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < symmetryLines; i++) {
      final angle = (2 * pi / symmetryLines) * i;

      // Randomly choose a shape to draw
      switch (random.nextInt(3)) {
        case 0:
          drawCircle(canvas, center, size, paint, angle);
          break;
        case 1:
          drawRectangle(canvas, center, size, paint, angle);
          break;
        case 2:
          drawTriangle(canvas, center, size, paint, angle);
          break;
      }
    }
  }

  void drawCircle(Canvas canvas, Offset center, double radius, Paint paint, double angle) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.drawCircle(Offset.zero, radius, paint);
    canvas.restore();
  }

  void drawRectangle(Canvas canvas, Offset center, double size, Paint paint, double angle) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size, height: size), paint);
    canvas.restore();
  }

  void drawTriangle(Canvas canvas, Offset center, double size, Paint paint, double angle) {
    final path = Path()
      ..moveTo(center.dx, center.dy - size)
      ..lineTo(center.dx + size, center.dy + size)
      ..lineTo(center.dx - size, center.dy + size)
      ..close();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint for a new random pattern
  }
}
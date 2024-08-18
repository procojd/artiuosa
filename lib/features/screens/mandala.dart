import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MandalaHomePage extends StatefulWidget {
  @override
  _MandalaHomePageState createState() => _MandalaHomePageState();
}

class _MandalaHomePageState extends State<MandalaHomePage> {
int _numberOfCircles = 5;
int _numberOfSymmetryLines = 12;


File? _image;

Future<void> _pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  
  if (image != null) {
    setState(() {
      _image = File(image.path);
    });
  }
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Mandala Creator'),
    ),
    body: Column(
      children: [
        if (_image != null)
          Center(
            child: Stack(
              children: [
                Image.file(_image!),
                Align(
                  alignment: Alignment.center,
                  child: CustomPaint(
                    painter: MandalaPainter(
                    _numberOfCircles, _numberOfSymmetryLines,
                  ),
                  ),
                )
                
                
              ],
            ),
          ),
        Slider(
          value: _numberOfCircles.toDouble(),
          min: 1,
          max: 20,
          divisions: 19,
          label: 'Circles: $_numberOfCircles',
          onChanged: (double value) {
            setState(() {
              _numberOfCircles = value.toInt();
            });
          },
        ),
        Slider(
          value: _numberOfSymmetryLines.toDouble(),
          min: 2,
          max: 36,
          divisions: 34,
          label: 'Symmetry Lines: $_numberOfSymmetryLines',
          onChanged: (double value) {
            setState(() {
              _numberOfSymmetryLines = value.toInt();
            });
          },
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _pickImage,
      child: Icon(Icons.add_photo_alternate),
    ),
  );
}
}

class MandalaGrid extends StatelessWidget {
  final int numberOfCircles;
  final int numberOfSymmetryLines;

  MandalaGrid({required this.numberOfCircles, required this.numberOfSymmetryLines});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MandalaPainter(numberOfCircles, numberOfSymmetryLines),
    );
  }
}

class MandalaPainter extends CustomPainter {
  final int numberOfCircles;
  final int numberOfSymmetryLines;

  MandalaPainter(this.numberOfCircles, this.numberOfSymmetryLines);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the circles
    for (int i = 0; i < numberOfCircles; i++) {
      double radius = 400 / 2 * (i + 1) / numberOfCircles;
      canvas.drawCircle(Offset(400 / 2, 400 / 2), radius, Paint()..color = Color.fromARGB(255, 212, 255, 0).withOpacity(0.2));
    }

    // Draw the symmetry lines
    double angle = 2 * pi / numberOfSymmetryLines;
    for (int i = 0; i < numberOfSymmetryLines; i++) {
      double x = 400 / 2 + 400 / 2 * cos(i * angle);
      double y = 400 / 2 + 400 / 2 * sin(i * angle);
      canvas.drawLine(Offset(400 / 2, 400 / 2), Offset(x, y), Paint()..color = Color.fromARGB(255, 255, 230, 0).withOpacity(0.5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

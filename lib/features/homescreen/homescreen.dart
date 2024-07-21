import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/features/screens/colormix.dart';
import 'package:artiuosa/ui/colors.dart';
import 'package:artiuosa/ui/drawer.dart';
import 'package:artiuosa/ui/gridpainter.dart';
import 'package:artiuosa/ui/modalsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  File? _image;
  final String _imagePathKey = 'image_path';
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    _loadImagePath();
  }

  Future<void> _loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString(_imagePathKey);
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imagePathKey, pickedFile.path);
    }
  }

  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClipRRect(
        child: newMethod(context),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          _image != null
              ? IconButton(onPressed: _pickImage, icon: Icon(Icons.add))
              : SizedBox(),
          IconButton(
              onPressed: () {
               bot_sheet(context);
              },
              icon: Icon(Icons.more_vert_rounded)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.person_outline),
          )
        ],
        title: Text('Artiuosa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _image == null
                ? Text(
                    'No image selected.',
                    style: TextStyle(color: kblack, fontSize: 16),
                  )
                : Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return InteractiveViewer(
                        onInteractionUpdate: (details) {
                          if (details.scale != 10.0 && details.scale != 1) {
                            setState(() {
                              scale = details.scale;
                            });
                          }
                        },
                        minScale: 0.1,
                        maxScale: 10.0,
                        child: Center(
                          child: Stack(
                            children: [
                              FadeIn(child: Image.file(_image!)),
                              CustomPaint(
                                painter: GridPainter(
                                  imageWidth: constraints.maxWidth,
                                  imageHeight: constraints.maxHeight,
                                  scale: scale,
                                ),
                              ),
                              // CustomPaint(

                              //   painter: GridPainter(
                              //     imageWidth: constraints.maxWidth,
                              //     imageHeight: constraints.maxHeight,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
            _image == null ? SizedBox(height: 20) : SizedBox(),
            _image == null
                ? FilledButton(
                    onPressed: _pickImage,
                    child: Text('Browse Image'),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

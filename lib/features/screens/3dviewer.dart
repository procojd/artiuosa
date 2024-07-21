import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:artiuosa/ui/drawer.dart';
import 'package:artiuosa/ui/modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Viewer3d extends StatefulWidget {
  const Viewer3d({super.key});

  @override
  State<Viewer3d> createState() => _Viewer3dState();
}

class _Viewer3dState extends State<Viewer3d> {
  double _brightness = 1.0;
  bool _Controls = true;
  String? _modelUrl;
  String _selectedModel = 'skull.glb';
  bool _isLoading = true;

  final List<String> _models = ['loomis_head.glb', 'skull_downloadable.glb'];
  ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _fetchModelUrl(String model) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String downloadURL = await FirebaseStorage.instance
          .ref('3dmodel/$model')
          .getDownloadURL();
      setState(() {
        _modelUrl = downloadURL;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to get download URL: $e');
    }
  }

  Future<void> _saveScreenshot() async {
    final Uint8List? image = await _screenshotController.capture();
    bool dirDownloadExists = true;
    var directory;
    {
      directory = "/storage/emulated/0/Download/";

      dirDownloadExists = await Directory(directory).exists();
      if (dirDownloadExists) {
        directory = "/storage/emulated/0/Download/";
      } else {
        directory = "/storage/emulated/0/Downloads/";
      }
    }
    if (image != null) {
      final imagePath = '${directory}screenshot.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved to Downloads')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Artiuosa'),
      ),
      drawer: newMethod(context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: RadialGradient(
                      center: Alignment(0.0, 0.0), // near the top right
                      radius: 0.8,
                      colors: [
                        const Color.fromARGB(
                            255, 56, 56, 56), // color at the center
                        Colors.black, // color at the edges
                      ],
                      stops: [0.4, 1.0],
                    )),
                child: Screenshot(
                  controller: _screenshotController,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(_brightness),
                      BlendMode.modulate,
                    ),
                    child: ModelViewer(
                      src: 'assets/m/skull.glb', // Path to your converted .gl
                      alt: "A 3D model of an object",

                      cameraControls: _Controls,

                      exposure: _brightness,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Brightness'),
                    Expanded(
                      child: Slider(
                        value: _brightness,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (value) {
                          setState(() {
                            _brightness = value;
                          });
                        },
                      ),
                    ),
                    Text('Select Model: '),
                    DropdownButton<String>(
                      value: _selectedModel,
                      items: _models.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedModel = newValue;
                            _fetchModelUrl(_selectedModel);
                          });
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Camera Controls'),
                    Switch(
                      value: _Controls,
                      onChanged: (value) {
                        setState(() {
                          _Controls = value;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _saveScreenshot,
                  child: Text('Save Photo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

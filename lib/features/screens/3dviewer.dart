import 'dart:io';
import 'dart:typed_data';

import 'package:artiuosa/ui/drawer.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:screenshot/screenshot.dart';

class Viewer3d extends StatefulWidget {
  const Viewer3d({super.key});

  @override
  State<Viewer3d> createState() => _Viewer3dState();
}

class _Viewer3dState extends State<Viewer3d> {
  double _brightness = 1.0;
  bool _Controls = true;
  // String? _modelUrl;
  String _selectedModel = '1.glb';
  // bool _isLoading = true;
  bool _cameraControls = true;

  final List<String> _models = ['1.glb', '2.glb','3.glb',];
  ScreenshotController _screenshotController = ScreenshotController();
  void initState() {
    super.initState();
    // _fetchModelUrl(_selectedModel);
  }

  // Future<void> _fetchModelUrl(String model) async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     String downloadURL =
  //         await FirebaseStorage.instance.ref('3dmodel/$model').getDownloadURL();
  //     setState(() {
  //       _modelUrl = downloadURL;
  //       print(downloadURL);
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print('Failed to get download URL: $e');
  //   }
  // }

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
                child:  Screenshot(
                        controller: _screenshotController,
                        child: ModelViewer(
                          key: ValueKey(
                              _selectedModel), // This ensures the widget rebuilds
                          src: 'assets/m/$_selectedModel',
                          alt: "A 3D model of an object",
                          cameraControls: _cameraControls,
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
                           
                          });
                        }
                      },
                    ),
                    // PopupMenuButton(itemBuilder: itemBuilder)
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

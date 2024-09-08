import 'dart:typed_data';
import 'dart:ui';

import 'package:artiuosa/ui/drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class Viewer3d extends StatefulWidget {
  const Viewer3d({super.key});

  @override
  State<Viewer3d> createState() => _Viewer3dState();
}

class _Viewer3dState extends State<Viewer3d> {
  // double _brightness = 1.0;
  // bool _Controls = true;
  // String? _modelUrl;
  String _selectedModel = '1.glb';
  // bool _isLoading = true;
  // bool _cameraControls = true;

  final List<String> _models = [
    '1.glb',
    '2.glb',
    '3.glb',
  ];
  final Map<String, String> _modelMap = {
    '1.glb': 'Loomis',
    '2.glb': 'Detailed',
    '3.glb': 'Skull',
  };
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
  // Request storage permission
  if (await Permission.storage.request().isGranted||await Permission.photos.request().isGranted) {
    final Uint8List? image = await _screenshotController.capture();

    if (image != null) {
      // Save the image to the gallery
      final result = await ImageGallerySaver.saveImage(image, quality: 100, name: "screenshot");

      if (result['isSuccess']) {
        _showImageSavedDialog(context);
      } else {
        print('Error saving image to gallery');
        // Handle error if needed
      }
    }
  } else {
    // Handle the case where permission is not granted
    print('Storage permission not granted');
    // You might want to show a snackbar or dialog to inform the user
  }
}
  // Future<void> _saveScreenshot() async {
  //   final Uint8List? image = await _screenshotController.capture();
  //   bool dirDownloadExists = true;
  //   var directory;
  //   {
  //     directory = "/storage/emulated/0/Download/";

  //     dirDownloadExists = await Directory(directory).exists();
  //     if (dirDownloadExists) {
  //       directory = "/storage/emulated/0/Download/";
  //     } else {
  //       directory = "/storage/emulated/0/Downloads/";
  //     }
  //   }
  //   if (image != null) {
  //     final imagePath = '${directory}screenshot.png';
  //     final imageFile = File(imagePath);
  //     await imageFile.writeAsBytes(image);

  //     _showImageSavedDialog(context);
  //   }
  // }

  void _showImageSavedDialog(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Frosted glass effect
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: col.background.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  padding: EdgeInsets.all(25),
                  child: Center(
                    child: Text(
                      'Reference saved to gallery.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: col.onBackground,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Auto-dismiss the dialog after 1 second with a fade effect
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;

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
                  child: ModelViewer(
                    key: ValueKey(
                        _selectedModel), // This ensures the widget rebuilds
                    src: 'assets/m/$_selectedModel',
                    alt: "A 3D model of an object",
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Text('Brightness'),
                // Slider(
                //   value: _brightness,
                //   min: 0.0,
                //   max: 1.0,
                //   onChanged: (value) {
                //     setState(() {
                //       _brightness = value;
                //     });
                //   },
                // ),
                // Text('Select Model: '),
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<String>(
                      segments: _models.map((String value) {
                        return ButtonSegment<String>(
                          value: value,
                          label: Text(_modelMap[value]!),
                        );
                      }).toList(),
                      selected: {_selectedModel},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          // Since only one selection is allowed, we take the first element
                          _selectedModel = newSelection.first;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),

                FilledButton(
                  onPressed: _saveScreenshot,
                  child: Text('Save Posture'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

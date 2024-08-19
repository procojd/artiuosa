// import 'dart:async';
// import 'dart:io';
// import 'dart:ui' as ui;

// import 'package:animate_do/animate_do.dart';
// import 'package:artiuosa/ui/colors.dart';
// import 'package:artiuosa/ui/drawer.dart';
// import 'package:artiuosa/ui/gridpainter.dart';
// import 'package:artiuosa/ui/modalsheet.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class home_screen extends StatefulWidget {
//   const home_screen({super.key});

//   @override
//   State<home_screen> createState() => _home_screenState();
// }

// class _home_screenState extends State<home_screen> {
//   File? _image;
//   final String _imagePathKey = 'image_path';
//   final String imagewidth = 'image width';
//   final String imageheight = 'image height';
//   double scale = 1.0;
//   late double img_height;
//   late double img_width;
//   ui.Size? _imageSize;
//   late ui.Size imageSize;
//   @override
//   void initState() {
//     super.initState();
//     _loadImagePath();
//   }

//   // Future<void> _pickImage() async {
//   //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   //   if (pickedFile != null) {
//   //     _showPaperSizeDialog(File(pickedFile.path));
//   //   }
//   // }

//   void _showPaperSizeDialog(File imageFile) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         // ColorScheme col = Theme.of(context).colorScheme;
//         return AlertDialog(

//           content: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: PaperSizeSelection(
//               onPaperSizeSelected: (String paperSize, String orientation) {
//                 _cropImage(imageFile, paperSize, orientation,context);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _cropImage(
//       File imageFile, String paperSize, String orientation,BuildContext context) async {
//         ColorScheme col = Theme.of(context).colorScheme;
//     final cropAspectRatio = ac.getCropAspectRatio(paperSize, orientation);
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//       sourcePath: imageFile.path,
//       aspectRatio: cropAspectRatio,
//       uiSettings: [
//         AndroidUiSettings(

//           toolbarTitle: 'Crop',
//           activeControlsWidgetColor:col.primaryContainer ,
//           backgroundColor: col.surface,
//           dimmedLayerColor: col.background,
//           toolbarColor: col.background,
//           hideBottomControls: true,
//           toolbarWidgetColor: col.onBackground,
//           aspectRatioPresets: [
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.square,
//           ],
//         ),
//         IOSUiSettings(
//           title: 'Cropper',
//           aspectRatioPresets: [
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.square,
//             // IMPORTANT: iOS supports only one custom aspect ratio in preset list
//           ],
//         ),
//         WebUiSettings(
//           context: context,
//         ),
//       ],
//     );

//     if (croppedFile != null) {
//       setState(() {
//       });
//     }
//   }

//   Future<void> _loadImagePath() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? imagePath = prefs.getString(_imagePathKey);
//     String? imgw = prefs.getString(imagewidth);
//     String? imgh = prefs.getString(imageheight);
//     if (imagePath != null) {
//       setState(() {
//         _image = File(imagePath);
//         img_width = double.parse(imgw ?? '20.0');
//         img_height = double.parse(imgh ?? '20.0');
//       });
//     }
//   }

//   // Future<void> _pickImage() async {
//   //   final picker = ImagePicker();
//   //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       _image = File(pickedFile.path);
//   //     });
//   //     SharedPreferences prefs = await SharedPreferences.getInstance();
//   //     await prefs.setString(_imagePathKey, pickedFile.path);
//   //   }
//   // }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       final imageFile = File(pickedFile.path);

//       // Get image dimensions
//       _imageSize = await _getImageSize(imageFile);

//       // Update state with image and its dimensions
//       setState(() {
//         _image = imageFile;
//         imageSize = _imageSize!;
//         print('//////////${imageSize.height}');
//         img_width = imageSize.width;
//         img_height = imageSize.height;
//       });

//       // Save image path to SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString(_imagePathKey, pickedFile.path);
//       await prefs.setString(imagewidth, imageSize.width.toString());
//       await prefs.setString(imageheight, imageSize.height.toString());

//     _showPaperSizeDialog(File(pickedFile.path));
//       }
//   }

//   Future<ui.Size> _getImageSize(File imageFile) async {
//     final completer = Completer<ui.Size>();
//     final image = Image.file(imageFile);
//     image.image.resolve(ImageConfiguration()).addListener(
//       ImageStreamListener((ImageInfo info, bool _) {
//         completer.complete(
//             ui.Size(info.image.width.toDouble(), info.image.height.toDouble()));
//       }),
//     );

//     return completer.future;
//   }

//   @override
//   Widget build(BuildContext context) {

//     final width = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       drawer: ClipRRect(
//         child: newMethod(context),
//       ),
//       appBar: AppBar(
//         centerTitle: true,
//         actions: [
//           _image != null
//               ? IconButton(onPressed: _pickImage, icon: Icon(Icons.add))
//               : SizedBox(),
//           IconButton(
//               onPressed: () {
//                 bot_sheet(context);
//               },
//               icon: Icon(Icons.more_vert_rounded)),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Icon(Icons.person_outline),
//           )
//         ],
//         title: Text('Artiuosa'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             _image == null
//                 ? Text(
//                     'No image selected.',
//                     style: TextStyle(color: kblack, fontSize: 16),
//                   )
//                 : Expanded(
//                     child: LayoutBuilder(builder: (context, constraints) {
//                       return InteractiveViewer(
//                         // onInteractionUpdate: (details) {
//                         //   if (details.scale != 10.0 && details.scale != 1) {
//                         //     setState(() {
//                         //       scale = details.scale;
//                         //     });
//                         //   }
//                         // },
//                         minScale: 0.1,
//                         maxScale: 10.0,
//                         child: Center(
//                           child: Stack(
//                             children: [
//                               FadeIn(child: Image.file(_image!)),
//                               // CustomPaint(
//                               //   // size: Size(300, 300), // Size of the canvas
//                               //   painter: GoldenRatioGridPainter(),
//                               // ),
//                               Obx(() {return CustomPaint(
//                                 painter: GridPainter(
//                                   imageWidth: width,
//                                   imageHeight: (img_height*width)/img_width,
//                                   scale: ac.bottomsheet.value,
//                                 ),
//                               );})
//                               // CustomPaint(
//                               //   painter: GridPainter(
//                               //     imageWidth: width,
//                               //     imageHeight: (img_height*width)/img_width,
//                               //     scale: double.parse(ac.color.value),
//                               //   ),
//                               // ),

//                               // CustomPaint(

//                               //   painter: GridPainter(
//                               //     imageWidth: constraints.maxWidth,
//                               //     imageHeight: constraints.maxHeight,
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//             _image == null ? SizedBox(height: 20) : SizedBox(),
//             _image == null
//                 ? FilledButton(
//                     onPressed: _pickImage,
//                     child: Text('Browse Image'),
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );

//   }
// }

// class PaperSizeSelection extends StatefulWidget {
//   final Function(String, String) onPaperSizeSelected;

//   PaperSizeSelection({required this.onPaperSizeSelected});

//   @override
//   _PaperSizeSelectionState createState() => _PaperSizeSelectionState();
// }
// class _PaperSizeSelectionState extends State<PaperSizeSelection> {
//   String _selectedPaperSize = 'A4';
//   String _selectedOrientation = 'Portrait';

//   final List<String> paperSizes = ['A1','A2','A3','A4', 'A5',];
//   final List<String> orientations = ['Portrait', 'Landscape'];

//   @override
//   Widget build(BuildContext context) {
//     // ColorScheme col = Theme.of(context).colorScheme;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text('Paper Size'),
//         SizedBox(height: 10,),
//         ToggleButtons(
//           borderRadius: BorderRadius.circular(10),

//           isSelected: paperSizes.map((size) => size == _selectedPaperSize).toList(),
//           onPressed: (int index) {
//             setState(() {
//               _selectedPaperSize = paperSizes[index];
//             });
//           },
//           children: paperSizes.map((size) => Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Text(size),
//           )).toList(),
//         ),
//         SizedBox(height: 20),
//         Text('Orientation'),
//         SizedBox(height: 10,),
//         ToggleButtons(
//           borderRadius: BorderRadius.circular(10),
//           isSelected: orientations.map((orientation) => orientation == _selectedOrientation).toList(),
//           onPressed: (int index) {
//             setState(() {
//               _selectedOrientation = orientations[index];
//             });
//           },
//           children: orientations.map((orientation) => Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Text(orientation),
//           )).toList(),
//         ),
//         SizedBox(height: 40),
//         SizedBox(
//           width: 120,
//           child: FilledButton(
//             onPressed: () {
//               widget.onPaperSizeSelected(_selectedPaperSize, _selectedOrientation);
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/ui/colors.dart';
import 'package:artiuosa/ui/drawer.dart';
import 'package:artiuosa/ui/gridpainter.dart';
import 'package:artiuosa/ui/modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  final String _imagePathKey = 'image_path';
  final String imageWidthKey = 'image_width';
  final String imageHeightKey = 'image_height';
  double scale = 1.0;
  double? imgHeight;
  double? imgWidth;
  ui.Size? _imageSize;

  @override
  void initState() {
    super.initState();
    _loadImagePath();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      _showPaperSizeDialog(imageFile);
    }
  }

  void _showPaperSizeDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PaperSizeSelection(
              onPaperSizeSelected: (String paperSize, String orientation) {
                _cropImage(imageFile, paperSize, orientation, context);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _cropImage(File imageFile, String paperSize, String orientation,
      BuildContext context) async {
    ColorScheme col = Theme.of(context).colorScheme;
    final cropAspectRatio = ac.getCropAspectRatio(paperSize, orientation);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: cropAspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          activeControlsWidgetColor: col.primaryContainer,
          backgroundColor: col.surface,
          dimmedLayerColor: col.background,
          toolbarColor: col.background,
          hideBottomControls: true,
          toolbarWidgetColor: col.onBackground,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      final croppedImageFile = File(croppedFile.path);
      _setImageWithSize(croppedImageFile);
    }
  }

  Future<void> _setImageWithSize(File imageFile) async {
    _imageSize = await _getImageSize(imageFile);

    setState(() {
      _image = imageFile;
      imgWidth = _imageSize?.width;
      imgHeight = _imageSize?.height;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imagePathKey, imageFile.path);
    await prefs.setString(imageWidthKey, imgWidth.toString());
    await prefs.setString(imageHeightKey, imgHeight.toString());
  }

  Future<ui.Size> _getImageSize(File imageFile) async {
    final completer = Completer<ui.Size>();
    final image = Image.file(imageFile);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(
            ui.Size(info.image.width.toDouble(), info.image.height.toDouble()));
      }),
    );

    return completer.future;
  }

  Future<void> _loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString(_imagePathKey);
    String? imgw = prefs.getString(imageWidthKey);
    String? imgh = prefs.getString(imageHeightKey);
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
        imgWidth = double.parse(imgw ?? '20.0');
        imgHeight = double.parse(imgh ?? '20.0');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
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
                        minScale: 0.1,
                        maxScale: 10.0,
                        child: Center(
                          child: Stack(
                            children: [
                              FadeIn(child: Image.file(_image!)),
                              Obx(() {
                                return CustomPaint(
                                  painter: GridPainter(
                                    imageWidth: width,
                                    imageHeight:
                                        (imgHeight! * width) / imgWidth!,
                                    scale: ac.bottomsheet.value,
                                  ),
                                );
                              }),
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

class PaperSizeSelection extends StatefulWidget {
  final Function(String, String) onPaperSizeSelected;

  PaperSizeSelection({required this.onPaperSizeSelected});

  @override
  _PaperSizeSelectionState createState() => _PaperSizeSelectionState();
}

class _PaperSizeSelectionState extends State<PaperSizeSelection> {
  String _selectedPaperSize = 'A4';
  String _selectedOrientation = 'Portrait';

  final List<String> paperSizes = ['A1', 'A2', 'A3', 'A4', 'A5'];
  final List<String> orientations = ['Portrait', 'Landscape'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Paper Size'),
        SizedBox(height: 10),
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          isSelected:
              paperSizes.map((size) => size == _selectedPaperSize).toList(),
          onPressed: (int index) {
            setState(() {
              _selectedPaperSize = paperSizes[index];
            });
          },
          children: paperSizes
              .map((size) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(size),
                  ))
              .toList(),
        ),
        SizedBox(height: 20),
        Text('Orientation'),
        SizedBox(height: 10),
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          isSelected: orientations
              .map((orientation) => orientation == _selectedOrientation)
              .toList(),
          onPressed: (int index) {
            setState(() {
              _selectedOrientation = orientations[index];
            });
          },
          children: orientations
              .map((orientation) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(orientation),
                  ))
              .toList(),
        ),
        SizedBox(height: 40),
        SizedBox(
          width: 120,
          child: FilledButton(
            onPressed: () {
              widget.onPaperSizeSelected(
                  _selectedPaperSize, _selectedOrientation);
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ),
      ],
    );
  }
}

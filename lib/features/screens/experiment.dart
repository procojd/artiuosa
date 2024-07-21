import 'dart:io';
import 'package:artiuosa/ui/colors.dart';
import 'package:artiuosa/ui/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class crop extends StatefulWidget {
  @override
  _cropState createState() => _cropState();
}

class _cropState extends State<crop> {
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _showPaperSizeDialog(File(pickedFile.path));
    }
  }

  void _showPaperSizeDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (context) {
        ColorScheme col = Theme.of(context).colorScheme;
        return AlertDialog(
         
        
          
          
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PaperSizeSelection(
              onPaperSizeSelected: (String paperSize, String orientation) {
                _cropImage(imageFile, paperSize, orientation,context);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _cropImage(
      File imageFile, String paperSize, String orientation,BuildContext context) async {
        ColorScheme col = Theme.of(context).colorScheme;
    final cropAspectRatio = _getCropAspectRatio(paperSize, orientation);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: cropAspectRatio,
      uiSettings: [
        AndroidUiSettings(
          
          toolbarTitle: 'Crop',
          activeControlsWidgetColor:col.primaryContainer ,
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
            // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  CropAspectRatio _getCropAspectRatio(String paperSize, String orientation) {
    switch (paperSize) {
      case 'A4':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 210, ratioY: 297)
            : CropAspectRatio(ratioX: 297, ratioY: 210);
      case 'A5':
        return orientation == 'Portrait'
            ? CropAspectRatio(ratioX: 148, ratioY: 210)
            : CropAspectRatio(ratioX: 210, ratioY: 148);
      default:
        return CropAspectRatio(ratioX: 1, ratioY: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [

         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.person_outline),
          )
        ],
        title: Text('Artiuosa'),
      ),
      drawer: newMethod(context),
      body: Center(
        child: _imageFile == null
            ? Text('No image selected.')
            : Image.file(_imageFile!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
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

  final List<String> paperSizes = ['A1','A2','A3','A4', 'A5',];
  final List<String> orientations = ['Portrait', 'Landscape'];

  @override
  Widget build(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Paper Size'),
        SizedBox(height: 10,),
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          
          isSelected: paperSizes.map((size) => size == _selectedPaperSize).toList(),
          onPressed: (int index) {
            setState(() {
              _selectedPaperSize = paperSizes[index];
            });
          },
          children: paperSizes.map((size) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(size),
          )).toList(),
        ),
        SizedBox(height: 20),
        Text('Orientation'),
        SizedBox(height: 10,),
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          isSelected: orientations.map((orientation) => orientation == _selectedOrientation).toList(),
          onPressed: (int index) {
            setState(() {
              _selectedOrientation = orientations[index];
            });
          },
          children: orientations.map((orientation) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(orientation),
          )).toList(),
        ),
        SizedBox(height: 40),
        SizedBox(
          width: 120,
          child: FilledButton(
            onPressed: () {
              widget.onPaperSizeSelected(_selectedPaperSize, _selectedOrientation);
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ),
      ],
    );
  }
}

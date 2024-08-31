import 'package:artiuosa/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final controller ac = Get.put(controller());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Paper Size'),
        SizedBox(height: 10,width: double.infinity,),
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          isSelected:
              paperSizes.map((size) => size == _selectedPaperSize).toList(),
          onPressed: (int index) {
            setState(() {
              _selectedPaperSize = paperSizes[index];
              print(paperSizes[index]);
            });
          },
          children: paperSizes.map((size) => Text(size)).toList(),
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
              print(orientations[index]);
            });
          },
          children: orientations
              .map((orientation) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                        width: 120, child: Center(child: Text(orientation))),
                  ))
              .toList(),
        ),
        SizedBox(height: 40),
        SizedBox(
          width: 120,
          child: FilledButton(
            onPressed: () async {
              await _savePaperDimensions();
              widget.onPaperSizeSelected(
                  _selectedPaperSize, _selectedOrientation);
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Future<void> _savePaperDimensions() async {
    final prefs = await SharedPreferences.getInstance();

    double height, width;

    switch (_selectedPaperSize) {
      case 'A1':
        height = _selectedOrientation == 'Portrait' ? 841.0 : 594.0;
        width = _selectedOrientation == 'Portrait' ? 594.0 : 841.0;
        break;
      case 'A2':
        height = _selectedOrientation == 'Portrait' ? 594.0 : 420.0;
        width = _selectedOrientation == 'Portrait' ? 420.0 : 594.0;
        break;
      case 'A3':
        height = _selectedOrientation == 'Portrait' ? 420.0 : 297.0;
        width = _selectedOrientation == 'Portrait' ? 297.0 : 420.0;
        break;
      case 'A4':
        height = _selectedOrientation == 'Portrait' ? 297.0 : 210.0;
        width = _selectedOrientation == 'Portrait' ? 210.0 : 297.0;
        break;
      case 'A5':
        height = _selectedOrientation == 'Portrait' ? 210.0 : 148.0;
        width = _selectedOrientation == 'Portrait' ? 148.0 : 210.0;
        break;
      default:
        height = 297.0;
        width = 210.0;
    }

    // Save dimensions in shared preferences
    await prefs.setDouble('paperHeight', height);
    await prefs.setDouble('paperWidth', width);

    // Update the obs variables
    ac.paperHeight.value = height;
    ac.paperWidth.value = width;
  }
}

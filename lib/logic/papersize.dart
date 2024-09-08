import 'dart:math';
import 'dart:ui';

import 'package:artiuosa/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: col.primaryContainer,
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Space between text and switch
            children: [
              Text(
                "Custom Dimension",
                style: TextStyle(fontSize: 16.0), // Text style
              ),
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Opacity(opacity: _isSwitched ? 0.5 : 1.0, child: Text('Paper Size')),
        SizedBox(
          height: 10,
          width: double.infinity,
        ),
        IgnorePointer(
          ignoring: _isSwitched,
          child: Opacity(
            opacity: _isSwitched ? 0.5 : 1.0,
            child: ToggleButtons(
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
          ),
        ),
        SizedBox(height: 20),
        Opacity(opacity: _isSwitched ? 0.5 : 1.0, child: Text('Orientation')),
        SizedBox(height: 10),
        IgnorePointer(
          ignoring: _isSwitched,
          child: Opacity(
            opacity: _isSwitched ? 0.5 : 1.0,
            child: ToggleButtons(
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
                            width: 120,
                            child: Center(child: Text(orientation))),
                      ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1, // Set the height to 2px
              width: 100, // Adjust the width as needed
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent, // Faded left edge
                    Colors.grey, // Solid color on the right
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Text('or'),
            SizedBox(width: 10),
            Container(
              height: 1, // Set the height to 2px
              width: 100, // Adjust the width as needed
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.grey,
                    Colors.transparent, // Faded left edge
                    // Solid color on the right
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        IgnorePointer(
          ignoring: !_isSwitched,
          child: Opacity(
            opacity: !_isSwitched ? 0.5 : 1.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.tonalIcon(
                    onPressed: () {
                      _showFrostedGlassDialog1(context, 'h');
                    },
                    icon: Icon(Icons.height_rounded),
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SizedBox(height: 10),
                        Text('Height'),
                        Text('${ac.tempheight.value ?? 0}mm'),
                         SizedBox(height: 10),
                      ],
                    )),
                FilledButton.tonalIcon(
                    onPressed: () {
                      _showFrostedGlassDialog1(context, 'w');
                    },
                    icon: Transform.rotate(
                        angle: pi / 2, child: Icon(Icons.height_rounded)),
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Width'),
                        Text('${ac.tempwidth.value ?? 0}mm'),
                        SizedBox(height: 10),
                      ],
                    )),
              ],
            ),
          ),
        ),
        SizedBox(height: 40),
        SizedBox(
          width: 120,
          child: FilledButton(
            onPressed: () async {
              if (_isSwitched) {
                if (_isSwitched &&
                    ac.tempheight.value != null &&
                    ac.tempwidth.value != null) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setDouble('paperHeight', ac.tempheight.value!);
                  await prefs.setDouble('paperWidth', ac.tempwidth.value!);

                  // Update the obs variables
                  ac.paperHeight.value = ac.tempheight.value!;
                  ac.paperWidth.value = ac.tempwidth.value!;

                  widget.onPaperSizeSelected('custom', _selectedOrientation);

                  Navigator.of(context).pop();
                } else {
                  _showvalueerrorSavedDialog(context);
                }
              } else {
                await _savePaperDimensions();
                widget.onPaperSizeSelected(
                    _selectedPaperSize, _selectedOrientation);
                Navigator.of(context).pop();
              }
            },
            child: Text('OK'),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _showvalueerrorSavedDialog(BuildContext context) {
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
                      'Please fill both custom values',
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

  void _showFrostedGlassDialog1(BuildContext context, String d) {
    ColorScheme col = Theme.of(context).colorScheme;
    final TextEditingController _controller = TextEditingController();
    final controller ac = Get.put(controller());
    String? errorMessage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // Frosted glass effect
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: col.background.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter value in cm ',
                            labelStyle: TextStyle(
                                color: col.onBackground.withOpacity(0.5)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: col.onBackground),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: col.primary),
                            ),
                            errorText: errorMessage, // Display error message
                          ),
                          style: TextStyle(color: col.onBackground),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: col.primary),
                              ),
                            ),
                            SizedBox(width: 8),
                            FilledButton.tonal(
                              onPressed: () {
                                int? value = int.tryParse(_controller.text);
                                if (value != null &&
                                    value >= 1 &&
                                    value <= 999) {
                                  if (d == 'h') {
                                    ac.tempheight.value = value * 10.toDouble();
                                  } else {
                                    ac.tempwidth.value = value * 10.toDouble();
                                  }
                                  Navigator.of(context).pop();
                                } else {
                                  // Set the error message if the value is not within the allowed range
                                  setState(() {
                                    errorMessage =
                                        'Please enter a value between 1 and 999 mm';
                                  });
                                }
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

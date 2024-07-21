import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/model/colormode.dart';
import 'package:artiuosa/ui/colors.dart';
import 'package:artiuosa/ui/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorMixScreen extends StatefulWidget {
  @override
  _ColorMixScreenState createState() => _ColorMixScreenState();
}

class _ColorMixScreenState extends State<ColorMixScreen> {
  
  List<Color> selectedColors = [Colors.red, Colors.white];
  int selectedColorIndex = 0;
  Color mixedColor = Color.fromARGB(255, 180, 180, 180);

  void _selectColor(int index) async {
    Color selectedColor = selectedColors[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColors[index] = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _mixColors() {
    if (selectedColors.length >= 2) {
      int red = 0;
      int green = 0;
      int blue = 0;
      for (var color in selectedColors) {
        red += color.red;
        green += color.green;
        blue += color.blue;
      }
      red = (red / selectedColors.length).toInt();
      green = (green / selectedColors.length).toInt();
      blue = (blue / selectedColors.length).toInt();

      setState(() {
        mixedColor = Color.fromRGBO(red, green, blue, 1.0);
      });
    }
  }

  void _addColor() {
    if (selectedColors.length < 5) {
      setState(() {
        selectedColors.add(Colors.blue);
      });
    }
  }

  void _removeColor(int index) {
    if (selectedColors.length > 2) {
      setState(() {
        selectedColors.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;
    return Scaffold(
      
      drawer: ClipRRect(
        child: newMethod(context),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton.filled(
                  onPressed: _addColor,
                  icon: Icon(Icons.add),
                ),
                FilledButton(
                  onPressed: () {
                    showPencilDialog(context);
                  },
                  child: Text('Palette'),
                ),
                Spacer(),
                FilledButton.tonal(
                  onPressed: _mixColors,
                  child: Text('Mix Colors'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    mixedColor,
                    Colors.black,
                  ],
                  center: Alignment(0.0, 0.2), // Center of the gradient
                  radius: 1.6, // Radius of the gradient
                  stops: [0.30, 1.0], // Where the colors should stop
                ),
                shape: BoxShape.circle,
                color: mixedColor,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedColors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: col.secondaryContainer,
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              selectedColors[index],
                              Colors.black,
                            ],
                            center:
                                Alignment(0.0, 0.2), // Center of the gradient
                            radius: 1.5, // Radius of the gradient
                            stops: [0.28, 1.0], // Where the colors should stop
                          ),
                          shape: BoxShape.circle,
                          color: selectedColors[index],
                        ),
                      ),
                      title: Text(
                        'Hex Code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${selectedColors[index].toHexString()}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel_rounded),
                        onPressed: () => _removeColor(index),
                      ),
                      onTap: () => _selectColor(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showPencilDialog(BuildContext context) {
  final ScrollController _scrollController = ScrollController();
  final Map<String, int> _indexMap = {};

  // Populate the index map
  for (int i = 0; i < prismacolorPencils.length; i++) {
    String firstLetter = prismacolorPencils[i].name[0].toUpperCase();
    if (!_indexMap.containsKey(firstLetter)) {
      _indexMap[firstLetter] = i;
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      ColorScheme col = Theme.of(context).colorScheme;
      return AlertDialog(
        
        backgroundColor: col.background,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            
          ),
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: prismacolorPencils.length,
                          itemBuilder: (context, index) {
                            final pencil = prismacolorPencils[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 0.0,),
                                    child: Card(
                                      margin: EdgeInsets.only(top:4.0,right: 4,left:4,bottom:4),
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                          
                        color: pencil.hex.toColor(),
                        shape: BoxShape.circle,
                        
                              gradient: RadialGradient(
                                colors: [
                                  pencil.hex.toColor()!,
                                  Colors.black,
                                ],
                                center:
                                    Alignment(0.0, 0.2), // Center of the gradient
                                radius: 1.5, // Radius of the gradient
                                stops: [0.28, 1.0], // Where the colors should stop
                              ),
                             
                            
                        
                                          ),
                                        ),
                                        title: Text(pencil.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                                        subtitle: Text(pencil.code),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AlphabetScrollbar(
                      
                        onLetterTap: (String letter) {
                          if (_indexMap.containsKey(letter)) {
                            _scrollController.animateTo(
                              _indexMap[letter]! *
                                  56.0, // Adjust 56.0 based on ListTile height
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubicEmphasized,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class AlphabetScrollbar extends StatelessWidget {
  final List<String> alphabet =
      List.generate(26, (index) => String.fromCharCode(index + 65));
  final Function(String) onLetterTap;

  AlphabetScrollbar({required this.onLetterTap});

  @override
  Widget build(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: col.secondaryContainer
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: alphabet.map((letter) {
          return GestureDetector(
            onTap: () => onLetterTap(letter),
            child: Container(
              padding: EdgeInsets.all(2.0),
              child: Text(
                letter,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold,color: col.onSecondaryContainer),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

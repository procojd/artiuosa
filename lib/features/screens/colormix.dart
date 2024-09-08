import 'package:artiuosa/controller/controller.dart';
import 'package:artiuosa/model/colormode.dart';
import 'package:artiuosa/model/savemodel.dart';
import 'package:artiuosa/ui/colormix_modalsheet.dart';
import 'package:artiuosa/ui/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class ColorMixScreen extends StatefulWidget {
  @override
  _ColorMixScreenState createState() => _ColorMixScreenState();
}

class _ColorMixScreenState extends State<ColorMixScreen> {
  final controller ac = Get.put(controller());

  TextEditingController tc = TextEditingController();

  int selectedColorIndex = 0;
  Color mixedColor = Color.fromARGB(255, 180, 180, 180);

  void _selectColor(int index) async {
    Color selectedColor = ac.availablePencils[index].hex.toColor()!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              hexInputBar: true,
              enableAlpha: false,
              hexInputController: tc,
              labelTypes: [ColorLabelType.rgb],
              onColorChanged: (color) {
                ac.availablePencils[index].name = 'picked';
                print(color.red);
                print(color.toHexString());

                setState(() {
                  ac.availablePencils[index].hex = tc.text;

                  print(color.red);
                  ac.availablePencils[index].rgb = [
                    color.red,
                    color.green,
                    color.blue
                  ];
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('ok'),
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
    if (ac.availablePencils.length >= 2) {
      int red = 0;
      int green = 0;
      int blue = 0;

      for (var pencil in ac.availablePencils) {
        red += pencil.rgb[0];
        green += pencil.rgb[1];
        blue += pencil.rgb[2];
      }

      red = (red / ac.availablePencils.length).toInt();
      green = (green / ac.availablePencils.length).toInt();
      blue = (blue / ac.availablePencils.length).toInt();

      setState(() {
        mixedColor = Color.fromRGBO(red, green, blue, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller ac = Get.put(controller());
    ac.loadColorModels();

    ColorScheme col = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: ClipRRect(
        child: newMethod(context),
      ),
      appBar: AppBar(
        centerTitle: true,
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
                  onPressed: () {
                    // ac._addColor('#008ACF');
                    ac.addcm(PrismacolorPencil(
                      name: 'picked',
                      code: 'Custom',
                      hex: '#008ACF',
                      rgb: [0, 138, 207],
                    ));
                  },
                  icon: Icon(Icons.add),
                ),
                FilledButton(
                  onPressed: () async {
                    await showPencilDialog(context);
                    setState(() {});
                  },
                  child: Text('Palette'),
                ),
                IconButton.filled(
                  onPressed: () {
                    showSavedColors(context);
                  },
                  icon: Icon(Icons.archive),
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
              child: Obx(() {
                return ListView.builder(
                  itemCount: ac.availablePencils.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          tileColor: col.secondaryContainer,
                          leading: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  ac.availablePencils[index].hex.toColor()!,
                                  Colors.black,
                                ],
                                center: Alignment(
                                    0.0, 0.2), // Center of the gradient
                                radius: 1.5, // Radius of the gradient
                                stops: [
                                  0.28,
                                  1.0
                                ], // Where the colors should stop
                              ),
                              shape: BoxShape.circle,
                              color: ac.availablePencils[index].hex.toColor()!,
                            ),
                          ),
                          title: Text(
                            'Hex Code',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${ac.availablePencils[index].hex}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.cancel_rounded),
                              onPressed: () {
                                ac.removecm(index);
                                setState(() {});
                              }),
                          onTap: () async{
                            
                           _selectColor(index);
                            
                          }),
                    );
                  },
                );
              }),
            ),
            FilledButton.tonal(
                onPressed: () {
                  // List<PrismacolorPencil> pencils = [
                  //   PrismacolorPencil(
                  //     name: 'Red',
                  //     code: 'PC923',
                  //     hex: '#F00',
                  //     rgb: [255, 0, 0],
                  //   ),
                  //   PrismacolorPencil(
                  //     name: 'Blue',
                  //     code: 'PC903',
                  //     hex: '#00F',
                  //     rgb: [0, 0, 255],
                  //   ),
                  // ];
                  cm colorModel = cm(
                      name: 'ExampleColor',
                      hex: mixedColor.toHexString(),
                      pencils: ac.availablePencils);

                  // Create a cm instance

                  ac.savecm(colorModel);
                },
                child: Text('Save')),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showPencilDialog(BuildContext context) async {
  final controller ac = Get.put(controller());
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
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        backgroundColor: col.background,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          // width: double.maxFinite,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ListView.builder(
                          // controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          itemCount: prismacolorPencils.length,
                          itemBuilder: (context, index) {
                            final pencil = prismacolorPencils[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 0.0,
                              ),
                              child: ListTile(
                                onTap: () {
                                  ac.addcm(pencil);
                                },
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
                                      center: Alignment(
                                          0.0, 0.2), // Center of the gradient
                                      radius: 1.5, // Radius of the gradient
                                      stops: [
                                        0.28,
                                        1.0
                                      ], // Where the colors should stop
                                    ),
                                  ),
                                ),
                                title: Text(pencil.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(pencil.code),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: AlphabetScrollbar(

                    //     onLetterTap: (String letter) {
                    //       if (_indexMap.containsKey(letter)) {
                    //         _scrollController.animateTo(
                    //           _indexMap[letter]! *
                    //               150.0, // Adjust 56.0 based on ListTile height
                    //           duration: Duration(milliseconds: 300),
                    //           curve: Curves.easeInOutCubicEmphasized,
                    //         );
                    //       }
                    //     },
                    //   ),
                    // ),
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
          color: col.secondaryContainer),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: alphabet.map((letter) {
          return GestureDetector(
            onTap: () => onLetterTap(letter),
            child: Container(
              padding: EdgeInsets.all(2.0),
              child: Text(
                letter,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: col.onSecondaryContainer),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/controller/controller.dart';
import 'package:artiuosa/features/screens/filters.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as cp;
import 'package:get/get.dart';

void bot_sheet(BuildContext context) {
  // double _opacity = 1.0;
  // Color _selectedColor = Colors.black;
  // bool _showOpacitySlider = false;
  // bool _showColorSlider = false;
  final Map mp = {
    'S': 0.1,
    'M': 0.3,
    'L': 0.6,
    'XL': 0.9,
  };
  ColorScheme col = Theme.of(context).colorScheme;
  final controller ac = Get.put(controller());

  showModalBottomSheet(
    isDismissible: false,
    scrollControlDisabledMaxHeightRatio: 0.7,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Obx(() {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        IconButton.filledTonal(
                            onPressed: () {
                              ac.bottomsheet.value = !ac.bottomsheet.value;
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.done_rounded))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                      child: Text(
                        'Stroke width',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: ['S', 'M', 'L', 'XL']
                          .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: IconButton.filledTonal(
                                    isSelected: mp[e] == ac.strokeWidth.value,
                                    onPressed: () {
                                      ac.strokeWidth.value = mp[e];
                                      ac.storeStrokeWidth(ac.strokeWidth.value);
                                    },
                                    icon: Text(e)),
                              )))
                          .toList(),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: FilledButton.tonal(
                                style: FilledButton.styleFrom(
                                    side: ac.diagonalLines.value
                                        ? BorderSide(
                                            color: col.primary, width: 1)
                                        : BorderSide.none),
                                onPressed: () {
                                  ac.diagonalLines.value =
                                      !ac.diagonalLines.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Text('Diagonal Lines'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: FilledButton.tonal(
                                style: FilledButton.styleFrom(
                                    side: ac.squareGrid.value
                                        ? BorderSide(
                                            color: col.primary, width: 1)
                                        : BorderSide.none),
                                onPressed: () {
                                  ac.squareGrid.value = !ac.squareGrid.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text('Square lines'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Color'),
                      trailing: GestureDetector(
                        onTap: () {
                          ac.color.value = ac.color.value;
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              cp.colorFromHex(ac.color.value) ?? Colors.white,
                        ),
                      ),
                    ),
                    ColorPicker(
                      enableTooltips: true,
                      pickersEnabled: {ColorPickerType.wheel: true},
                      enableOpacity: true,
                      // Use the screenPickerColor as color.
                      color: cp.colorFromHex(ac.color.value) ?? Colors.white,
                      // Update the screenPickerColor using the callback.
                      onColorChanged: (Color color) => setState(() {
                        ac.storeColor(cp.colorToHex(color));
                        ac.color.value = cp.colorToHex(color);
                      }),
                      width: 44,
                      height: 44,
                      borderRadius: 22,
                      // heading: Text(
                      //   'Select color',
                      //   style: Theme.of(context).textTheme.headlineSmall,
                      // ),
                      subheading: Text(
                        'Select color shade',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Divider(),
                    ListTile(
                        onTap: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        title: Text(
                          'Line distance',
                          style: bottomtext(),
                        ),
                        subtitle: Text('25mm'),
                        trailing: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              _showFrostedGlassDialog(context);
                            },
                            icon: Icon(Icons.info_outline_rounded))),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    //   child: Text('Grid type',
                    //       style: TextStyle(
                    //         fontSize: 22,
                    //         fontWeight: FontWeight.bold,
                    //       )),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Expanded(
                    //         child: FilledButton.tonal(
                    //           style: FilledButton.styleFrom(
                    //               side:
                    //                   BorderSide(color: col.primary, width: 1)),
                    //           onPressed: () {},
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(20.0),
                    //             child: Text('Golden ratio'),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5,
                    //       ),
                    //       Expanded(
                    //         child: FilledButton.tonal(
                    //           style: FilledButton.styleFrom(
                    //               side:
                    //                   BorderSide(color: col.primary, width: 1)),
                    //           onPressed: () {},
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(20.0),
                    //             child: Text('Square Grid'),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Divider(),
                    ListTile(
                      onTap: () {
                        if (ac.selectedFile.value != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ExampleImageFilterSelection()),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      title: Text(
                        'Image Filters',
                        style: bottomtext(),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      title: Text(
                        'Save Image',
                        style: bottomtext(),
                      ),
                      trailing: Icon(Icons.download_rounded),
                    )
                  ],
                ),
              ),
            );
          });
        },
      );
    },
  );
}

void _showFrostedGlassDialog(BuildContext context) {
  ColorScheme col = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    builder: (context) => Dialog(
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
                    Text(
                      'Info',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: col.onBackground,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Grid Spacing refers to the distance between adjacent lines in a grid. The measurment unit is mm(1/10 cm).',
                      style: TextStyle(color: col.onBackground),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    FadeIn(
                      delay: Durations.medium1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset('assets/images/mm.png')),
                    ),
                    SizedBox(height: 24),
                    FilledButton.tonal(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      
                      child: Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

TextStyle bottomtext() => TextStyle(fontWeight: FontWeight.w500);

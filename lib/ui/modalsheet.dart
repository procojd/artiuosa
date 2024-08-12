import 'package:artiuosa/controller.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as cp;
import 'package:get/get.dart';

void bot_sheet(BuildContext context) {
  double _opacity = 1.0;
  Color _selectedColor = Colors.black;
  bool _showOpacitySlider = false;
  bool _showColorSlider = false;
  final Map mp = {
    'S': 0.3,
    'M': 0.6,
    'L': 0.9,
    'XL': 1.2,
  };
  ColorScheme col = Theme.of(context).colorScheme;
  final controller ac = Get.put(controller());

  showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 0.7,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                                  onPressed: () {
                                    ac.strokeWidth.value = mp[e];
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
                                  side:
                                      BorderSide(color: col.primary, width: 1)),
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
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
                                  side:
                                      BorderSide(color: col.primary, width: 1)),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Labels'),
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
                  //                 ListTile( shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(12.0),
                  // ),
                  //                   title: Text(
                  //                     'Color',
                  //                     style: bottomtext(),
                  //                   ),
                  //                   trailing: Icon(
                  //                     _showColorSlider
                  //                         ? Icons.arrow_drop_down_rounded
                  //                         : Icons.arrow_right_rounded,
                  //                   ),
                  //                   onTap: () {
                  //                     setState(() {
                  //                       _showColorSlider = !_showColorSlider;
                  //                     });
                  //                   },
                  //                 ),
                  //                 AnimatedSwitcher(
                  //                   duration: const Duration(milliseconds: 300),
                  //                   transitionBuilder:
                  //                       (Widget child, Animation<double> animation) {
                  //                     return FadeTransition(opacity: animation, child: child);
                  //                   },
                  //                   child: _showColorSlider
                  //                       ? Row(
                  //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                           children: [
                  //                             Colors.red,
                  //                             Colors.green,
                  //                             Colors.blue,
                  //                             Colors.yellow,
                  //                             Colors.orange,
                  //                           ].map((color) {
                  //                             return GestureDetector(
                  //                               onTap: () {
                  //                                 setState(() {
                  //                                   _selectedColor = color;
                  //                                 });
                  //                               },
                  //                               child: CircleAvatar(
                  //                                 backgroundColor: color,
                  //                               ),
                  //                             );
                  //                           }).toList(),
                  //                         )
                  //                       : SizedBox.shrink(),
                  //                 ),
                  Divider(),
                  ListTile(
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
                          onPressed: () {},
                          icon: Icon(Icons.info_outline_rounded))),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: Text('Grid type',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: FilledButton.tonal(
                            style: FilledButton.styleFrom(
                                side: BorderSide(color: col.primary, width: 1)),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('Golden ratio'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: FilledButton.tonal(
                            style: FilledButton.styleFrom(
                                side: BorderSide(color: col.primary, width: 1)),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('Square Grid'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
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
        },
      );
    },
  );
}

TextStyle bottomtext() => TextStyle(fontWeight: FontWeight.w500);

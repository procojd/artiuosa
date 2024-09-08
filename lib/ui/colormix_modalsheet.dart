import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/controller/controller.dart';
import 'package:artiuosa/model/colormode.dart';
import 'package:artiuosa/model/savemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void showSavedColors(BuildContext context) async {
//   ColorScheme col = Theme.of(context).colorScheme;
//   final controller ac = Get.put(controller());
//   ac.loadColorModels();
//   // List<cm>? colorModels = await ac.getcm();
//   if (ac.colorModels.isNotEmpty) {
//     showModalBottomSheet(
//       scrollControlDisabledMaxHeightRatio: 0.7,
//       context: context,
//       builder: (BuildContext context) {
//         cm? selectedcm;

//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Container(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     height: 5,
//                     width: 70,
//                     decoration: BoxDecoration(
//                         color: col.outline,
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     'Saved Colors',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     physics: BouncingScrollPhysics(),
//                     child: Row(
//                       children: ac.colorModels.map((colorModel) {
//                         bool isSelected = selectedcm == colorModel;
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedcm = colorModel;
//                             });
//                           },
//                           child: AnimatedContainer(
//                             duration: Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                             margin: EdgeInsets.symmetric(horizontal: 5.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: isSelected
//                                   ? Border.all(color: col.outline, width: 3)
//                                   : null,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: CircleAvatar(
//                                   radius: 30,
//                                   backgroundColor: Color(int.parse(
//                                       '0xFF${colorModel.hex.substring(1)}')),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       gradient: RadialGradient(
//                                         colors: [
//                                           Color(int.parse(
//                                               '0xFF${colorModel.hex.substring(1)}')),
//                                           Colors.black,
//                                         ],
//                                         center: Alignment(
//                                             0.0, 0.2), // Center of the gradient
//                                         radius: 1.5, // Radius of the gradient
//                                         stops: [
//                                           0.30,
//                                           1.0
//                                         ], // Where the colors should stop
//                                       ),
//                                     ),
//                                   )),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     width: double.infinity, // Full width
//                     height: 2.0, // Height of the container
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors
//                               .transparent, // Starting color (fading from transparent)
//                           col.outline, // Middle color (dark)
//                           Colors
//                               .transparent, // Ending color (fading to transparent)
//                         ],
//                         stops: [0.0, 0.5, 1.0], // Positioning of the colors
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   selectedcm != null
//                       ? Expanded(
//                           child: FadeIn(
//                             child: ListView.builder(
//                               itemCount: selectedcm!.pencils.length,
//                               itemBuilder: (context, index) {
//                                 PrismacolorPencil pencil =
//                                     selectedcm!.pencils[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0),
//                                   child: ListTile(
                                    
//                                     title: Text(
//                                       pencil.name,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20),
//                                     ),
//                                     subtitle: Row(
//                                       children: [
//                                         Container(
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 color: col.secondaryContainer),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 4),
//                                               child: Text('${pencil.hex} '),
//                                             )),
//                                             SizedBox(width: 5,),
//                                         Container(
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 color: col.secondaryContainer),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 4),
//                                               child: Text(
//                                                   'R:${pencil.rgb[0]} G:${pencil.rgb[1]} B:${pencil.rgb[2]}'),
//                                             )),
//                                       ],
//                                     ),
//                                     trailing: Container(
//                                       height: 40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         gradient: RadialGradient(
//                                           colors: [
//                                             Color.fromRGBO(
//                                               pencil.rgb[0],
//                                               pencil.rgb[1],
//                                               pencil.rgb[2],
//                                               1.0,
//                                             ),
//                                             Colors.black,
//                                           ],
//                                           center: Alignment(0.0,
//                                               0.2), // Center of the gradient
//                                           radius: 1.5, // Radius of the gradient
//                                           stops: [
//                                             0.30,
//                                             1.0
//                                           ], // Where the colors should stop
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         )
//                       : Container(),
//                   selectedcm != null
//                       ? FilledButton.tonal(
//                           onPressed: () async {
//                             setState(() {
//                               // colorModels.remove(selectedcm);
//                               ac.colorModels.remove(selectedcm);
//                             });
//                             await ac.saveColorModels();
//                             setState(() {
//                               selectedcm = null;
//                             });
//                           },
//                           child: Text('Delete'),
//                         )
//                       : SizedBox()
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   } else {
//     // Show a message if there are no saved colors
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: double.infinity,
//           width: double.infinity,
//           padding: EdgeInsets.all(16.0),
//           child: FadeIn(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   'No Saved Colors',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text('You have not saved any colors yet.'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
void showSavedColors(BuildContext context) async {
  ColorScheme col = Theme.of(context).colorScheme;
  final controller ac = Get.put(controller());

  // Load color models and wait for it to complete
  await ac.loadColorModels();

  // Ensure state updates after loading color models
  if (ac.colorModels.isNotEmpty) {
    showModalBottomSheet(
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 0.7,
      context: context,
      builder: (BuildContext context) {
        cm? selectedcm;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Column(
                children: [
                  
                  Text(
                    'Saved Colors',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: ac.colorModels.map((colorModel) {
                        bool isSelected = selectedcm == colorModel;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedcm = colorModel;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: col.outline, width: 3)
                                  : null,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(int.parse(
                                    '0xFF${colorModel.hex.substring(1)}')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        Color(int.parse(
                                            '0xFF${colorModel.hex.substring(1)}')),
                                        Colors.black,
                                      ],
                                      center: Alignment(0.0, 0.2),
                                      radius: 1.5,
                                      stops: [0.30, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 2.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          col.outline,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  selectedcm != null
                      ? Expanded(
                          child: FadeIn(
                            child: ListView.builder(
                              itemCount: selectedcm!.pencils.length,
                              itemBuilder: (context, index) {
                                PrismacolorPencil pencil =
                                    selectedcm!.pencils[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: ListTile(
                                    title: Text(
                                      pencil.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: col.secondaryContainer),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            child: Text('${pencil.hex} '),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: col.secondaryContainer),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            child: Text(
                                                'R:${pencil.rgb[0]} G:${pencil.rgb[1]} B:${pencil.rgb[2]}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            Color.fromRGBO(
                                              pencil.rgb[0],
                                              pencil.rgb[1],
                                              pencil.rgb[2],
                                              1.0,
                                            ),
                                            Colors.black,
                                          ],
                                          center: Alignment(0.0, 0.2),
                                          radius: 1.5,
                                          stops: [0.30, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  selectedcm != null
                      ? FilledButton.tonal(
                          onPressed: () async {
                            setState(() {
                              ac.colorModels.remove(selectedcm);
                            });
                            await ac.saveColorModels();
                            setState(() {
                              selectedcm = null;
                            });
                          },
                          child: Text('Delete'),
                        )
                      : SizedBox(),
                      SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  } else {
    // Show a message if there are no saved colors
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: FadeIn(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'No Saved Colors',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('You have not saved any colors yet.'),
              ],
            ),
          ),
        );
      },
    );
  }
}

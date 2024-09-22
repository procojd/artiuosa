import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/controller/controller.dart';
import 'package:artiuosa/features/homescreen/homescreen.dart';
import 'package:artiuosa/features/screens/3dviewer.dart';
import 'package:artiuosa/features/screens/aboutme.dart';
import 'package:artiuosa/features/screens/colormix.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

controller cc = Get.put(controller());
Drawer newMethod(BuildContext context) {
  ColorScheme col = Theme.of(context).colorScheme;
  return Drawer(
    elevation: 0,
    child: Obx(() {
      return ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(),
            curve: Curves.easeInOutCubicEmphasized,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeInLeft(
                  curve: Curves.easeOutCubic,
                  child: Text(
                    'Artiuosa',
                    style: TextStyle(
                        color: col.onPrimaryContainer,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeInLeft(
                      curve: Curves.easeOutCubic,
                      delay: Durations.short4,
                      child: Text(
                        'Unleash your creativity',
                        style: TextStyle(
                            color: col.onPrimaryContainer,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    FadeInLeft(
                      curve: Curves.easeOutCubic,
                      delay: Durations.short4,
                      child: IconButton.filledTonal(
                        padding:EdgeInsets.zero,
                        onPressed: (){
                          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BallAnimationScreen()),
                  );
                        }, icon: Icon(Icons.person_rounded))
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: ListTile(
                horizontalTitleGap: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                leading: FadeIn(
                  delay: Durations.medium1,
                  child: const Icon(Icons.home_rounded)),
                title: FadeIn(
                  delay: Durations.medium1,
                  child: const Text('Home')),
                selected: cc.selectedindex.value == 0,
                selectedTileColor: col.surfaceVariant,
                selectedColor: col.onSurfaceVariant,
                onTap: () {
                  HapticFeedback.selectionClick();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  cc.onItemTap(0);
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: ListTile(
                horizontalTitleGap: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                leading: FadeIn(
                  delay: Durations.medium2,
                  child: const Icon(Icons.brush_rounded)),
                title: FadeIn(
                  delay: Durations.medium2,
                  child: const Text('Color Mix')),
                selected: cc.selectedindex.value == 1,
                selectedTileColor: col.surfaceVariant,
                selectedColor: col.onSurfaceVariant,
                onTap: () {
                  HapticFeedback.selectionClick();
                  cc.onItemTap(1);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ColorMixScreen()),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: ListTile(
                horizontalTitleGap: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                leading: FadeIn(
                  delay: Durations.medium3,
                  child: const Icon(Icons.view_in_ar_rounded)),
                title: FadeIn(
                  delay: Durations.medium3,
                  child: const Text('3D Model')),
                selected: cc.selectedindex.value == 2,
                selectedTileColor: col.surfaceVariant,
                selectedColor: col.onSurfaceVariant,
                onTap: () {
                  HapticFeedback.selectionClick();
                  cc.onItemTap(2);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Viewer3d()),
                  );
                }),
          ),
          
          
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          //   child: ListTile(
          //       horizontalTitleGap: 30,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30)),
          //       leading: Icon(Icons.view_in_ar_rounded),
          //       title: Text('3D model'),
          //       selected: cc.selectedindex.value == 3,
          //       selectedTileColor: col.surfaceVariant,
          //       selectedColor: col.onSurfaceVariant,
          //       onTap: () {
          //         cc.onItemTap(3);
          //         Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(builder: (context) => Viewer3d()),
          //         );
          //       }),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          //   child: ListTile(
          //       horizontalTitleGap: 30,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30)),
          //       leading: Icon(Icons.view_in_ar_rounded),
          //       title: Text('Mandala Grid'),
          //       selected: cc.selectedindex.value == 3,
          //       selectedTileColor: col.surfaceVariant,
          //       selectedColor: col.onSurfaceVariant,
          //       onTap: () {
          //         cc.onItemTap(3);
          //         Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(builder: (context) => MandalaHomePage()),
          //         );
          //       }),
          // ),
        ],
      );
    }),
  );
}

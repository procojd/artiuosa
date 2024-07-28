import 'package:artiuosa/controller.dart';
import 'package:artiuosa/features/screens/3dviewer.dart';
import 'package:artiuosa/features/screens/colormix.dart';
import 'package:artiuosa/features/homescreen/homescreen.dart';
import 'package:artiuosa/features/screens/experiment.dart';
import 'package:artiuosa/features/screens/mandala.dart';
import 'package:artiuosa/ui/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

controller cc = Get.put(controller());
Drawer newMethod(BuildContext context) {
  ColorScheme col = Theme.of(context).colorScheme;
  return Drawer(
    elevation: 0,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          
          decoration: BoxDecoration(
            
          ),
          curve: Curves.easeInOutCubicEmphasized,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Artiuosa',
                style: TextStyle(
                  
                    color: col.onPrimaryContainer, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Unleash your creativity',
                style: TextStyle(
                    color: col.onPrimaryContainer, fontWeight: FontWeight.normal),
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
              leading: Icon(Icons.home_rounded),
              title: Text('Home'),
              selected: cc.selectedindex.value == 0,
              selectedTileColor: col.surfaceVariant,
              selectedColor: col.onSurfaceVariant,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => home_screen()),
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
              leading: Icon(Icons.brush_rounded),
              title: Text('Color Mix'),
              selected: cc.selectedindex.value == 1,
              selectedTileColor: col.surfaceVariant,
              selectedColor: col.onSurfaceVariant,
              onTap: () {
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
              leading: Icon(Icons.image_rounded),
              title: Text('References'),
              selected: cc.selectedindex.value == 2,
              selectedTileColor: col.surfaceVariant,
              selectedColor: col.onSurfaceVariant,
              onTap: () {
                cc.onItemTap(2);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => crop()),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: ListTile(
              horizontalTitleGap: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              leading: Icon(Icons.view_in_ar_rounded),
              title: Text('3D model'),
              selected: cc.selectedindex.value == 3,
              selectedTileColor: col.surfaceVariant,
              selectedColor: col.onSurfaceVariant,
              onTap: () {
                cc.onItemTap(3);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Viewer3d()),
                );
              }),
        ),
      ],
    ),
  );
}

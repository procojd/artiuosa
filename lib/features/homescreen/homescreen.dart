import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/controller/controller.dart';
import 'package:artiuosa/ui/drawer.dart';
import 'package:artiuosa/ui/grid_modalsheet.dart';
import 'package:artiuosa/logic/gridpainter.dart';
import 'package:artiuosa/logic/papersize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  controller ac = Get.put(controller());
  final GlobalKey _globalKey = GlobalKey();

  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    ac.loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    ColorScheme col = Theme.of(context).colorScheme;
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: ClipRRect(
          child: newMethod(context),
        ),
        appBar: AppBar(
          surfaceTintColor: col.background,
          centerTitle: true,
          actions: [
            ac.selectedFile.value != null
                ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: _pickImage, icon: Icon(Icons.add))
                : SizedBox(),
            IconButton(padding: EdgeInsets.zero,
                onPressed: () {
                  bot_sheet(context, _globalKey);
                },
                icon: Icon(Icons.more_vert_rounded)),
            IconButton(padding: EdgeInsets.zero,
                onPressed: () {
                  ac.labels.value = !ac.labels.value;
                  ac.storeLabels(ac.labels.value);
                },
                icon: ac.labels.value
                    ? Icon(Icons.label)
                    : Icon(Icons.label_off_rounded))
          ],
          title: Text('Artiuosa'),
        ),
        body: Obx(() {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ac.selectedFile.value == null
                      ? Text(
                          'No image selected.',
                          style: TextStyle(color: col.onBackground, fontSize: 16),
                        )
                      : LayoutBuilder(builder: (context, constraints) {
                        return InteractiveViewer(
                          minScale: 0.1,
                          maxScale: 10.0,
                          child: Container(
                            width: width,
                            height: height*0.9,
                            
                            child: Center(
                              child: RepaintBoundary(
                                key: _globalKey,
                                child: Stack(
                                  children: [
                                    Obx(() {
                                      return FadeIn(
                                          child: Image.file(
                                        ac.filteredFile.value!,
                                        fit: BoxFit.fitWidth,
                                      ));
                                    }),
                                    Obx(() {
                                      return FadeIn(
                                        delay: Durations.medium1,
                                        child: CustomPaint(
                                          painter: GridPainter(
                                            imageWidth:
                                                (ac.imagewidth.value! *
                                                        height *
                                                        0.9) /
                                                    ac.imageheight.value!,
                                            imageHeight:
                                                (ac.imageheight.value! *
                                                        width) /
                                                    ac.imagewidth.value!,
                                            scale: ac.bottomsheet.value,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.003,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  ac.selectedFile.value == null
                      ? SizedBox(height: 20)
                      : SizedBox(),
                  ac.selectedFile.value == null
                      ? FilledButton(
                          onPressed: _pickImage,
                          child: Text('Browse Image'),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      _showPaperSizeBottomSheet(imageFile);
    }
  }

  void _showPaperSizeBottomSheet(File imageFile) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true, // To allow full height and avoid clipping
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: PaperSizeSelection(
            onPaperSizeSelected: (String paperSize, String orientation) {
              _cropImage(imageFile, paperSize, orientation, context);
            },
          ),
        );
      },
    );
  }

  Future<void> _cropImage(File imageFile, String paperSize, String orientation,
      BuildContext context) async {
    ColorScheme col = Theme.of(context).colorScheme;
    final cropAspectRatio = ac.getCropAspectRatio(paperSize, orientation);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: cropAspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          activeControlsWidgetColor: col.primaryContainer,
          backgroundColor: col.surface,
          dimmedLayerColor: col.background,
          toolbarColor: col.background,
          hideBottomControls: true,
          cropFrameColor: col.primaryContainer,
          showCropGrid: true,
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
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      final croppedImageFile = File(croppedFile.path);
      ac.selectedFile.value = croppedImageFile;
      ac.filteredFile.value = croppedImageFile;
      setState(() {});
      _setImageWithSize(croppedImageFile);
    }
  }

  Future<void> _setImageWithSize(File imageFile) async {
    final imageSize = await _getImageSize(imageFile);

    // Update observable variables and shared preferences
    // Saving the same file in filteredFile as well

    ac.imagewidth.value = imageSize.width;
    ac.imageheight.value = imageSize.height;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (ac.selectedFile.value != null) {
      prefs.setString('selectedFile', ac.selectedFile.value!.path);
    }
    if (ac.filteredFile.value != null) {
      prefs.setString('filteredFile', ac.filteredFile.value!.path);
    }
    await prefs.setDouble('imageWidth', imageSize.width);
    await prefs.setDouble('imageHeight', imageSize.height);
  }

  Future<ui.Size> _getImageSize(File imageFile) async {
    final completer = Completer<ui.Size>();
    final image = Image.file(imageFile);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(
            ui.Size(info.image.width.toDouble(), info.image.height.toDouble()));
      }),
    );

    return completer.future;
  }
}

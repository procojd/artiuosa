import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
class GridSaver {
  // final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> saveImageWithGrid(GlobalKey key) async {
    // Request permission to access photos/media
    if (true) {
      try {
        // Capture the widget as an image
        final RenderRepaintBoundary boundary =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        final ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List pngBytes = byteData!.buffer.asUint8List();

        // Save the image to the gallery
        final result = await ImageGallerySaver.saveImage(pngBytes,
            quality: 100, name: "image_with_grid");
        print(result);
      } catch (e) {
        print("Error saving image: $e");
      }
      // } else {
      //   // Handle permission denial
      //   print("Permission denied");
      // }
    }
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image/image.dart' as img;
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FilterPage extends StatefulWidget {
//   final File image;
//   final Function(File) onFilterApplied;

//   const FilterPage({Key? key, required this.image, required this.onFilterApplied}) : super(key: key);

//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   File? _filteredImage;
//   File? _originalImage;
//   final List<String> _filters = ['None', 'Grayscale', 'Sepia', 'Invert'];
//   String _selectedFilter = 'None';

//   @override
//   void initState() {
//     super.initState();
//     _originalImage = widget.image;
//     _filteredImage = widget.image;
//     _applyFilter(_selectedFilter);
//   }

//   Future<void> _applyFilter(String filter) async {
//     // Ensure that the original image is not null
//     if (_originalImage == null) return;

//     // Decode the original image
//     final img.Image originalImage = img.decodeImage(_originalImage!.readAsBytesSync())!;
//     img.Image filteredImage;

//     // Apply the selected filter
//     switch (filter) {
//       case 'Grayscale':
//         filteredImage = img.grayscale(originalImage);
//         break;
//       case 'Sepia':
//         filteredImage = img.sepia(originalImage);
//         break;
//       case 'Invert':
//         filteredImage = img.invert(originalImage);
//         break;
//       default:
//         filteredImage = originalImage;
//     }

//     // Save the filtered image to the app's documents directory
//     final directory = await getApplicationDocumentsDirectory();
//     final filteredImagePath = '${directory.path}/filtered_image.png';
//     final file = File(filteredImagePath);

//     // Check if the file exists and write the image data
//     if (await file.exists()) {
//       await file.delete();
//     }
//     await file.writeAsBytes(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = file;
//     });

//     // Notify the parent widget that the filter has been applied
//     widget.onFilterApplied(_filteredImage!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Apply Filters'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: _filteredImage != null
//                   ? Image.file(_filteredImage!)
//                   : CircularProgressIndicator(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: _filters.map((filter) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _selectedFilter = filter;
//                         _applyFilter(filter);
//                       });
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 10),
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: filter == _selectedFilter ? Colors.blue : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         filter,
//                         style: TextStyle(
//                           color: filter == _selectedFilter ? Colors.white : Colors.black,
//                           fontWeight: filter == _selectedFilter ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (_filteredImage != null) {
//                   SharedPreferences prefs = await SharedPreferences.getInstance();
//                   await prefs.setString('filtered_image_path', _filteredImage!.path);
//                   Get.back();
//                 }
//               },
//               child: Text('Apply Filter'),
//               style: ElevatedButton.styleFrom(

//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:artiuosa/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

@immutable
class ExampleImageFilterSelection extends StatefulWidget {
  const ExampleImageFilterSelection({super.key});

  @override
  State<ExampleImageFilterSelection> createState() =>
      _ExampleImageFilterSelectionState();
}

class _ExampleImageFilterSelectionState
    extends State<ExampleImageFilterSelection>
    with SingleTickerProviderStateMixin {
  final _filters = [
    'None',
    'Negative',
    'Monochrome',
    'Sepia',
    'Contrast',
    'Outline',
    'Pixel',
  ];

  final _filterMode = ValueNotifier<String>('None');
  final controller ac = Get.put(controller());
  bool isloading = false;

  void _onFilterChanged(String filter) {
    _filterMode.value = filter;
  }

  Future<void> _saveFilteredImage() async {
    setState(() {
      isloading = true;
    });

    try {
      // Decode the original image from the selected file
      final originalImage =
          img.decodeImage(ac.selectedFile.value!.readAsBytesSync())!;

      // Apply the filter to the image
      final filteredImage = _applyImageFilter(originalImage, _filterMode.value);
      print(_filterMode.value);

      // Get the application documents directory
      // final directory = await getApplicationDocumentsDirectory();
      var directory1;
      {
        directory1 = "/storage/emulated/0/Download/";

        var dirDownloadExists = await Directory(directory1).exists();
        if (dirDownloadExists) {
          directory1 = "/storage/emulated/0/Download/";
        } else {
          directory1 = "/storage/emulated/0/Downloads/";
        }
      }

      // Define the path for the filtered image
      final filteredImagePath =
          '${directory1}filtered_image_${_filterMode.value}.png';

      // Create a File object for the filtered image
      final filteredFile = File(filteredImagePath);

      // Save the filtered image as a PNG file
      await filteredFile.writeAsBytes(img.encodePng(filteredImage));

      // Update the observable variable with the new filtered image file
      print('jaknfnadnf,aa');
      ac.selectedFile.value = filteredFile;
      isloading = false;

      // Show a success message
      await Future.delayed(const Duration(milliseconds: 1500));

      Navigator.pop(context);
    } catch (e) {
      // Handle any errors
      Get.snackbar('Error', 'Failed to save filtered image: $e');
    }
  }

  img.Image _applyImageFilter(img.Image originalImage, String filter) {
    switch (filter) {
      case 'Negative':
        return img.invert(originalImage);
      case 'Monochrome':
        return img.grayscale(originalImage);
      case 'Sepia':
        return img.sepia(originalImage);
      case 'Contrast':
        return img.adjustColor(originalImage, contrast: 2);
      case 'Outline':
        return img.emboss(originalImage);
      case 'Pixel':
        return img.pixelate(originalImage, size: 10);
      default:
        return originalImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildPhotoWithFilter(),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
          Positioned(
            right: 20,
            top: 60,
            child: IconButton.filledTonal(
              onPressed: _saveFilteredImage,
              icon: Icon(Icons.done),
            ),
          ),
          isloading
              ? Container(
                  height: height,
                  width: width,
                  color: col.background.withOpacity(0.5),
                )
              : Center(child: SizedBox.shrink()),
          isloading
              ? Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: col.onBackground,
                  backgroundColor: col.background.withOpacity(0.5),
                ))
              : Center(child: SizedBox.shrink())
        ],
      ),
    );
  }

 Widget _buildPhotoWithFilter() {
  return ValueListenableBuilder(
    valueListenable: _filterMode,
    builder: (context, filter, child) {
      return ColorFiltered(
        colorFilter: _getColorFilter(filter),
        child: Image.file(
          ac.selectedFile.value!,
          fit: BoxFit.fitWidth,
          filterQuality: FilterQuality.high,
        ),
      );
    },
  );
}
  ColorFilter _getColorFilter(String filter) {
    switch (filter) {
      case 'Negative':
        return const ColorFilter.matrix([
          -1,
          0,
          0,
          0,
          255,
          0,
          -1,
          0,
          0,
          255,
          0,
          0,
          -1,
          0,
          255,
          0,
          0,
          0,
          1,
          0,
        ]);
      case 'Monochrome':
        return const ColorFilter.mode(
          Colors.grey,
          BlendMode.saturation,
        );
      case 'Sepia':
        return const ColorFilter.matrix([
          0.393,
          0.769,
          0.189,
          0,
          0,
          0.349,
          0.686,
          0.168,
          0,
          0,
          0.272,
          0.534,
          0.131,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]);
      case 'Contrast':
        return const ColorFilter.matrix([
          1.5,
          0,
          0,
          0,
          0,
          0,
          1.5,
          0,
          0,
          0,
          0,
          0,
          1.5,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]);
      case 'Outline':
        return const ColorFilter.matrix([
          0,
          -1,
          0,
          0,
          255,
          -1,
          0,
          0,
          0,
          255,
          0,
          0,
          -1,
          0,
          255,
          0,
          0,
          0,
          1,
          0,
        ]);
      case 'Pixel':
        return const ColorFilter.matrix([
          1,
          0,
          0,
          0,
          0,
          0,
          0.5,
          0,
          0,
          0,
          0,
          0,
          1.5,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]);
      default:
        return const ColorFilter.mode(
          Colors.transparent,
          BlendMode.color,
        );
    }
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}

@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  });

  final List<String> filters;
  final void Function(String selectedFilter) onFilterChanged;
  final EdgeInsets padding;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;
  late int _page;

  int get filterCount => widget.filters.length;

  String itemFilter(int index) => widget.filters[index % filterCount];

  @override
  void initState() {
    super.initState();
    _page = 0;
    _controller = PageController(
      initialPage: _page,
      viewportFraction: _viewportFractionPerItem,
    );
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = (_controller.page ?? 0).round();
    if (page != _page) {
      _page = page;
      widget.onFilterChanged(widget.filters[page]);
    }
  }

  void _onFilterTapped(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;

    return Scrollable(
      controller: _controller,
      axisDirection: AxisDirection.right,
      physics: const PageScrollPhysics(),
      viewportBuilder: (context, viewportOffset) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final itemSize = constraints.maxWidth * _viewportFractionPerItem;
            viewportOffset
              ..applyViewportDimension(constraints.maxWidth)
              ..applyContentDimensions(0.0, itemSize * (filterCount - 1));

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // _buildShadowGradient(itemSize),
                _buildCarousel(
                  viewportOffset: viewportOffset,
                  itemSize: itemSize,
                ),
                _buildSelectionRing(itemSize, col.outline),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCarousel({
    required ViewportOffset viewportOffset,
    required double itemSize,
  }) {
    return Container(
      height: itemSize,
      margin: widget.padding,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Flow(
        delegate: CarouselFlowDelegate(
          viewportOffset: viewportOffset,
          filtersPerScreen: _filtersPerScreen,
        ),
        children: [
          for (int i = 0; i < filterCount; i++)
            FilterItem(
              onFilterSelected: () => _onFilterTapped(i),
              filter: itemFilter(i),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionRing(double itemSize, Color col) {
    return IgnorePointer(
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              border: Border.fromBorderSide(
                BorderSide(width: 4, color: col),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.filter,
    this.onFilterSelected,
  });

  final String filter;

  final VoidCallback? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 180, 196, 224),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Center(
              child: Text(
                filter,
                style: TextStyle(
                    fontSize: 12.0, color: Color.fromARGB(255, 4, 38, 97)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselFlowDelegate extends FlowDelegate {
  CarouselFlowDelegate({
    required this.viewportOffset,
    required this.filtersPerScreen,
  }) : super(repaint: viewportOffset);

  final ViewportOffset viewportOffset;
  final int filtersPerScreen;

  @override
  void paintChildren(FlowPaintingContext context) {
    final count = context.childCount;

    final size = context.size.width;

    final itemExtent = size / filtersPerScreen;

    final active = viewportOffset.pixels / itemExtent;
    final min = (active.floor() - 3 < 0) ? 0 : active.floor() - 3;
    final max = (active.ceil() + 3 > count - 1) ? count - 1 : active.ceil() + 3;

    for (var index = min; index <= max; index++) {
      final itemXFromCenter = itemExtent * index - viewportOffset.pixels;
      final percentFromCenter = 1.0 - (itemXFromCenter / (size / 2)).abs();
      final itemScale = 0.5 + (percentFromCenter * 0.5);
      final opacity = 0.25 + (percentFromCenter * 0.75);

      final itemTransform = Matrix4.identity()
        ..translate((size - itemExtent) / 2)
        ..translate(itemXFromCenter)
        ..translate(itemExtent / 2, itemExtent / 2)
        ..multiply(Matrix4.diagonal3Values(itemScale, itemScale, 1.0))
        ..translate(-itemExtent / 2, -itemExtent / 2);

      context.paintChild(
        index,
        transform: itemTransform,
        opacity: opacity,
      );
    }
  }

  @override
  bool shouldRepaint(CarouselFlowDelegate oldDelegate) {
    return oldDelegate.viewportOffset != viewportOffset;
  }
}

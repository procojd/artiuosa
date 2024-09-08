import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/controller/controller.dart';
import 'package:artiuosa/features/homescreen/homescreen.dart';
import 'package:artiuosa/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  controller ac = Get.put(controller());
  @override
  void initState() {
    super.initState();
    ac.onboarding();

    // Navigate to the next page after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>ac.onboarding_done.value? HomeScreen():OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 253, 254),
      body: Center(
        child: ZoomIn(
            child: FadeIn(
                child: Image.asset(
          'assets/images/artiuosa_s.png',
          scale: 5,
        ))),
      ),
    );
  }
}

// class TextReveal extends StatefulWidget {
//   @override
//   _TextRevealState createState() => _TextRevealState();
// }

// class _TextRevealState extends State<TextReveal>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     )..forward();

//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return ClipRect(
//           child: Align(
//             alignment: Alignment.centerLeft,
//             widthFactor: _animation.value,
//             child: child,
//           ),
//         );
//       },
//       child: FadeIn(
//         child: Text(
//           'Artiuosa',
//           style: TextStyle(
//               fontSize: 30.0, color: Colors.white, fontFamily: 'cursive'),
//         ),
//       ),
//     );
//   }
// }

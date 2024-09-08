import 'package:animate_do/animate_do.dart';
import 'package:artiuosa/controller/controller.dart';
import 'package:artiuosa/features/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    controller ac = Get.put(controller());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 40), // Add spacing to match the design
            Center(
              child: FadeIn(
                delay: Durations.medium1,
                child: Image.asset(
                  'assets/images/download.png', // Replace with your actual image asset
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing between image and text
            FadeIn(
              delay: Durations.medium2,
              child: Text(
                "Hey creatives",
                style: TextStyle(
                    fontSize: 35,
                    letterSpacing: -1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            // Spacing between text elements
            FadeIn(
              delay: Durations.medium3,
              child: Text(
                "Unleash your creativity with Artiuosa, \nthe ultimate tool for artists.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20), // Spacing before the bold text
            FadeIn(
              delay: Durations.medium4,
              child: Text(
                "Enhance,\nOrganize",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: const Color.fromARGB(
                      255, 0, 50, 136), // Change to your desired color
                ),
              ),
            ),
            FadeIn(
              delay: Durations.medium4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "and ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(
                          255, 0, 50, 136), // Change to your desired color
                    ),
                  ),
                  Text(
                    "Create.",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(
                          255, 0, 50, 136), // Change to your desired color
                    ),
                  ),
                ],
              ),
            ),
            Spacer(), // Pushes the button to the bottom
            Center(
              child: SlideInUp(
                curve: Curves.easeInCubic,
                delay: Durations.long1,
                child: ElevatedButton(
                  onPressed: () {
                    ac.setonboarding();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    disabledBackgroundColor:
                        const Color.fromARGB(255, 0, 50, 136),
                    backgroundColor: const Color.fromARGB(255, 0, 50, 136),
                  ),
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class BallAnimationScreen extends StatefulWidget {
  @override
  _BallAnimationScreenState createState() => _BallAnimationScreenState();
}

class _BallAnimationScreenState extends State<BallAnimationScreen> {
  // Variables to control ball position
  double _top = 0;
  double _left = 0;

  // Dimensions of the ball
  final double _ballSize = 200.0;

  // Animation direction control
  bool _movingRight = true;
  bool _movingDown = true;

  // Animation duration
  final Duration _duration = Duration(seconds: 10);
  final ScrollController _scrollController = ScrollController();
  // final double _scrollSpeed = 50;

  // Timer to control animation
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    // Start the animation after didChangeDependencies is called
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Start the first animation
    _animateBall();

    // Set up the timer to continue the animation
    _timer = Timer.periodic(_duration, (timer) {
      _animateBall();
    });
  }

  void _animateBall() {
    // Ensure that the widget is still mounted
    if (mounted) {
      setState(() {
        // Access screen size using MediaQuery inside this method
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Toggle direction on hitting horizontal edges
        if (_movingRight) {
          _left = screenWidth - _ballSize;
        } else {
          _left = 0;
        }
        _movingRight = !_movingRight;

        // Toggle direction on hitting vertical edges
        if (_movingDown) {
          _top = screenHeight - _ballSize;
        } else {
          _top = 0;
        }
        _movingDown = !_movingDown;
      });
    }
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        // Scroll by a small amount periodically
        _scrollController.jumpTo(_scrollController.offset + 1);
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer to prevent calling setState after widget is disposed
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme col = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // Ball Animation
          AnimatedPositioned(
            duration: _duration,
            top: _top,
            left: _left,
            child: Container(
              width: _ballSize,
              height: _ballSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 99, 99, 233), // Slightly transparent
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
            child: Container(),
          ),
          // Text in Front
          FadeInUp(
            delay: Durations.medium1,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.1, 0.8, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          
                          child: Text(
                            "About me",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
            
                          child: Text(
                            "Hi, I'm Jatin, a 22-year-old passionate software engineer with a flair for creative and technical problem-solving. With extensive experience in Flutter and app development, I've worked on diverse projects from photo-editing apps with advanced features like grid manipulation and filters, to team management solutions and boutique management tools. My expertise spans across state management with GetX, API integrations, and building smooth, user-friendly interfaces.\n\nIn addition to coding, I'm an artist specializing in realistic and creative art, always exploring new techniques like mandala creation and shading in my free time. I also love creating content, especially beginner tutorials for drawing in Hindi, and I'm currently launching my own app, 'artiuosa,' focused on art and creativity.\n\nBeyond tech and art, I enjoy playing the guitar, cooking, and challenging myself in chess. I'm always keen to learn, adapt, and push the boundaries of what I can create—whether it's through code or canvas.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 1.0,
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
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "A huge thank you to everyone who has contributed to and supported me on my app journey. Your feedback, encouragement, and belief in my work have been invaluable in bringing my ideas to life. I truly appreciate all the support, and I’m excited to continue growing and creating with you all by my side.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Special thanks to",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 40),
                        
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Yuvraj ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                        divider(col),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Khushi Baranwal",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                        divider(col),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Aayushi Singh",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                        divider(col),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Meenakshi Singh",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                        divider(col),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Purvi",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 40),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Back button to pop the screen
          Positioned(
            top: 40,
            left: 10,
            child: IconButton.filledTonal(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Container divider(ColorScheme col) {
    return Container(
                      width: double.infinity,
                      height: 1.0,
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
                    );
  }
}

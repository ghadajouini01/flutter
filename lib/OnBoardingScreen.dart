import 'package:clone_jumia/SignUp.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Your first onboarding screen
import 'splash_screen2.dart'; // Your second onboarding screen
import 'splash_screen3.dart'; // Your third onboarding screen
import 'package:clone_jumia/SignUp.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int page = _pageController.page?.round() ?? 0;
      if (page != currentPage) {
        setState(() {
          currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView to manage the onboarding screens
          PageView(
            controller: _pageController,
            children: [
              SplashScreen(), // First onboarding screen
              SplashScreen2(), // Second onboarding screen
              SplashScreen3(), // Third onboarding screen
            ],
          ),

          // Skip button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(), // Main screen
                  ),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 188, 57),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          // Prev button
          if (currentPage > 0)
            Positioned(
              bottom: 30,
              left: 20,
              child: ElevatedButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor:
                      Color.fromARGB(255, 27, 188, 57), // Button color
                ),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

          // Next/Start button
          Positioned(
            bottom: 30,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (currentPage == 2) {
                  // Navigate to the main page after the last onboarding screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor:
                    Color.fromARGB(255, 27, 188, 57), // Button color
              ),
              child: Icon(
                currentPage == 2 ? Icons.check : Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),

          // Page indicator dots
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Number of onboarding screens
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: currentPage == index ? 20 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? Color.fromARGB(255, 27, 188, 57)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

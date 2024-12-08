import 'package:clone_jumia/Login.dart';
import 'package:clone_jumia/OnBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:clone_jumia/splash_screen.dart'; // Correct import
import 'package:clone_jumia/splash_screen2.dart';
import 'package:clone_jumia/splash_screen3.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(height: screenHeight * 0.15), // Adjusted space

            // Centered logo and text
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container for floating effect with larger size
                Container(
                  width: screenWidth * 0.4, // Adjust size as needed
                  height: screenWidth * 0.4, // Keep it circular
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/welcome.png', // Your image asset
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),

                // "Shoppe" text
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Shoppe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: screenWidth * 0.14,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.52,
                  ),
                ),

                // Description text
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Text(
                    'Shop From Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF202020),
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w300,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),

            // Buttons section
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.05),
              child: Column(
                children: [
                  // "Let's get started" button
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.075,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 27, 188, 57),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OnboardingScreen()), // Use the correct SplashScreen
                        );
                      },
                      child: Text(
                        "Let's get started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF3F3F3),
                          fontSize: screenWidth * 0.06,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),

                  // "I already have an account" + Arrow button
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      // Handle "I already have an account" button tap, navigate to next page
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I already have an account',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Login()), // Replace NextScreen with your destination widget
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

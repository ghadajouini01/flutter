import 'package:flutter/material.dart';
import 'package:clone_jumia/splash_screen2.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: screenWidth * 0.95, // 95% of screen width
            height: screenHeight * 0.95, // 95% of screen height
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                /* Positioned(
                  right: 20,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      // Implement skip action
                    },
                    child: SizedBox(
                      width: 40,
                      height: 22,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF6B778D),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),*/
                Positioned(
                  left: 20,
                  bottom: 120,
                  child: Container(
                    width: screenWidth * 0.9, // Adjusted for responsiveness
                    child: Column(
                      children: [
                        Text(
                          'Shop Online Products',
                          style: TextStyle(
                            color: Color(0xFF17223B),
                            fontSize: 24,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Explore a wide range of products at unbeatable prices, all at your fingetips ! shop anytime, anywhere!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x99263859),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: (screenWidth - 437) / 2, // Center horizontally
                  top: 150,
                  child: Container(
                    width: 437,
                    height: 436,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/splash.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:clone_jumia/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:clone_jumia/splash_screen3.dart';

class SplashScreen2 extends StatelessWidget {
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
                // Text section with title and description
                Positioned(
                  left: screenWidth *
                      0.09, // Left position relative to screen width
                  top: screenHeight *
                      0.7, // Top position relative to screen height
                  child: Container(
                    width: screenWidth * 0.82, // Adjusted for responsiveness
                    child: Column(
                      children: [
                        Text(
                          'Fastest Delivery',
                          style: TextStyle(
                            color: Color(0xFF17223B),
                            fontSize: screenWidth *
                                0.06, // Font size relative to screen width
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Order today, receive it tomorrow—shopping has never been this quick!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x99263859),
                            fontSize: screenWidth *
                                0.035, // Font size relative to screen width
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.5, // Line height
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Navigation buttons (Next and Prev)
                /* Positioned(
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.02,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SplashScreen3()), // Use the correct SplashScreen
                      );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFFFF6768),
                        fontSize: screenWidth *
                            0.045, // Font size relative to screen width
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.05,
                  bottom: screenHeight * 0.02,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                      );
                    },
                    child: Text(
                      'Prev',
                      style: TextStyle(
                        color: Color(0xFFFF6768),
                        fontSize: screenWidth *
                            0.045, // Font size relative to screen width
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Indicator bar
                Positioned(
                  left: (screenWidth - (screenWidth * 0.2)) /
                      2, // Center horizontally
                  bottom: screenHeight * 0.03,
                  child: Container(
                    width: screenWidth * 0.2, // Adjusted for responsiveness
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth *
                              0.03, // Dot size relative to screen width
                          height: screenWidth * 0.03,
                          decoration: BoxDecoration(
                            color: Color(0x3317223B),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.12,
                          height: screenWidth * 0.02,
                          decoration: BoxDecoration(
                            color: Color(0xFF17223B),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.03,
                          height: screenWidth * 0.03,
                          decoration: BoxDecoration(
                            color: Color(0x3317223B),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                // Image
                Positioned(
                  left: screenWidth * 0.02,
                  top: screenHeight * 0.15,
                  child: Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.48, // Adjusted for responsiveness
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/splash2.png"), // Update to use asset
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

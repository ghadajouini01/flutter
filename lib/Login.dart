import 'package:clone_jumia/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:clone_jumia/welcomePage.dart'; // Ensure this path is correct
import 'package:clone_jumia/ForgotPassword.dart'; // Ensure this path is correct
import 'package:clone_jumia/ProfilePage.dart';

class Login extends StatelessWidget {
  // Controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            color: Colors.white, // Solid background color
          ),
          child: Stack(
            children: [
              // Bubble1 image
              Positioned(
                left: -screenWidth * 0.4,
                top: -screenHeight * 0.15,
                child: Image.asset(
                  'assets/bubble1.png',
                  width: screenWidth * 1.1,
                  height: screenHeight * 0.5,
                ),
              ),

              // Bubble2 image
              Positioned(
                right: -screenWidth * 0.35,
                bottom: -screenHeight * 0.05,
                child: Image.asset(
                  'assets/bubble2.png',
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.3,
                ),
              ),

              // Login Text
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.3,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: screenHeight * 0.07,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),

              // Subtitle Text
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.4,
                child: Text(
                  'Good to see you back!',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: screenHeight * 0.025,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),

              // Email TextField
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.5,
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Color(0xFFD2D2D2),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
              ),

              // Password TextField
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.58,
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true, // To hide the password input
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Color(0xFFD2D2D2),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
              ),

              // Done Button
              Positioned(
                left: screenWidth * 0.35,
                top: screenHeight * 0.68, // Adjusted for the new layout
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final userId = await _authService.signIn(
                        emailController.text,
                        passwordController.text,
                      );
                      print(userId);

                      // If sign-in succeeds, navigate to the profile page with userId
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(userId: userId),
                        ),
                      );
                    } catch (e) {
                      print(e); // If sign-in fails, show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Sign-in failed. Please try again.$e')),
                      );
                    }
                  },
                  child: Text('Sign In'),
                ),
              ),

              // Forgot Password? Button
              Positioned(
                left: screenWidth * 0.33,
                top: screenHeight * 0.76,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenHeight * 0.02,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:clone_jumia/Login.dart';
import 'package:flutter/material.dart';
import 'package:clone_jumia/services/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? selectedOption;
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword() async {
    if (_emailController.text.isEmpty) {
      _showSnackBar('Please enter your email address.');
      return;
    }

    try {
      await _authService.forgetPassword(_emailController.text);
      _showSnackBar('Password reset email sent! Please check your inbox.');
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height: screenHeight * 1.15,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title Text
                  Text(
                    'Password Recovery',
                    style: TextStyle(
                      color: Color(0xFF202020),
                      fontSize: screenHeight * 0.03,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Email Input Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Instruction Text
                  Text(
                    'How would you like to restore your password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenHeight * 0.02,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Reset Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 27, 188, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.35,
                        vertical: screenHeight * 0.01,
                      ),
                    ),
                    onPressed: _resetPassword,
                    child: Text(
                      'Send ',
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Cancel Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bubble image at the top-right corner
          Positioned(
            left: -screenWidth * 0.4,
            top: -screenHeight * 0.2,
            child: Image.asset(
              'assets/bubble3.png',
              width: screenWidth * 2.6,
              height: screenHeight * 0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

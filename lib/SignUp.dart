import 'package:clone_jumia/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:clone_jumia/services/auth_service.dart';
import 'package:clone_jumia/models/user.dart';
import 'package:clone_jumia/services/api_response.dart';
import 'package:clone_jumia/welcomePage.dart';
import 'package:clone_jumia/Login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  void _onCancel() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  void _onDone() async {
    setState(() {
      isLoading = true;
    });

    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String phone = phoneController.text.trim();

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        phone.isNotEmpty) {
      try {
        // Attempt registration
        Map<String, dynamic> response = (await _authService.register(
                firstName, lastName, email, password, phone))
            as Map<String, dynamic>;

        setState(() {
          isLoading = false;
        });

        // Verify if response indicates success
        if (response['success'] == true) {
          _userService.createUser(
              response['uid'], firstName, lastName, email, phone);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else {
          // Display an error message if registration failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(response['message'] ?? "Registration failed")),
          );
        }
      } catch (e, stackTrace) {
        // Stop loading and handle any exception that occurs
        setState(() {
          isLoading = false;
        });
        // Log the exception details for debugging
        print("Exception occurred: $e");
        print("Stack trace: $stackTrace");

        // Display an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    } else {
      // Stop loading if fields are empty
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create \nAccount',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: screenHeight * 0.05,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.50,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Column(
                children: [
                  buildTextField(firstNameController, 'First Name'),
                  SizedBox(height: 15),
                  buildTextField(lastNameController, 'Last Name'),
                  SizedBox(height: 15),
                  buildTextField(emailController, 'Email'),
                  SizedBox(height: 15),
                  buildTextField(passwordController, 'Password'),
                  SizedBox(height: 15),
                  buildTextField(phoneController, 'Your number'),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                width: screenWidth * 0.90,
                height: 61,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 27, 188, 57),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                  onPressed: isLoading ? null : _onDone,
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Color(0xFFF3F3F3),
                              fontSize: 22,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextButton(
                onPressed: _onCancel,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: 18,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19.76, vertical: 10.81),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            color: Color(0xFFD2D2D2),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

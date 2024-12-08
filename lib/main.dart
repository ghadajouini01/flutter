import 'package:clone_jumia/ForgotPassword.dart';
import 'package:clone_jumia/Login.dart';
import 'package:clone_jumia/OnBoardingScreen.dart';
import 'package:clone_jumia/SignUp.dart';
import 'package:clone_jumia/splash_screen2.dart';
import 'package:clone_jumia/splash_screen3.dart';
import 'package:flutter/material.dart';
import 'package:clone_jumia/welcomePage.dart';
import 'package:clone_jumia/splash_screen.dart'; // Import your SplashScreen here

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(), // Home page
        '/splash': (context) => OnboardingScreen(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => Login(),
        '/forgotpass': (context) => ForgotPassword(),

        // Splash screen route
      },
    );
  }
}

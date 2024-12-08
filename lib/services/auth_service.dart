import "package:http/http.dart" as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:3000/auth';

  Future<String> signIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/signIn');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['uid']; // Return the user ID
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<Map<String, dynamic>> signUp(
      String email, String password, String phone) async {
    final url = Uri.parse('$baseUrl/signUp');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Successful response
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> forgetPassword(String email) async {
    final url = Uri.parse('$baseUrl/forgetPassword');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  }

  Future<String> register(String email, String password, String firstName,
      String lastName, String phone) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['uid']; // Return the user ID
    } else {
      throw Exception('Failed to sign in');
    }
  }
}

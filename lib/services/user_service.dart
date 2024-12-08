import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final String baseUrl = 'http://10.0.2.2:3000/user';

  // Create a new user
  Future<Map<String, dynamic>> createUser(String uid, firstName,
      String lastName, String email, String phone) async {
    final url = Uri.parse('$baseUrl/new');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // User created successfully
    } else {
      throw Exception('Failed to create user');
    }
  }

 createUserWithId = async (uid,userBody) => {
    if (!userBody) {
      return [406, "No user body provided"];
    }
  
    try {
      const newUser = {
        uid: uid,
        firstName: userBody.firstName,
        lastName: userBody.lastName,
        email: userBody.email,
        phone: userBody.phone,
      };
  
      const userRef = doc(firestore, "user", uid);
      
      await setDoc(userRef, newUser);
  
      return [200, "User created successfully"];
    } catch (error) {
      console.error("Error creating user:", error.message);
      return [500, `Error creating user: ${error.message}`];
    }
  };
  // Get all users
  Future<List<Map<String, dynamic>>> getUsers() async {
    final url = Uri.parse('$baseUrl/getAll');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to retrieve users');
    }
  }

  // Get a single user by UID
  Future<Map<String, dynamic>> getUser(String uid) async {
    final url = Uri.parse('$baseUrl/$uid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // User retrieved successfully
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Failed to retrieve user');
    }
  }
  

  // Update a user
  Future<Map<String, dynamic>> updateUser(String uid, String firstName,
      String lastName, String email, String phone) async {
    final url = Uri.parse('$baseUrl/$uid');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // User updated successfully
    } else {
      throw Exception('Failed to update user');
    }
  }

  // Delete a user
  Future<void> deleteUser(String uid) async {
    final url = Uri.parse('$baseUrl/$uid');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // User deleted successfully
      return;
    } else {
      throw Exception('Failed to delete user');
    }
  }
}

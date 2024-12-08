import 'package:clone_jumia/services/user_service.dart';
import 'package:flutter/material.dart';
import 'EditProfile.dart';
import 'package:clone_jumia/EditProfile.dart';

class UserProfilePage extends StatelessWidget {
  final String userId;
  final UserService userService = UserService();

  UserProfilePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 199, 251, 227), // Background color
      body: Column(
        children: [
          // Back button and profile info
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 27, 188, 57)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Icon(Icons.more_vert, color: Color.fromARGB(255, 27, 188, 57)),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Profile picture and username
          FutureBuilder<Map<String, dynamic>>(
            future: userService.getUser(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Failed to load user data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No user data available'));
              }

              final userData = snapshot.data!;
              return Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        userData['profileImage'] ?? 'assets/splash3.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userData['firstName'] ?? 'User Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage(
                                  userId: userId,
                                )),
                      );
                    },
                    child: Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 27, 188, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
          // Options list
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  _buildOptionItem(Icons.chat, 'Start a chat'),
                  _buildOptionItem(Icons.reply, 'Expert replies'),
                  _buildOptionItem(Icons.star, 'Review ratings'),
                  _buildOptionItem(Icons.question_answer, 'Asked questions'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 27, 188, 57)),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () {
        // Handle option tap
      },
    );
  }
}

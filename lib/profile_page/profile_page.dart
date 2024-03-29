/* 

what should be here
1. Profile image and name
2. Share app
3. Privacy Policy
4. Notifications
5. Settings
6. Sign out button

*/

import 'package:flutter/material.dart';
import 'package:wallify/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Profile image and name
              Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/profile-image.jpg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text("Name Surname"),
                ],
              ),

              const SizedBox(height: 30),

              // Buttons
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.settings),
                label: Text("Settings"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

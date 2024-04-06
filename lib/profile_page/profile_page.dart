/* 

what should be here
1. Profile image and name
2. Share app
3. Privacy Policy
4. Notifications
5. Settings
  - Language
  - App color theme
  - Clear search history
  - Clear cache
  - Recommend
  - Rate app
  - Send feedback
  - Privacy Policy
  - App version info
6. Sign out button

*/

import 'package:flutter/material.dart';
import 'package:wallify/profile_page/components/custom_text_button.dart';
import 'package:wallify/profile_page/settings_page.dart';
import 'package:wallify/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  List<String> _buttons = [
    "Settings",
    "Recommend",
    "Rate app",
    "Send feedback",
    "Privacy Policy"
  ];
  List<IconData> _buttonIcons = [
    Icons.settings,
    Icons.share,
    Icons.star_border,
    Icons.email,
    Icons.verified_user
  ];

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
                  const SizedBox(height: 10),
                  const Text(
                    "Name Surname",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Options
              ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 0,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return CustomTextButton(
                    onPressed: () {
                      if (_buttons[index] == "Settings") {
                        Navigator.pushNamed(context, "/settings_page");
                      } else if (_buttons[index] == "Recommend") {
                      } else if (_buttons[index] == "Rate app") {
                      } else if (_buttons[index] == "Send feedback") {
                      } else if (_buttons[index] == "Privacy Policy") {}
                    },
                    text: _buttons[index],
                    icon: _buttonIcons[index],
                  );
                },
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: lightButtonTheme!.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                          color: lightButtonTheme!.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

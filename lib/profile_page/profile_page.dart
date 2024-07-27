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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/profile_page/components/custom_text_button.dart';
import 'package:wallify/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).get();
  }

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
      final List<String> buttons = [
      S.of(context).settings,
      S.of(context).recommend,
      S.of(context).rateApp,
      S.of(context).sendFeedback,
      S.of(context).privacyPolicy,
    ];
    final List<IconData> buttonIcons = [
      Icons.settings,
      Icons.share,
      Icons.star_border,
      Icons.email,
      Icons.verified_user,
    ];

    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(), 
        builder: (context, snapshot) {
        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // error
        else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        // data received
        else if (snapshot.hasData) {
          // extract data
          Map<String, dynamic>? user = snapshot.data!.data();

          return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Profile image, name, email
              Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      user!["photoUrl"] ?? "https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user["username"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user["email"],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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
                      if (buttons[index] == S.of(context).settings) {
                        Navigator.pushNamed(context, "/settings_page");
                      } else if (buttons[index] == "Recommend") {
                      } else if (buttons[index] == "Rate app") {
                      } else if (buttons[index] == "Send feedback") {
                      } else if (buttons[index] == "Privacy Policy") {}
                    },
                    text: buttons[index],
                    icon: buttonIcons[index],
                  );
                },
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signUserOut,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: lightButtonTheme!.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).signOut,
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
      );
        } else {
          return Text(S.of(context).noData);
        }
      }),
    );
  }
}

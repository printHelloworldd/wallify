import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallify/authentication/components/authentication_button.dart';
import 'package:wallify/authentication/create_account_page/create_account_page.dart';
import 'package:wallify/authentication/login_page/login_page.dart';
import 'package:wallify/components/custom_bottom_nav_bar.dart';
import 'package:wallify/theme/theme.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  void createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAccountPage(),
      ),
    );
  }

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const CustomBottomNavBar();
          }

          // user is not logged in
          else {
            return SafeArea(
              child: Center(
                child: Column(
                  children: [
                    // App name and BG image
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // BG image
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(140),
                            bottomRight: Radius.circular(140),
                          ),
                          child: Image.asset(
                            "assets/images/marcelo-cidrack-7jZNgIuJrCM-unsplash.jpg",
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.75,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // App name
                        Positioned(
                          top: 50,
                          child: Text(
                            "Wallify",
                            style: lightTextTheme.titleLarge,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Welcome To Wallify
                    Text(
                      "Welcome To Wallify",
                      style: lightTextTheme.titleMedium,
                    ),

                    const SizedBox(height: 30),

                    // Create account button
                    AuthenticationButton(
                      onTap: createAccount,
                      name: "Create Account",
                      textColor: lightButtonTheme!.onSecondary,
                      buttonColor: lightButtonTheme!.secondary,
                    ),

                    const SizedBox(height: 15),

                    // Login button
                    AuthenticationButton(
                      onTap: login,
                      name: "Login",
                      textColor: lightButtonTheme!.onPrimary,
                      buttonColor: lightButtonTheme!.primary,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

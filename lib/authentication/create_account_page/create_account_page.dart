import 'package:flutter/material.dart';
import 'package:wallify/authentication/components/authentication_textfield.dart';
import 'package:wallify/authentication/components/authentication_button.dart';
import 'package:wallify/authentication/components/square_tile.dart';
import 'package:wallify/theme/theme.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Hello again!
              Text(
                "Wellcome!",
                style: lightTextTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Join us and create your account!",
                style: lightTextTheme.titleSmall,
              ),

              const SizedBox(height: 30),

              // Full name textfield
              AuthenticationTextField(
                controller: nameController,
                obscureText: false,
                hintText: "Full name",
              ),

              const SizedBox(height: 10),

              // Email textfield
              AuthenticationTextField(
                controller: emailController,
                obscureText: false,
                hintText: "Email",
              ),

              const SizedBox(height: 10),

              // Password textfield
              AuthenticationTextField(
                controller: passwordController,
                obscureText: true,
                hintText: "Password",
              ),

              const SizedBox(height: 10),

              // Confirm password textfield
              AuthenticationTextField(
                controller: confirmedPasswordController,
                obscureText: true,
                hintText: "Confirm password",
              ),

              const SizedBox(height: 25),

              // Sign in button
              AuthenticationButton(
                onTap: signUserUp,
                name: "Sign Up",
                textColor: lightButtonTheme!.onPrimary,
                buttonColor: lightButtonTheme!.primary,
              ),

              const SizedBox(height: 20),

              // Or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: lightTheme.dividerColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or",
                        style: lightTextTheme.labelSmall,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: lightTheme.dividerColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Google, facebook, apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(
                    imagePath: "assets/logo_icons/google.png",
                  ),

                  const SizedBox(width: 25),

                  // facebook button
                  SquareTile(
                    imagePath: "assets/logo_icons/facebook.png",
                  ),

                  const SizedBox(width: 25),

                  // apple button
                  SquareTile(
                    imagePath: "assets/logo_icons/apple-logo.png",
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: lightTextTheme.labelSmall,
                  ),
                  Text(
                    "Sign In",
                    style: lightTextTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

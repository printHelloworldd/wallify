import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/authentication/components/authentication_textfield.dart';
import 'package:wallify/authentication/components/authentication_button.dart';
import 'package:wallify/authentication/components/square_tile.dart';
import 'package:wallify/data/hive_database.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/helper/helper_functions.dart';
import 'package:wallify/services/auth_service.dart';
import 'package:wallify/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try to sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushNamed(context, "/home_page");

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    }

    // display any errors
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }

    Provider.of<AuthenticationProvider>(context, listen: false)
        .changeAnonymousMode(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Hello again!
              Text(
                S.of(context).helloAgain,
                style: lightTextTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S.of(context).welcomeBackYouveBeenMissed,
                  style: lightTextTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),

              // Email textfield
              AuthenticationTextField(
                controller: emailController,
                obscureText: false,
                hintText: S.of(context).email,
              ),

              const SizedBox(height: 10),

              // Password textfield
              AuthenticationTextField(
                controller: passwordController,
                obscureText: true,
                hintText: S.of(context).password,
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).forgotPassword,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Sign in button
              AuthenticationButton(
                onTap: signUserIn,
                name: S.of(context).signIn,
                textColor: lightButtonTheme!.onPrimary,
                buttonColor: lightButtonTheme!.primary,
              ),

              const SizedBox(height: 40),

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
                        S.of(context).orContinueWith,
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

              const SizedBox(height: 40),

              // Google, facebook, apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(
                    imagePath: "assets/logo_icons/google.png",
                    onTap: () => AuthService().signInWithGoogle().whenComplete(
                      () {
                        Provider.of<AuthenticationProvider>(context,
                                listen: false)
                            .changeAnonymousMode(false);
                        Navigator.pushNamed(context, "/home_page");
                      },
                    ),
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

              const SizedBox(height: 40),

              // Not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).notAMember,
                    style: lightTextTheme.labelSmall,
                  ),
                  GestureDetector(
                    child: Text(
                      S.of(context).registerNow,
                      style: lightTextTheme.labelMedium,
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, "/create_account_page"),
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

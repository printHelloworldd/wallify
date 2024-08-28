import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/authentication/components/authentication_textfield.dart';
import 'package:wallify/authentication/components/authentication_button.dart';
import 'package:wallify/authentication/components/square_tile.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/helper/helper_functions.dart';
import 'package:wallify/image_page/image_data_provider.dart';
import 'package:wallify/services/auth_service.dart';
import 'package:wallify/theme/theme.dart';
import 'package:wallify/theme/theme_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

    await Provider.of<ImageDataProvider>(context, listen: false).syncImagaes();

    Navigator.pushNamed(context, "/home_page");
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme =
        Provider.of<ThemeProvider>(context).currentTheme.buttonTheme;
    final textTheme =
        Provider.of<ThemeProvider>(context).currentTheme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Hello again!
              Text(
                S.of(context).helloAgain,
                style: textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S.of(context).welcomeBackYouveBeenMissed,
                  style: textTheme.titleSmall,
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
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "/forgot_password_page"),
                      child: Text(
                        S.of(context).forgotPassword,
                        style: textTheme.labelSmall,
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
                textColor: buttonTheme.colorScheme!.onPrimary,
                buttonColor: buttonTheme.colorScheme!.primary,
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
                        color: lightBlueTheme.dividerColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        S.of(context).orContinueWith,
                        style: textTheme.labelSmall,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: lightBlueTheme.dividerColor,
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
                      () async {
                        Provider.of<AuthenticationProvider>(context,
                                listen: false)
                            .changeAnonymousMode(false);
                        await Provider.of<ImageDataProvider>(context,
                                listen: false)
                            .syncImagaes();
                        Navigator.pushNamed(context, "/home_page");
                      },
                    ),
                  ),

                  // const SizedBox(width: 25),

                  // // facebook button
                  // SquareTile(
                  //   imagePath: "assets/logo_icons/facebook.png",
                  // ),

                  // const SizedBox(width: 25),

                  // // apple button
                  // SquareTile(
                  //   imagePath: "assets/logo_icons/apple-logo.png",
                  // ),
                ],
              ),

              const SizedBox(height: 40),

              // Not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).notAMember,
                    style: textTheme.labelSmall,
                  ),
                  GestureDetector(
                    child: Text(
                      S.of(context).registerNow,
                      style: textTheme.labelMedium,
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

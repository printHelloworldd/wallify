import 'package:cloud_firestore/cloud_firestore.dart';
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

  // TextTheme textTheme = const TextTheme();
  // ButtonThemeData buttonTheme = const ButtonThemeData();

  // @override
  // void initState() {
  //   buttonTheme = Provider.of<ThemeProvider>(context).themeData.buttonTheme;
  //   textTheme = Provider.of<ThemeProvider>(context).themeData.textTheme;
  //   super.initState();
  // }

  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (passwordController.text != confirmedPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error message to user
      displayMessageToUser(S.of(context).passwordsDoNotMatch, context);
    }

    // if passwords do match
    else {
      // try creating the user
      try {
        // create the user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // create a user document and add to firebase
        createUserDocument(userCredential);

        // pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);

        // display error message to user
        displayMessageToUser(e.code, context);
      }

      Provider.of<AuthenticationProvider>(context, listen: false)
          .changeAnonymousMode(false);

      await Provider.of<ImageDataProvider>(context, listen: false)
          .syncImagaes();

      Navigator.pushNamed(context, "/home_page");
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        "email": userCredential.user!.email,
        "username": nameController.text,
        "photoUrl": userCredential.user!.photoURL,
        "images": [],
      });
    }
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
              const SizedBox(height: 30),

              // Hello again!
              Text(
                S.of(context).wellcome,
                style: textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Text(
                S.of(context).joinUsAndCreateYourAccount,
                style: textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Full name textfield
              AuthenticationTextField(
                controller: nameController,
                obscureText: false,
                hintText: S.of(context).fullName,
              ),

              const SizedBox(height: 10),

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

              // Confirm password textfield
              AuthenticationTextField(
                controller: confirmedPasswordController,
                obscureText: true,
                hintText: S.of(context).confirmPassword,
              ),

              const SizedBox(height: 25),

              // Sign up button
              AuthenticationButton(
                onTap: signUserUp,
                name: S.of(context).signUp,
                textColor: buttonTheme.colorScheme!.onPrimary,
                buttonColor: buttonTheme.colorScheme!.primary,
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
                        color: lightBlueTheme.dividerColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        S.of(context).or,
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

              const SizedBox(height: 20),

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

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                    style: textTheme.labelSmall,
                  ),
                  GestureDetector(
                    child: Text(
                      S.of(context).signIn,
                      style: textTheme.labelMedium,
                    ),
                    onTap: () => Navigator.pushNamed(context, "/login_page"),
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

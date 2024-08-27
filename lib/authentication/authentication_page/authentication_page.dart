import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/authentication/components/authentication_button.dart';
import 'package:wallify/components/custom_bottom_nav_bar.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/theme/theme_provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isAnonymousMode = true;

  @override
  void initState() {
    super.initState();
    checkAnonymousMode();
  }

  void checkAnonymousMode() async {
    isAnonymousMode =
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .checkAnonymousMode();
  }

  void createAccount() {
    Navigator.pushNamed(context, "/create_account_page");
  }

  void login() {
    Navigator.pushNamed(context, "/login_page");
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme =
        Provider.of<ThemeProvider>(context).currentTheme.buttonTheme;
    final textTheme =
        Provider.of<ThemeProvider>(context).currentTheme.textTheme;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData || isAnonymousMode) {
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
                            "assets/images/BG.jpg",
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.85,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // App name
                        Positioned(
                          top: 50,
                          child: Text(
                            "Wallify",
                            style: textTheme.titleLarge,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Welcome To Wallify
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        S.of(context).welcomeToWallify,
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Create account button
                    AuthenticationButton(
                      onTap: createAccount,
                      name: S.of(context).createAccount,
                      textColor: buttonTheme.colorScheme!.onSecondary,
                      buttonColor: buttonTheme.colorScheme!.secondary,
                    ),

                    const SizedBox(height: 15),

                    // Login button
                    AuthenticationButton(
                      onTap: login,
                      name: S.of(context).login,
                      textColor: buttonTheme.colorScheme!.onPrimary,
                      buttonColor: buttonTheme.colorScheme!.primary,
                    ),

                    const SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {
                        Provider.of<AuthenticationProvider>(context,
                                listen: false)
                            .changeAnonymousMode(true);
                        Navigator.pushNamed(context, "/home_page");
                      },
                      child: Text(
                        S.of(context).skipForNow,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
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

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/profile_page/components/options.dart';
import 'package:wallify/provider/locale_provider.dart';
import 'package:wallify/theme/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, "/authentication_page");
    if (FirebaseAuth.instance.currentUser == null) {
      print("User signed out successfully.");
    } else {
      print("Sign out failed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(
        context); // If delete it, locale doesn't load from prefs

    void recommendApp() async {
      final result = await Share.share(
        'Try "Wallify" - the best wallpapers for every day! \n https://play.google.com/store/apps/details?id=com.android.chrome',
      ); // TODO: 1) Change app link in Play Store. 2) add snack bar. 3) Add localization

      if (result.status == ShareResultStatus.success) {
        print('Thank you for sharing my app!');
      } else {
        print("Could not share the app");
      }
    }

    void rateApp() {
      // Инициализация и отображение диалога оценки
      RateMyApp rateMyApp = RateMyApp(
        preferencesPrefix: 'rateMyApp_',
        minDays: 2, // Минимальное количество дней с момента установки
        minLaunches: 2, // Минимальное количество запусков приложения
        remindDays: 3, // Количество дней для напоминания о диалоге
        remindLaunches: 3, // Количество запусков для напоминания о диалоге
        googlePlayIdentifier: 'com.android.chrome', // TODOD: Change
      );

      rateMyApp.init().then((_) {
        print('RateMyApp initialized');
        rateMyApp.showRateDialog(
          context,
          title: 'Rate this app', // Заголовок диалога
          message:
              'If you like this app, please take a little bit of your time to review it!\nIt really helps us and it shouldn\'t take you more than one minute.', // Сообщение диалога
          rateButton: 'RATE', // Текст кнопки оценки
          noButton: 'NO THANKS', // Текст кнопки отказа
          laterButton: 'MAYBE LATER', // Текст кнопки "Может быть позже"
          listener: (button) {
            // Обработчик нажатий на кнопки
            switch (button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Вернуть false, если нужно отменить событие нажатия.
          },
          ignoreNativeDialog: Platform.isAndroid,
          dialogStyle: const DialogStyle(), // Настройка стиля диалога
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Обработчик закрытия диалога
        );
      }).catchError((error) {
        print('RateMyApp initialization failed: $error');
      });
    }

    return Consumer<AuthenticationProvider>(
      builder: (context, value, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final buttonTheme = themeProvider.currentTheme.buttonTheme;
        final themeData = themeProvider.currentTheme;

        return Scaffold(
          body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getUserDetails(),
            builder: (context, snapshot) {
              // loading..
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
                                user!["photoUrl"] ??
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user["username"],
                              style: TextStyle(
                                fontSize: 20,
                                color: themeProvider.isDarkMode == true
                                    ? themeData.primaryColorLight
                                    : themeData.primaryColorDark,
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
                        Options(
                          recommendApp: recommendApp,
                          rateApp: rateApp,
                          themeData: themeData,
                        ),

                        const SizedBox(height: 40),

                        // Sign Out Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () => signUserOut(context),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: buttonTheme.colorScheme!.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  S.of(context).signOut,
                                  style: TextStyle(
                                    color: buttonTheme.colorScheme!.onPrimary,
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
              }

              // Anonymous mode
              else if (value.isAnonymousMode) {
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
                              child: Image.asset(
                                "assets/images/user-image.jpg",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "user",
                              style: TextStyle(
                                fontSize: 20,
                                color: themeProvider.isDarkMode == true
                                    ? themeData.primaryColorLight
                                    : themeData.primaryColorDark,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 50),

                        // Options
                        Options(
                          recommendApp: recommendApp,
                          rateApp: rateApp,
                          themeData: themeData,
                        ),

                        const SizedBox(height: 40),

                        // Login Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/login_page"),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: buttonTheme.colorScheme!.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  S.of(context).signIn,
                                  style: TextStyle(
                                    color: buttonTheme.colorScheme!.onPrimary,
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
              }

              // error
              else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                return Text(S.of(context).noData);
              }
            },
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/data/hive_database.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/profile_page/components/custom_text_button.dart';
import 'package:wallify/profile_page/components/policy_dialog.dart';
import 'package:wallify/provider/locale_provider.dart';
import 'package:wallify/theme/theme.dart';
import 'package:wallify/theme/theme_provider.dart';
import 'package:wiredash/wiredash.dart';

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
  } // TODO: Transfer to build method

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

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

    void rateApp() {
      // print("Rate app function called");

      // return RatingBar.builder(
      //   minRating: 1,
      //   itemBuilder: (context, _) => Icon(Icons.star, color: Colors.blue[900]),
      //   onRatingUpdate: (rating) {},
      // );
      RateMyApp rateMyApp = RateMyApp(
        preferencesPrefix: 'rateMyApp_',
        // minDays: 7,
        // minLaunches: 10,
        // remindDays: 7,
        // remindLaunches: 10,
        googlePlayIdentifier: 'com.android.chrome',
        // appStoreIdentifier: '1491556149',
      );

      rateMyApp.init().then((_) {
        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(
            context,
            title: 'Rate this app', // The dialog title.
            message:
                'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.', // The dialog message.
            rateButton: 'RATE', // The dialog "rate" button text.
            noButton: 'NO THANKS', // The dialog "no" button text.
            laterButton: 'MAYBE LATER', // The dialog "later" button text.
            listener: (button) {
              // The button click listener (useful if you want to cancel the click event).
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

              return true; // Return false if you want to cancel the click event.
            },
            ignoreNativeDialog: Platform
                .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
            dialogStyle: const DialogStyle(), // Custom dialog styles.
            onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
                .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
            // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
            // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
          );

          // Or if you prefer to show a star rating bar (powered by `flutter_rating_bar`) :

          // rateMyApp.showStarRateDialog(
          //   context,
          //   title: 'Rate this app', // The dialog title.
          //   message:
          //       'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
          //   // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          //   actionsBuilder: (context, stars) {
          //     // Triggered when the user updates the star rating.
          //     return [
          //       // Return a list of actions (that will be shown at the bottom of the dialog).
          //       TextButton(
          //         child: Text('OK'),
          //         onPressed: () async {
          //           print('Thanks for the ' +
          //               (stars == null ? '0' : stars.round().toString()) +
          //               ' star(s) !');
          //           // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
          //           // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
          //           await rateMyApp
          //               .callEvent(RateMyAppEventType.rateButtonPressed);
          //           Navigator.pop<RateMyAppDialogButton>(
          //               context, RateMyAppDialogButton.rate);
          //         },
          //       ),
          //     ];
          //   },
          //   ignoreNativeDialog: Platform
          //       .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          //   dialogStyle: const DialogStyle(
          //     // Custom dialog styles.
          //     titleAlign: TextAlign.center,
          //     messageAlign: TextAlign.center,
          //     messagePadding: EdgeInsets.only(bottom: 20),
          //   ),
          //   starRatingOptions:
          //       const StarRatingOptions(), // Custom star bar rating options.
          //   onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
          //       .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // );
        }
      }).catchError((error) {
        print('RateMyApp initialization failed: $error');
      });
      ;
    }

    return Consumer<AuthenticationProvider>(
      builder: (context, value, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final buttonTheme = themeProvider.currentTheme.buttonTheme;
        final textTheme = themeProvider.currentTheme.textTheme;
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
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: 5,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: themeData.dividerColor,
                              thickness: 1,
                              height: 0,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return CustomTextButton(
                              onPressed: () async {
                                if (buttons[index] == S.of(context).settings) {
                                  Navigator.pushNamed(
                                      context, "/settings_page");
                                } else if (buttons[index] ==
                                    S.of(context).recommend) {
                                  final result = await Share.share(
                                      "Test share text"); // TODO: Change the text and add localization

                                  if (result.status ==
                                      ShareResultStatus.success) {
                                    print('Thank you for sharing my app!');
                                  } else {
                                    print("Could not share the app");
                                  }
                                } else if (buttons[index] ==
                                    S.of(context).rateApp) {
                                  // Инициализация и отображение диалога оценки
                                  RateMyApp rateMyApp = RateMyApp(
                                    preferencesPrefix: 'rateMyApp_',
                                    minDays:
                                        0, // Минимальное количество дней с момента установки
                                    minLaunches:
                                        0, // Минимальное количество запусков приложения
                                    remindDays:
                                        0, // Количество дней для напоминания о диалоге
                                    remindLaunches:
                                        0, // Количество запусков для напоминания о диалоге
                                    googlePlayIdentifier:
                                        'com.android.chrome', // TODOD: Change
                                  );

                                  rateMyApp.init().then((_) {
                                    print('RateMyApp initialized');
                                    rateMyApp.showRateDialog(
                                      context,
                                      title: S
                                          .of(context)
                                          .rateThisApp, // Заголовок диалога
                                      message: S
                                          .of(context)
                                          .ifYouLikeThisApp, // Сообщение диалога
                                      rateButton: S
                                          .of(context)
                                          .rate, // Текст кнопки оценки
                                      noButton: S
                                          .of(context)
                                          .noThanks, // Текст кнопки отказа
                                      laterButton: S
                                          .of(context)
                                          .maybeLater, // Текст кнопки "Может быть позже"
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
                                      dialogStyle:
                                          const DialogStyle(), // Настройка стиля диалога
                                      onDismissed: () => rateMyApp.callEvent(
                                          RateMyAppEventType
                                              .laterButtonPressed), // Обработчик закрытия диалога
                                    );
                                  }).catchError((error) {
                                    print(
                                        'RateMyApp initialization failed: $error');
                                  });
                                } else if (buttons[index] ==
                                    S.of(context).sendFeedback) {
                                  Wiredash.of(context)
                                      .show(inheritMaterialTheme: true);
                                } else if (buttons[index] ==
                                    S.of(context).privacyPolicy) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PolicyDialog(
                                          mdFileName:
                                              Provider.of<LocaleProvider>(
                                                              context,
                                                              listen: false)
                                                          .locale ==
                                                      Locale("ru")
                                                  ? "privacy_policy_ru.md"
                                                  : "privacy_policy.md");
                                    },
                                  );
                                }
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
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: 5,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: themeData.dividerColor,
                              thickness: 1,
                              height: 0,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return CustomTextButton(
                              onPressed: () async {
                                if (buttons[index] == S.of(context).settings) {
                                  Navigator.pushNamed(
                                      context, "/settings_page");
                                } else if (buttons[index] ==
                                    S.of(context).recommend) {
                                  final result = await Share.share(
                                      "Test share text"); // TODO: Change the text and add localization

                                  if (result.status ==
                                      ShareResultStatus.success) {
                                    print('Thank you for sharing my app!');
                                  } else {
                                    print("Could not share the app");
                                  }
                                } else if (buttons[index] ==
                                    S.of(context).rateApp) {
                                  // Инициализация и отображение диалога оценки
                                  RateMyApp rateMyApp = RateMyApp(
                                    preferencesPrefix: 'rateMyApp_',
                                    minDays:
                                        0, // Минимальное количество дней с момента установки
                                    minLaunches:
                                        0, // Минимальное количество запусков приложения
                                    remindDays:
                                        0, // Количество дней для напоминания о диалоге
                                    remindLaunches:
                                        0, // Количество запусков для напоминания о диалоге
                                    googlePlayIdentifier:
                                        'com.android.chrome', // TODOD: Change
                                  );

                                  rateMyApp.init().then((_) {
                                    print('RateMyApp initialized');
                                    rateMyApp.showRateDialog(
                                      context,
                                      title:
                                          'Rate this app', // Заголовок диалога
                                      message:
                                          'If you like this app, please take a little bit of your time to review it!\nIt really helps us and it shouldn\'t take you more than one minute.', // Сообщение диалога
                                      rateButton: 'RATE', // Текст кнопки оценки
                                      noButton:
                                          'NO THANKS', // Текст кнопки отказа
                                      laterButton:
                                          'MAYBE LATER', // Текст кнопки "Может быть позже"
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
                                      dialogStyle:
                                          const DialogStyle(), // Настройка стиля диалога
                                      onDismissed: () => rateMyApp.callEvent(
                                          RateMyAppEventType
                                              .laterButtonPressed), // Обработчик закрытия диалога
                                    );
                                  }).catchError((error) {
                                    print(
                                        'RateMyApp initialization failed: $error');
                                  });
                                } else if (buttons[index] ==
                                    S.of(context).sendFeedback) {
                                  Wiredash.of(context)
                                      .show(inheritMaterialTheme: true);
                                } else if (buttons[index] ==
                                    S.of(context).privacyPolicy) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PolicyDialog(
                                          mdFileName: "privacy_policy.md");
                                    },
                                  );
                                }
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

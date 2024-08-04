import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/authentication_page/authentication_page.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/authentication/create_account_page/create_account_page.dart';
import 'package:wallify/authentication/login_page/login_page.dart';
import 'package:wallify/components/custom_bottom_nav_bar.dart';
import 'package:wallify/firebase_options.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';
import 'package:wallify/image_page/image_data_provider.dart';
import 'package:wallify/profile_page/settings_page.dart';
import 'package:wallify/theme/theme_provider.dart';

// TODO: Check internet connection
// TODO: Make loading circle while fetching images in HomePage

// TODO: After sign in or after connecting to the internet store images from Hive database into Firestore

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log or handle the error details
    print("$details");
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialize hive
  await Hive.initFlutter();

  // open a hivebox
  await Hive.openBox("test_hive_database_2");

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageDataProvider>(
          create: (_) => ImageDataProvider(),
        ),
        ChangeNotifierProvider<FetchedImagesProvider>(
          create: (_) => FetchedImagesProvider(),
        ),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const AuthenticationPage(),
        routes: {
          "/settings_page": (context) => const SettingsPage(),
          "/create_account_page": (context) => const CreateAccountPage(),
          "/login_page": (context) => const LoginPage(),
          "/home_page": (context) => const CustomBottomNavBar(),
        },
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}

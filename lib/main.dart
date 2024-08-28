import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/authentication_page/authentication_page.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/authentication/create_account_page/create_account_page.dart';
import 'package:wallify/authentication/login_page/forgot_password_page.dart';
import 'package:wallify/authentication/login_page/login_page.dart';
import 'package:wallify/components/custom_bottom_nav_bar.dart';
import 'package:wallify/firebase_options.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';
import 'package:wallify/image_page/image_data_provider.dart';
import 'package:wallify/profile_page/settings_page.dart';
import 'package:wallify/provider/locale_provider.dart';
import 'package:wallify/theme/theme_provider.dart';
import 'package:wiredash/wiredash.dart';

// TODO: Check internet connection

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.setSystemTheme(context,
        theme: themeProvider.currentTheme.primaryColor ==
                const Color(0xFF004864)
            ? "blue"
            : "red"); // TODO: If there more than 2 themes it won't work properly

    // Проверяем системную тему и обновляем тему приложения
    // final brightness = MediaQueryData.fromView(
    //         WidgetsBinding.instance.platformDispatcher.views.first)
    //     .platformBrightness;
    // themeProvider.updateThemeFromSystem(brightness == Brightness.dark);

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
        ),
      ],
      child: Wiredash(
        projectId: 'wallify-2catg8c',
        secret: 'uVMZR2zuPWPIZJlF1xA5v5NHEKOcsah_',
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          // theme: darkBlueTheme,
          theme: themeProvider.currentTheme,
          // themeMode: Provider.of<ThemeProvider>(context).getThemeMode,
          home: const AuthenticationPage(),
          routes: {
            "/settings_page": (context) => const SettingsPage(),
            "/create_account_page": (context) => const CreateAccountPage(),
            "/login_page": (context) => const LoginPage(),
            "/home_page": (context) => const CustomBottomNavBar(),
            "/authentication_page": (context) => const AuthenticationPage(),
            "/forgot_password_page": (context) => const ForgotPasswordPage(),
          },
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // locale: Provider.of<LocaleProvider>(context).locale,
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
  }
}

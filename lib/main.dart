import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallify/components/custom_bottom_nav_bar.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';
import 'package:wallify/image_page/image_data_provider.dart';
import 'package:wallify/profile_page/settings_page.dart';
import 'package:wallify/theme/theme_provider.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log or handle the error details
    print("$details");
  };

  // initialize hive
  await Hive.initFlutter();

  // open a hivebox
  await Hive.openBox("test_image_database");

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const CustomBottomNavBar(),
        routes: {
          "/settings_page": (context) => const SettingsPage(),
        },
      ),
    );
  }
}

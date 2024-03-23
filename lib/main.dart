import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/authentication_page/authentication_page.dart';
import 'package:wallify/components/custom_bottom_nav_bar.dart';
import 'package:wallify/home%20page/home_page.dart';
import 'package:wallify/theme/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: CustomBottomNavBar(),
    );
  }
}

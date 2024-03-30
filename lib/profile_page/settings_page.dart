import 'package:flutter/material.dart';
import 'package:wallify/theme/theme.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: Icon(Icons.language),
                        title: Text("Language"),
                        subtitle: Text("System default: English"),
                      );
                    })),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wallify/theme/theme.dart';

class ImagePage extends StatelessWidget {
  final String imagePath;

  const ImagePage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
    final lightTextTheme = lightTheme.textTheme;

    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // image
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.25,
                fit: BoxFit.cover,
              ),
            ),

            // buttons panel
            Row(
              children: [
                // donwload button
                IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () {},
                ),

                // share button
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),

                // save button
                IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {},
                ),

                // install button
                IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

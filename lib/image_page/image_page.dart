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
            // const SizedBox(height: 10),

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

            const Spacer(),

            // buttons panel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // donwload button
                  IconButton(
                    icon: Icon(Icons.file_download, color: Colors.black),
                    onPressed: () {},
                  ),

                  const SizedBox(width: 10),

                  // share button
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.black),
                    onPressed: () {},
                  ),

                  const SizedBox(width: 10),

                  // save button
                  IconButton(
                    icon: Icon(Icons.bookmark_border, color: Colors.black),
                    onPressed: () {},
                  ),

                  const Spacer(),

                  // install button
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 34, vertical: 8),
                      decoration: BoxDecoration(
                        color: lightButtonTheme!.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              "Install",
                              style: TextStyle(
                                color: lightButtonTheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.install_mobile,
                              color: lightButtonTheme.onPrimary,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

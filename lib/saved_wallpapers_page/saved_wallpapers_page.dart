import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallify/theme/theme.dart';

class SavedWallpapersPage extends StatefulWidget {
  const SavedWallpapersPage({super.key});

  @override
  State<SavedWallpapersPage> createState() => _SavedWallpapersPageState();
}

class _SavedWallpapersPageState extends State<SavedWallpapersPage> {
  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  final List<String> images = [
    "amine-mayoufi-_5PyWBp9HqA-unsplash.jpg",
    "john-towner-3Kv48NS4WUU-unsplash.jpg",
    "mads-schmidt-rasmussen-6YmzwamGzCg-unsplash.jpg",
    "marcelo-cidrack-7jZNgIuJrCM-unsplash.jpg",
    "marcelo-vaz-ka6WGHXcFMY-unsplash.jpg",
    "paul-pastourmatzis-KT3WlrL_bsg-unsplash.jpg",
    "tobias-rademacher-NuBvAE6VfSM-unsplash.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Page title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My favourites wallpapers",
                  style: lightTextTheme.displayLarge,
                ),
              ),

              const SizedBox(height: 20),

              Divider(
                thickness: 0.5,
                color: lightTheme.dividerColor,
              ),

              const SizedBox(height: 20),

              // Images
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: MasonryGridView.builder(
                    itemCount: images.length,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/${images[index]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallify/image_page/image_data_provider.dart';
import 'package:wallify/image_page/image_page.dart';
import 'package:wallify/services/firestore.dart';
import 'package:wallify/theme/theme.dart';

class SavedWallpapersPage extends StatefulWidget {
  const SavedWallpapersPage({super.key});

  @override
  State<SavedWallpapersPage> createState() => _SavedWallpapersPageState();
}

class _SavedWallpapersPageState extends State<SavedWallpapersPage> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ImageDataProvider>(context, listen: false).initializeImages();
    loadImages();
  }

  void loadImages() {
    images =
        Provider.of<ImageDataProvider>(context, listen: false).getAllImages();
  }

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  // final List<String> images = [
  //   "amine-mayoufi-_5PyWBp9HqA-unsplash.jpg",
  //   "john-towner-3Kv48NS4WUU-unsplash.jpg",
  //   "mads-schmidt-rasmussen-6YmzwamGzCg-unsplash.jpg",
  //   "marcelo-cidrack-7jZNgIuJrCM-unsplash.jpg",
  //   "marcelo-vaz-ka6WGHXcFMY-unsplash.jpg",
  //   "paul-pastourmatzis-KT3WlrL_bsg-unsplash.jpg",
  //   "tobias-rademacher-NuBvAE6VfSM-unsplash.jpg"
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageDataProvider>(
      builder: (context, imageDataProvider, _) {
        // final List<String> images = imageDataProvider.getFavoriteImages();
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
                  StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.getImagesStream(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        List firestoreImages = snapshot.data!.docs;

                        return Expanded(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: MasonryGridView.builder(
                                itemCount: firestoreImages.length,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  // get each individual doc
                                  DocumentSnapshot document =
                                      firestoreImages[index];
                                  String docID = document.id;

                                  Map<String, dynamic> data =
                                      document.data() as Map<String, dynamic>;
                                  String imageLink = data["image"];

                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          imageLink,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImagePage(
                                              imagePath: imageLink,
                                              docID: docID,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                          ),
                        );
                      } else {
                        return const Text("No images..");
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

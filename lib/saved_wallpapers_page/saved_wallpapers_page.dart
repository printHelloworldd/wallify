import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/authentication_page/authentication_provider.dart';
import 'package:wallify/generated/l10n.dart';
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
                      S.of(context).myFavouritesWallpapers,
                      style: lightTextTheme.displayLarge,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Divider(
                    thickness: 0.5,
                    color: lightTheme.dividerColor,
                  ),

                  const SizedBox(height: 20),

                  // Images // TODO: display images from hive database, if there is no internet connection
                  !Provider.of<AuthenticationProvider>(context, listen: false)
                          .checkAnonymousMode()
                      ? FutureBuilder(
                          future: firestoreService.getUserImages(),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.data!.isNotEmpty) {
                              List firestoreImages = snapshot.data!;

                              return imagesRender(context, firestoreImages);
                            } else {
                              return Text(S.of(context).noImages);
                            }
                          }),
                        )
                      : images.isNotEmpty
                          ? imagesRender(context, images)
                          : Text(S.of(context).noImages),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

@override
Widget imagesRender(BuildContext context, List images) {
  return Expanded(
    child: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: MasonryGridView.builder(
        itemCount: images.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          // // get each individual doc
          // DocumentSnapshot document =
          //     firestoreImages[index];
          // String docID = document.id;

          // Map<String, dynamic> data =
          //     document.data() as Map<String, dynamic>;
          // String imageLink = data["image"];

          return Padding(
            padding: const EdgeInsets.all(4),
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                // child: Image.network(
                //   images[index],
                //   fit: BoxFit.cover,
                // ),
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePage(
                      imagePath: images[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    ),
  );
}

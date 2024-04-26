// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:async';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:wallify/image_page/image_data_provider.dart';

import 'package:wallify/theme/theme.dart';

class ImagePage extends StatefulWidget {
  final String imagePath;

  const ImagePage({
    super.key,
    required this.imagePath,
  });

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool isFavouriteImage = false;

  @override
  void initState() {
    super.initState();
    loadFavouriteImage();
  }

  // load existing note
  void loadFavouriteImage() {
    Provider.of<ImageDataProvider>(context, listen: false).initializeImages();
    List<String> allFavouritesImages =
        Provider.of<ImageDataProvider>(context, listen: false).getAllImages();
    if (allFavouritesImages.contains(widget.imagePath)) {
      setState(() {
        isFavouriteImage = true;
      });
    }
  }

  // save image to favourites
  void saveImage() {
    Provider.of<ImageDataProvider>(context, listen: false).addImage(
      widget.imagePath,
    );
    setState(() {
      isFavouriteImage = true;
    });
  }

  // delete image from favourites
  void deleteImage() {
    Provider.of<ImageDataProvider>(context, listen: false).deleteImage(
      widget.imagePath,
    );
    setState(() {
      isFavouriteImage = false;
    });
  }

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split("/").last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    print("Path: ${file.path}");

    // OpenFile.open(file.path);
  }

  // download file into private folder not visible to user
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$name");

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration.zero,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  // save image to gallery
  void downloadImage() async {
    String url = widget.imagePath;
    try {
      final bytes = (await get(Uri.parse(url))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file =
          await File("${dir.path}/wallpaper_image.png").writeAsBytes(bytes);

      log("filePath: ${file.path}");
      await GallerySaver.saveImage(file.path, albumName: "Wallify")
          .then((success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Downloaded to Gallery!")),
        );
      });
    } catch (e) {
      log("downloadImageE: $e");
    }
  }

  Future<void> setWallpaper() async {
    try {
      String url = "https://source.unsplash.com/random";
      int location = WallpaperManager
          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
    final lightTextTheme = lightTheme.textTheme;

    bool downloading = false;

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
              child: Image.network(
                widget.imagePath,
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
                    icon: const Icon(Icons.file_download, color: Colors.black),
                    onPressed: downloadImage,
                  ),

                  const SizedBox(width: 10),

                  // share button
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.black),
                    onPressed: () async {
                      // final result = await Share.shareWithResult(
                      //     "Test share text\n\n${widget.imagePath}");
                      //
                      // if (result.status == ShareResultStatus.success) {
                      //   print('Thank you for sharing my website!');
                      // } else {
                      //   print("Could not share the image");
                      // }
                    },
                  ),

                  const SizedBox(width: 10),

                  // save button
                  IconButton(
                    icon: Icon(
                        isFavouriteImage
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: Colors.black),
                    onPressed: () {
                      isFavouriteImage ? deleteImage() : saveImage();
                    },
                  ),

                  const Spacer(),

                  // install button
                  GestureDetector(
                    onTap: () => setWallpaper(),
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

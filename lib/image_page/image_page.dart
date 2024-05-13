// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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

  // download the image {Linux / Windows / Web}
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

  // save image to gallery {Android / IOS}
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

  void setWallpaper(int screen) async {
    String result;
    String url = widget.imagePath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      /* 
        Home screen == 0
        Lock screen == 1
        Both screens == 2 
      */
      if (screen == 0) {
        result = await AsyncWallpaper.setWallpaper(
          url: url,
          wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
          goToHome: false,
          toastDetails: ToastDetails.success(),
          errorToastDetails: ToastDetails.error(),
        )
            ? 'Wallpaper set'
            : 'Failed to get wallpaper.';
      } else if (screen == 1) {
        result = await AsyncWallpaper.setWallpaper(
          url: url,
          wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
          goToHome: false,
          toastDetails: ToastDetails.success(),
          errorToastDetails: ToastDetails.error(),
        )
            ? 'Wallpaper set'
            : 'Failed to get wallpaper.';
      } else if (screen == 2) {
        result = await AsyncWallpaper.setWallpaper(
          url: url,
          wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
          goToHome: false,
          toastDetails: ToastDetails.success(),
          errorToastDetails: ToastDetails.error(),
        )
            ? 'Wallpaper set'
            : 'Failed to get wallpaper.';
      } else {
        result = 'Wrong wallpaper location provided';
      }
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    log(result);
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
                      final result = await Share.share(
                          "Test share text\n\n${widget.imagePath}");

                      if (result.status == ShareResultStatus.success) {
                        print('Thank you for sharing my app!');
                      } else {
                        print("Could not share the image");
                      }
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            height: MediaQuery.of(context).size.height / 3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Set as wallpaper",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setWallpaper(0);
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.zero),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                        if (states.contains(
                                                MaterialState.hovered) ||
                                            states.contains(
                                                MaterialState.pressed)) {
                                          return Colors.grey[
                                              300]!; // Цвет фона при наведении и нажатии
                                        }
                                        return Colors
                                            .transparent; // Исходный цвет фона
                                      },
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Home screen",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setWallpaper(1);
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.zero),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                        if (states.contains(
                                                MaterialState.hovered) ||
                                            states.contains(
                                                MaterialState.pressed)) {
                                          return Colors.grey[
                                              300]!; // Цвет фона при наведении и нажатии
                                        }
                                        return Colors
                                            .transparent; // Исходный цвет фона
                                      },
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Lock screen",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setWallpaper(2);
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.zero),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                        if (states.contains(
                                                MaterialState.hovered) ||
                                            states.contains(
                                                MaterialState.pressed)) {
                                          return Colors.grey[
                                              300]!; // Цвет фона при наведении и нажатии
                                        }
                                        return Colors
                                            .transparent; // Исходный цвет фона
                                      },
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Home and Lock screens",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
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
                              "Set",
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

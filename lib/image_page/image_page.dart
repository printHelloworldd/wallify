// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
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

  // static const _url =
  //     'https://dosomthings.com/wp-content/uploads/2023/07/How-to-download-and-save-image-to-file-in-FlutterDosomthings.com_-1024x576.png';
  // var random = Random();

  // Future<void> _saveImage(BuildContext context) async {
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //   late String message;

  //   try {
  //     // Download image
  //     final http.Response response = await http.get(Uri.parse(_url));

  //     // Get temporary directory
  //     final dir = await getTemporaryDirectory();

  //     // Create an image name
  //     var filename = '${dir.path}/SaveImage${random.nextInt(100)}.png';

  //     // Save to filesystem
  //     final file = File(filename);
  //     await file.writeAsBytes(response.bodyBytes);

  //     // Ask the user to save it
  //     final params = SaveFileDialogParams(sourceFilePath: file.path);
  //     final finalPath = await FlutterFileDialog.saveFile(params: params);

  //     if (finalPath != null) {
  //       message = 'Image saved to disk';
  //     }
  //   } catch (e) {
  //     message = e.toString();
  //     scaffoldMessenger.showSnackBar(SnackBar(
  //       content: Text(
  //         message,
  //         style: TextStyle(
  //           fontSize: 12,
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       backgroundColor: Color(0xFFe91e63),
  //     ));
  //   }

  //   if (message != null) {
  //     scaffoldMessenger.showSnackBar(SnackBar(
  //       content: Text(
  //         message,
  //         style: TextStyle(
  //           fontSize: 12,
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       backgroundColor: Color(0xFFe91e63),
  //     ));
  //   }
  // }

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

  @override
  Widget build(BuildContext context) {
    final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
    final lightTextTheme = lightTheme.textTheme;

    bool downloading = false;

    // Future<void> downloadImage(String url) async {
    //   setState(() {
    //     downloading = true;
    //   });
    //   // const _url = "https://picsum.photos/200";
    //   await WebImageDownloader.downloadImageFromWeb(
    //     url,
    //     name: 'image01',
    //     // imageType: ImageType.png,
    //   );
    //   setState(() {
    //     downloading = false;
    //   });
    // }

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
                    onPressed: () => openFile(
                      url: widget.imagePath,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // share button
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.black),
                    onPressed: () {},
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

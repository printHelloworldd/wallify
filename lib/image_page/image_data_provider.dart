import 'package:flutter/material.dart';
import 'package:wallify/data/hive_database.dart';

class ImageDataProvider extends ChangeNotifier {
  // hive database
  final db = HiveDatabase();

  // overall list of images
  List<String> allImages = [];

  // initialize list
  void initializeImages() {
    allImages = db.loadImages();
  }

  // get images
  List<String> getAllImages() {
    return allImages;
  }

  // add a new image
  void addImage(String imageUrl) {
    allImages.add(imageUrl);

    db.saveImages(allImages);
    notifyListeners(); // using after important change
  }

  // delete image
  void deleteImage(String imageUrl) {
    allImages.remove(imageUrl);

    db.saveImages(allImages);
    notifyListeners();
  }
}

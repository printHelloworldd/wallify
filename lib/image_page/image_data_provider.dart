import 'package:flutter/material.dart';
import 'package:wallify/data/hive_database.dart';
import 'package:wallify/services/firestore.dart';

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

  void updateImages(List<String> images) {
    db.saveImages(images);
  }

  Future syncImagaes() async {
    // Get images from Hive local database
    List<String> imagesFromHive = getAllImages();
    // Get images from firestore
    final FirestoreService firestoreService = FirestoreService();
    List<String> imagesFromFirestore = await firestoreService.getUserImages();
    // add all images into one list ana delete dublicate images
    List<String> allImages = imagesFromHive + imagesFromFirestore;
    List<String> uniqueImages = allImages.toSet().toList();
    // store all images list into Hive local database ana firestore
    firestoreService.updateUserDetails(uniqueImages);
    updateImages(uniqueImages);
  }
}

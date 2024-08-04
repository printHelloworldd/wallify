import 'package:hive/hive.dart';

class HiveDatabase {
  // reference hive box
  final _myBox = Hive.box("test_hive_database_2");

  // load images
  List<String> loadImages() {
    List<String> savedImages = [];

    // if there exist images, return that, otherwise return empty list
    if (_myBox.get("FAVOURITES_IMAGES") != null) {
      savedImages = _myBox.get("FAVOURITES_IMAGES");
    } /* else {
      // default first note
      savedNotesFormatted
          .add(Note(id: 0, title: "Default note", text: "First Note"));
    } */

    return savedImages;
  }

  // save image
  void saveImages(List<String> allImages) {
    // store into hive
    _myBox.put("FAVOURITES_IMAGES", allImages);
  }

  // anonymous sign in
  void changeAnonymousMode(bool changeModeAs) {
    _myBox.put("IS_ANONYMOUS_MODE", changeModeAs);
  }

  bool checkAnonymousMode() {
    bool isAnonymousMode;
    if (_myBox.get("IS_ANONYMOUS_MODE") != null) {
      isAnonymousMode = _myBox.get("IS_ANONYMOUS_MODE");
    } else {
      _myBox.put("IS_ANONYMOUS_MODE", false);
      isAnonymousMode = _myBox.get("IS_ANONYMOUS_MODE");
    }

    return isAnonymousMode;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of {image links}
  final CollectionReference images =
      FirebaseFirestore.instance.collection("images");

  // CREATE: add a new image
  Future<void> addImage(String image) {
    return images.add({
      "image": image,
      "timestamp": Timestamp.now(), // !!!
    });
  }

  // READ: get images from database
  Stream<QuerySnapshot> getImagesStream() {
    final imagesStream =
        images.orderBy("timestamp", descending: true).snapshots();

    return imagesStream;
  }

  // DELETE: delete image given index or link
  Future<void> deleteImage(String docID) {
    return images.doc(docID).delete();
  }
}

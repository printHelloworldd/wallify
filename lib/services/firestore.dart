import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // // get collection of {image links}
  // final CollectionReference images =
  //     FirebaseFirestore.instance.collection("images");

  // // CREATE: add a new image
  // Future<void> addImage(String image) {
  //   return images.add({
  //     "image": image,
  //     "timestamp": Timestamp.now(), // !!!
  //   });
  // }

  // // READ: get images from database
  // Stream<QuerySnapshot> getImagesStream() {
  //   final imagesStream =
  //       images.orderBy("timestamp", descending: true).snapshots();

  //   return imagesStream;
  // }

  // // DELETE: delete image given index or link
  // Future<void> deleteImage(String docID) {
  //   return images.doc(docID).delete();
  // }


  // Get user details
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).get();
  }

  // Get user images list
  Future<List<String>> getUserImages() async {
    DocumentSnapshot<Map<String, dynamic>> userDetails = await getUserDetails();
    List<String> imagesList = List<String>.from(userDetails.data()?['images'] ?? []);
    return imagesList;
  }

  Future<void> addImage(String image) async {
    List imagesList = await getUserImages();
    print("User images: $imagesList");
    imagesList.add(image);
    await updateUserDetails(imagesList);
    print("User images updated: $imagesList");
  }

  Future<void> removeImage(String image) async {
    List imagesList = await getUserImages();
    print("User images: $imagesList");
    imagesList.remove(image);
    await updateUserDetails(imagesList);
    print("User images updated: $imagesList");
  }

  Future<void> updateUserDetails(List imagesList) async {
    await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
      'images': imagesList,
  });
  }
}

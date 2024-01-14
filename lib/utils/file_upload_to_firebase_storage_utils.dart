import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileUploadToFirebaseStorageUtils {
  static final _firebaseStorage = FirebaseStorage.instance;

  static Future<String> uploadToFirebaseStorage(
      File file, String path, String contentType) {
    var metadata = SettableMetadata(contentType: contentType);

    return _firebaseStorage
        .ref(path)
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(file, metadata)
        .then(
            (snapShot) => snapShot.ref.getDownloadURL().then((value) => value));
  }
}

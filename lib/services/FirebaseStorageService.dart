import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference ref;

  Future<String> UploadFile(String ProductId, File file) async {
    ref = storage.ref().child(ProductId).child("Product_Photo.png");
    UploadTask uploadTask = ref.putFile(file);
    String Url = await (await uploadTask).ref.getDownloadURL();
    return Url;
  }
}

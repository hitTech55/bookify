import 'dart:io';

import 'package:bookify/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PublishRepo{

  static FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  static FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<bool> publishBookPostToFirebase(BookModel bookModel) async{

    try{
      print("Publishing: ${bookModel.toJson()}");
      await _firebaseFireStore.collection("posts").add(bookModel.toJson());
      return true;
    }catch(err){
      print("Publishing Error: ${err.toString()}");
    }

    return false;
  }

  static Future<String?> uploadImageToFirebase(File image) async{
    try{
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageReference = _firebaseStorage.ref().child('posts/images/$fileName');

      UploadTask uploadTask = storageReference.putFile(image);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    }catch(err){

      print("Error uploading image to Firebase Storage: $err");
      return null;
    }
  }
}
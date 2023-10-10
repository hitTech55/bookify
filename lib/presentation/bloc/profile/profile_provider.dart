import 'package:bookify/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier{

  UserModel? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  UserModel? get user => _user;


  ProfileProvider(){
    getUserDataFromFireStore();
  }
  Future getUserDataFromFireStore() async {
    String uid =  _auth.currentUser!.uid;
    DocumentSnapshot snap =
    await _firebaseFireStore.collection('users').doc(uid).get();
    print("Data from firebase : $snap");
    final data = UserModel.fromJson(snap);
    setUser(data);
  }
  setUser(UserModel user){
    _user = user;
    notifyListeners();
  }

  void logout(){
    _auth.signOut();
  }
}
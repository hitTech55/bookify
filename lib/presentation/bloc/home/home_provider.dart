import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{

  int _index = 0;

  int get index => _index;

  setIndex(int value) {
    _index = value;
    notifyListeners();
  }
}
import 'package:bookify/core/utils/snack_bar.dart';
import 'package:bookify/presentation/bloc/internet_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  //const
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  //Error
  bool _error = false;
  bool get hasError => _error;

  String? _errorCode;
  String? get errorCode => _errorCode;

  Future signInWithGoogle(context) async {
    InternetProvider ip = InternetProvider();
    await ip.checkInternetConnection();
    if (ip.hasInternet) {
      try {
        final userAccount = await _googleSignIn.signIn();

        if (userAccount == null) return;

        final GoogleSignInAuthentication googleAuth =
            await userAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final user = (await _auth.signInWithCredential(credential)).user!;
        print("User: $user");
        bool userExists = await checkIfUserAlreadyExists(user.uid);
        if (!userExists) {
          try {
            final DocumentReference ref =
                _firebaseFireStore.collection('users').doc(user.uid);
            await ref.set({
              "uid": user.uid,
              "email": user.email,
              "displayName": user.displayName,
              "photoUrl": user.photoURL,
            });
          } catch (error) {
            print("Error : $error");
            _error = true;
            _errorCode = "Failed to save the data in db";
            openSnackBar(context, errorCode, Colors.red);
            notifyListeners();
          }
        }
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credentials":
            _errorCode =
                "You already have an account with the same credentials";
            _error = true;
            openSnackBar(context, errorCode, Colors.red);
            notifyListeners();
            break;
          case "null":
            _errorCode = "Unexpected error while signing in";
            _error = true;
            openSnackBar(context, errorCode, Colors.red);
            notifyListeners();
            break;
          default:
            _errorCode = "Error here. . . ${e.toString()}";
            _error = true;
            openSnackBar(context, errorCode, Colors.red);
            notifyListeners();
            break;
        }
      }
    } else {
      _error = true;
      _errorCode = "No Internet Connection";
      openSnackBar(context, errorCode, Colors.red);
      notifyListeners();
      return;
    }
  }

  Future signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    notifyListeners();
  }

  Future<bool> checkIfEnteredMobileNumber(DocumentSnapshot snap) async {
    if (snap.get("phoneNumber") != null) {
      print("Phone Number Already Entered");
      return true;
    } else {
      print("Phone Number Is Not Entered");
      return false;
    }
  }

  Future<bool> checkIfUserAlreadyExists(String uid) async {
    DocumentSnapshot snap =
        await _firebaseFireStore.collection('users').doc(uid).get();

    if (snap.exists) {
      print("EXISTING USER");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  Future getUserDataFromFireStore() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snap =
        await _firebaseFireStore.collection('users').doc(uid).get();
    return snap.data();
  }
}

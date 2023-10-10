import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String? userName;
  final String? uid;
  final String? email;
  final String? profileImage;
  final String? mobileNumber;

  const UserModel({
    this.userName,
    this.uid,
    this.email,
    this.profileImage,
    this.mobileNumber
  });

  factory UserModel.fromJson(DocumentSnapshot json){
    return UserModel(
      userName: json.get('displayName'),
      uid: json.get('uid'),
      email: json.get('email'),
      profileImage: json.get('photoUrl'),
      // mobileNumber: json.get('phoneNumber')
    );
  }
  @override
  List<Object?> get props => [userName, uid, email, profileImage];
}
import 'dart:io';
import 'package:bookify/core/utils/snack_bar.dart';
import 'package:bookify/models/book_model.dart';
import 'package:bookify/presentation/bloc/home/home_provider.dart';
import 'package:bookify/presentation/pages/home/home_page.dart';
import 'package:bookify/repo/auth/publish_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublishProvider extends ChangeNotifier{

  final List<String> _departmentList = ["Comp",
  "IT",
  "Mechanical",
  "Electrical",
  "E&TC",
  "Civil",
  "Ai&Ds"
  ];

  final List<String> _yearList = ["F.E", "S.E", "T.E", "B.E"];
  String _department = "Comp";
  String _year = "F.E";
  String _bookName = "";
  bool _isFree = true;
  double _price = 0.0;
  String _priceOption = "free";
  File? _image;
  int? _errorCode;

  final HomeProvider provider = HomeProvider();

  List<String> get departmentList => _departmentList;

  List<String> get yearList => _yearList;

  String get department => _department;

  String get year => _year;

  String get bookName => _bookName;

  bool get isFree => _isFree;

  double get price => _price;

  File? get image => _image;

  String get priceOption => _priceOption;

  int? get errorCode => _errorCode;


  setIsFree(bool value){
    _isFree = value;
  }

  setDepartment(String value){
    _department = value;
    notifyListeners();
  }

  setBookName(String value){
    _bookName = value;
  }

  setYear(String value){
    _year = value;
    notifyListeners();
  }

  setPrice(double value){
    _price = value;
  }

  setImage(File image){
    _image = image;
    notifyListeners();
  }

  setPriceOption(String value){
    _priceOption = value;
    notifyListeners();
  }

  setError(int error){
    _errorCode = error;
    notifyListeners();
  }

  void publishBookPost(BuildContext context) async{
    if(bookName.isEmpty && bookName == "" && image == null){
      openSnackBar(context, "Please fill all the fields", Colors.red);
      return;
    }

    String? imageResult = await PublishRepo.uploadImageToFirebase(image!);

    if(imageResult != null) {

      BookModel model = BookModel(
          bookName: bookName,
          department: department,
          year: year,
          isFree: isFree,
          price: price,
          imageUrl: imageResult
      );

      bool result = await PublishRepo.publishBookPostToFirebase(model);

      if (result) {
        openSnackBar(context, "Post Uploaded Succesfully", Colors.green);
        var homeProvider = Provider.of<HomeProvider>(context, listen: false);
        homeProvider.setIndex(0);
      } else {
        openSnackBar(context, "Error Occured While Posting", Colors.red);
      }
    }else{
      openSnackBar(context, "Error Uploading Image to Database", Colors.red);
    }
  }
}
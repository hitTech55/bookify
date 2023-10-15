import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String? bookName;
  final String? department;
  final String? year;
  final bool? isFree;
  final double? price;
  final String? imageUrl;

  const BookModel({
    required this.bookName,
    required this.department,
    required this.year,
    required this.isFree,
    required this.price,
    required this.imageUrl,
  });

  factory BookModel.fromJson(Map<String,dynamic> json){
    return BookModel(
      bookName: json['bookName'],
      department: json['department'],
      year: json['year'],
      isFree: json['isFree'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "bookName":bookName,
      "department":department,
      "year":year,
      "isFree": isFree,
      "price":price,
      "imageUrl":imageUrl
    };
  }
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

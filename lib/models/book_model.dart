import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String? bookName;
  final String? department;
  final String? year;
  final String? publisher;
  final bool? isFree;
  final String? price;
  final String? imageUrl;

  const BookModel({
    required this.bookName,
    required this.department,
    required this.year,
    required this.publisher,
    required this.isFree,
    required this.price,
    required this.imageUrl,
  });

  factory BookModel.fromJson(Map<String,dynamic> json){
    return BookModel(
      bookName: json['bookName'],
      department: json['department'],
      year: json['year'],
      publisher: json['publisher'],
      isFree: json['isFree'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

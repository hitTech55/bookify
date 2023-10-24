
import 'package:bookify/presentation/widgets/books_page_widgets/book_card.dart';
import 'package:flutter/material.dart';
class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index){
              return const BookCard();
            }),
      )
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: "",
                errorWidget: (context,error,_)=> const Center(child: Icon(Icons.error)),
                placeholder: (context,_) => const CupertinoActivityIndicator(),
              ),
              const SizedBox(height: 20),
              Text("Name of book"),
              Text("Department Year"),
              Text("Prices/ free"),
              const SizedBox(height: 20),
              Text("Publisher Name"),
              const SizedBox(height:20),
              Text("Whatsapp Number button")
            ],
          ),
        )
      ),
    );
  }
}

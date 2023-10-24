import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 120,
              child: CachedNetworkImage(
                placeholder: (context,_)=>const CupertinoActivityIndicator(),
                errorWidget: (context,error,_)=> const Center(child: Icon(Icons.error)),
                imageUrl: 'https://media.licdn.com/dms/image/D5605AQHeZ-53n9xaWA/feedshare-thumbnail_720_1280/0/1693370817887?e=2147483647&v=beta&t=db5QAA4cYvVPxxfOOFi0xskNP4PGwhuMbP3JowPCUto',
              ),
            ),
            const SizedBox(width: 20),
            const Column(
              children: [
                Text("Name of Book"),
                Text("Price / Free"),
                Text("Department / Year"),
                Text("Publisher Name")
              ],
            ),
          ]
        ),
      ),
    );
  }
}

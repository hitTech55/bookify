import 'package:flutter/material.dart';

void openSnackBar(context,snackMessage,color){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.red,
        onPressed: () {  },
      ),
      content: Text(snackMessage,style: TextStyle(color: color),),
    ),
  );
}
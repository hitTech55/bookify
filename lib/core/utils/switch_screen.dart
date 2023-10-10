import 'package:flutter/material.dart';

void switchScreen(context, page){
  Navigator.of(context).pushNamed(page);
}

void switchScreenReplacement(context, page){
  Navigator.of(context).pushReplacementNamed(page);
}
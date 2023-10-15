
import 'package:bookify/presentation/pages/auth/login_page.dart';
import 'package:bookify/presentation/pages/home/home_page.dart';
import 'package:bookify/presentation/pages/home/books_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _materialRoute(const HomePage());
      case '/login':
        return _materialRoute(const LoginPage());
      case '/book':
        return _materialRoute(const BooksPage());
      default:
        return _materialRoute(const LoginPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

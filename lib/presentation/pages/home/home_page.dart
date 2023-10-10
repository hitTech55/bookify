import 'package:bookify/presentation/bloc/home/home_provider.dart';
import 'package:bookify/presentation/pages/home/books_page.dart';
import 'package:bookify/presentation/pages/profile/profile_page.dart';
import 'package:bookify/presentation/pages/publish/publish_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final List<Widget> _tabList = [
      const BooksPage(),
      const PublishPage(),
      const ProfilePage()
    ];
    return Scaffold(
        body: Stack(
      children: [
        _tabList.elementAt(homeProvider.index),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
              alignment: const Alignment(0.0, 1.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: BottomNavigationBar(
                    selectedItemColor: Colors.white,
                    currentIndex: homeProvider.index,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: Colors.black,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    onTap: (int index) {
                      homeProvider.setIndex(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add),
                        label: 'Publish',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ]),
              )),
        )
      ],
    ));
  }
}

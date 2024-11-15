import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mirror_app/pages/bookmark/views/bookmark.dart';
import 'package:mirror_app/pages/home/provider/home_provider.dart';
import 'package:mirror_app/pages/home/views/home.dart';
import 'package:mirror_app/pages/search/views/search.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  List pages = [
    const HomePage(),
    const SearchPage(),
    const BookmarkPage(),
  ];
  int currentIndex = 0;
  late HomeProvider homeProviderW;
  late HomeProvider homeProviderR;

  @override
  Widget build(BuildContext context) {
    homeProviderW = context.watch<HomeProvider>();
    homeProviderR = context.read<HomeProvider>();

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CrystalNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        enableFloatingNavBar: false,
        items: [
          // Home
          CrystalNavigationBarItem(
            icon: Icons.home,
          ),

          // Search
          CrystalNavigationBarItem(
            icon: Icons.search,
          ),

          // Bookmark
          CrystalNavigationBarItem(
            icon: Icons.bookmark_add_outlined,
          ),
        ],
      ),
    );
  }
}

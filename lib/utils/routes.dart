import 'package:flutter/material.dart';
import 'package:mirror_app/pages/bookmark/views/bookmark.dart';
import 'package:mirror_app/pages/bottomnavigation/bottomnavigation.dart';
import 'package:mirror_app/pages/home/views/home.dart';
import 'package:mirror_app/pages/search/views/search.dart';
import 'package:mirror_app/pages/splash/views/splash.dart';

class Routes {
  static const String splash = "/";
  static const String home = "/home";
  static const String bottomnavigation = "/bottomnavigation";
  static const String search = "/search";
  static const String bookmarkpage = "/bookmarkpage";
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.splash: (context) => const SplashPage(),
    Routes.home: (context) => const HomePage(),
    Routes.search: (context) => const SearchPage(),
    Routes.bookmarkpage: (context) => const BookmarkPage(),
    Routes.bottomnavigation: (context) => const BottomNavigationBarPage(),
  };
}

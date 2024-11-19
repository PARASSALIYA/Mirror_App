import 'package:flutter/material.dart';
import 'package:mirror_app/pages/bookmark/views/bookmark.dart';
import 'package:mirror_app/pages/home/views/home.dart';
import 'package:mirror_app/pages/searchhistory/views/search_history.dart';
import 'package:mirror_app/pages/setting/views/setting.dart';
import 'package:mirror_app/pages/splash/views/splash.dart';

class Routes {
  static const String splash = "/";
  static const String home = "/home";
  static const String bookmarkpage = "/bookmarkpage";
  static const String settingpage = "/settingpage";
  static const String searchhistory = "/searchhistory";
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.splash: (context) => const SplashPage(),
    Routes.home: (context) => const HomePage(),
    Routes.bookmarkpage: (context) => const BookmarkPage(),
    Routes.settingpage: (context) => const SettingPage(),
    Routes.searchhistory: (context) => const SearchHistoryPage(),
  };
}

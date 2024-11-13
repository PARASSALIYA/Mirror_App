import 'package:flutter/material.dart';
import 'package:mirror_app/pages/home/views/home.dart';

class Routes {
  static const String home = "/";
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.home: (context) => const HomePage(),
  };
}

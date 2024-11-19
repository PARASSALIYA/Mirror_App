import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  static ShrHelper shrHelper = ShrHelper();
  List<String> bookMark = [];
  String? selectedIndex;

  // void setIndex(InAppWebViewController webView) async {
  //   SharedPreferences shr = await SharedPreferences.getInstance();
  //   shr.setString(
  //     "index",
  //     webView.toString(),
  //   );
  // }

  void setIndex(String webView) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setString(
      "index",
      webView,
    );
  }

  Future<String?> getIndex() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    String? index = shr.getString("index");
    return index;
  }

  Future<void> setBookMark(String name) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bookMark.add(name);
    shr.setStringList("bookMark", bookMark);
  }

  void removeBookMark(String name) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bookMark.remove(name);
    shr.getStringList("bookMark");
  }

  Future<void> setTheme(bool theme) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool("theme", theme);
  }

  Future<bool?> getTheme() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? theme = shr.getBool("theme");
    return theme;
  }
}

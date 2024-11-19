import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mirror_app/pages/home/helper/helper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeProvider with ChangeNotifier {
  var connectivity = Connectivity();
  double progress = 0;
  int currentIndex = 0;
  String? url;
  InAppWebViewController? webController;

  bool isTheme = false;
  bool isConnect = false;

  void checkConnection() async {
    StreamSubscription<List<ConnectivityResult>> results =
        (await Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none)) {
          isConnect = false;
        } else {
          isConnect = true;
        }
        notifyListeners();
      },
    ));
  }

  void isProcess(double value) {
    progress = value;
    notifyListeners();
  }

  void themeChange(bool theme) {
    isTheme = theme;
    ShrHelper.shrHelper.setTheme(theme);
    notifyListeners();
  }

  void checkTheme() async {
    bool? theme = await ShrHelper.shrHelper.getTheme();
    isTheme = theme!;
    notifyListeners();
  }
  //
  // void bookMark(String name) async {
  //   await ShrHelper.shrHelper.setBookMark(name);
  //   notifyListeners();
  // }

  // void removeBookMark(String name) async {
  //   await ShrHelper.shrHelper.removeBookMark(name);
  //   notifyListeners();
  // }

  // void selectIndex(InAppWebViewController val) {
  //   ShrHelper.shrHelper.setIndex(val);
  //   notifyListeners();
  // }
  //
  // void checkIndex() {
  //   ShrHelper.shrHelper.getIndex();
  //   notifyListeners();
  // }
  void selectIndex(String val) {
    ShrHelper.shrHelper.setIndex(val);
    notifyListeners();
  }

  Future<void> checkIndex() async {
   url = await ShrHelper.shrHelper.getIndex();
    notifyListeners();
  }
}

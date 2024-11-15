import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeProvider with ChangeNotifier {
  var connectivity = Connectivity();
  double progress = 0;
  int currentIndex = 0;
  InAppWebViewController? webController;
  String? url;
  List bookMark = [];

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
}

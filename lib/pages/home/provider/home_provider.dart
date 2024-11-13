import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mirror_app/pages/home/model/model.dart';

class HomeProvider with ChangeNotifier {
  var connectivity = Connectivity();
  double progress = 0;
  int isSelected = 0;
  bool isConnect = false;
  void checkConnection() async {
    StreamSubscription<List<ConnectivityResult>> results = (await Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        isConnect = false;
      } else {
        isConnect = true;
      }
      notifyListeners();
    }));
  }

  void isProcess(double value) {
    progress = value;
    notifyListeners();
  }

  void setSelected(int index) {
    isSelected = index;
    notifyListeners();
  }

  List<Model> list = [
    Model(
      name: "Google",
      url: "https://www.google.com/",
      icon: Icons.g_mobiledata_outlined,
    ),
    Model(
      name: "Yahoo",
      url: "https://www.yahoo.com/",
      icon: Icons.g_mobiledata_outlined,
    ),
    Model(
      name: "Bing",
      url: "https://www.bing.com/",
      icon: Icons.g_mobiledata_outlined,
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:mirror_app/pages/home/provider/home_provider.dart';
import 'package:mirror_app/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const Mirror_App(),
  );
}

class Mirror_App extends StatefulWidget {
  const Mirror_App({super.key});

  @override
  State<Mirror_App> createState() => _Mirror_AppState();
}

class _Mirror_AppState extends State<Mirror_App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider()
            ..checkTheme()
            ..getHistory()
            ..getIndex(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            theme: (value.isTheme) ? ThemeData.dark() : ThemeData.light(),
            themeMode: (value.isTheme)
                ? ThemeMode.dark
                : value.isTheme
                    ? ThemeMode.light
                    : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}

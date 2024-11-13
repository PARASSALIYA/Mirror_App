import 'package:flutter/material.dart';
import 'package:mirror_app/pages/home/provider/home_provider.dart';
import 'package:mirror_app/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const Mirror_App(),
  );
}

class Mirror_App extends StatelessWidget {
  const Mirror_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
      ),
    );
  }
}

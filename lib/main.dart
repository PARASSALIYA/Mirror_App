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
            ..getHistory(),
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

// import 'package:flutter/material.dart';
// import 'package:mirror_app/pages/home/provider/home_provider.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => SearchHistoryProvider(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Search History App',
//       theme: ThemeData.light(),
//       home: const SearchPage(),
//     );
//   }
// }
//
// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search History'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Search',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: (term) {
//                 searchHistoryProvider.addSearchTerm(term);
//               },
//             ),
//             const SizedBox(height: 20),
//             if (searchHistoryProvider.searchHistory.isEmpty)
//               const Text('No search history found.'),
//             if (searchHistoryProvider.searchHistory.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: searchHistoryProvider.searchHistory.length,
//                   itemBuilder: (context, index) {
//                     final term = searchHistoryProvider.searchHistory[index];
//                     return ListTile(
//                       title: Text(term),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () {
//                           searchHistoryProvider.removeSearchTerm(term);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             if (searchHistoryProvider.searchHistory.isNotEmpty)
//               ElevatedButton(
//                 onPressed: () {
//                   searchHistoryProvider.clearSearchHistory();
//                 },
//                 child: const Text('Clear Search History'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

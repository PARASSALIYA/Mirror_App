import 'package:flutter/material.dart';
import 'package:mirror_app/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late HomeProvider bookmarkProviderW;
  late HomeProvider bookmarkProviderR;
  @override
  Widget build(BuildContext context) {
    bookmarkProviderW = context.watch<HomeProvider>();
    bookmarkProviderR = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: bookmarkProviderW.bookmark.length,
            itemBuilder: (context, index) {
              final url = bookmarkProviderW.bookmark[index];
              return ListTile(
                title: Text(url),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

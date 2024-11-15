import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_app/pages/home/provider/home_provider.dart';

import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late HomeProvider searchProviderW;
  late HomeProvider searchProviderR;
  String? searchtext;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    searchProviderW = context.watch<HomeProvider>();
    searchProviderR = context.read<HomeProvider>();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: controller,
              onSubmitted: (val) {
                var url = WebUri(val);
                context.read<HomeProvider>().webController?.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://www.google.com/search?q=$val"),
                      ),
                    );
                searchtext = controller.text;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.link_sharp),
                hintText: 'Search',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          // (searchtext != null)
          //     ? Expanded(
          //         child: InAppWebView(
          //           initialUrlRequest: URLRequest(
          //             url: WebUri(
          //               "${searchProviderW == null ? "https://www.google.com/" : searchProviderW.webController?.getUrl()}",
          //             ),
          //           ),
          //           onProgressChanged: (controller, progress) {
          //             searchProviderW.isProcess(progress / 100);
          //           },
          //           onWebViewCreated: (controller) {
          //             searchProviderW.webController = controller;
          //           },
          //         ),
          //       )
          //     : Container(),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(
                  "${searchProviderW == true ? "https://www.google.com/" : searchProviderW.webController?.getUrl()}",
                ),
              ),
              onProgressChanged: (controller, progress) {
                searchProviderW.isProcess(progress / 100);
              },
              onWebViewCreated: (controller) {
                searchProviderW.webController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}

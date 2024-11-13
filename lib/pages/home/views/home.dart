import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_app/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider homeProviderW;
  late HomeProvider homeProviderR;
  InAppWebViewController? webController;
  @override
  void initState() {
    context.read<HomeProvider>().checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeProviderW = context.watch<HomeProvider>();
    homeProviderR = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Browser"),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              webController!.goBack();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              webController!.reload();
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () {
              webController!.goForward();
            },
          ),
          PopupMenuButton(
            onSelected: (val) {
              homeProviderW.isSelected = val;
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text("Google"),
                ),
                const PopupMenuItem(
                  child: Text("Bing"),
                ),
                const PopupMenuItem(
                  child: Text("Yahoo"),
                ),
              ];
            },
          ),
        ],
      ),
      body: (homeProviderW.isConnect)
          ? Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                LinearProgressIndicator(
                  value: homeProviderW.progress,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri(
                          "https://www.google.com/",
                        ),
                      ),
                      onProgressChanged: (controller, progress) {
                        homeProviderR.isProcess(progress / 100);
                      },
                      onWebViewCreated: (controller) {
                        webController = controller;
                      },
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Icon(
                Icons.wifi_off_outlined,
                size: 50,
              ),
            ),
    );
  }
}

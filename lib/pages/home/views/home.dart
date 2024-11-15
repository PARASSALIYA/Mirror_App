import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_app/pages/home/provider/home_provider.dart';

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
      appBar: (homeProviderW.isConnect)
          ? AppBar(
              title: const Text("My Browser"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    homeProviderW.webController!.goBack();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    homeProviderW.webController!.reload();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    homeProviderW.webController!.goForward();
                  },
                ),
                PopupMenuButton(
                  onSelected: (val) {
                    if (val == 0) {
                      homeProviderW.webController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.google.com/"),
                        ),
                      );
                    } else if (val == 1) {
                      homeProviderW.webController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.bing.com/"),
                        ),
                      );
                    } else if (val == 2) {
                      homeProviderW.webController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.yahoo.com/"),
                        ),
                      );
                    } else if (val == 3) {
                      homeProviderW.webController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://duckduckgo.com/"),
                        ),
                      );
                    } else if (val == 4) {
                      homeProviderW.webController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://brave.com/en-in/"),
                        ),
                      );
                    } else if (val == 4) {
                      homeProviderW.webController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.bing.com/"),
                        ),
                      );
                    } else {
                      homeProviderW.webController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.bing.com/"),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 0,
                        child: Text("Google"),
                      ),
                      const PopupMenuItem(
                        value: 1,
                        child: Text("Bing"),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text("Yahoo"),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        child: Text("Duck Duck Go"),
                      ),
                      const PopupMenuItem(
                        value: 4,
                        child: Text("Brave"),
                      ),
                      const PopupMenuItem(
                        value: 5,
                        child: Text("Microsoft Edge"),
                      ),
                    ];
                  },
                ),
              ],
            )
          : null,
      body: (homeProviderW.isConnect)
          ? Column(
              children: [
                LinearProgressIndicator(
                  value: homeProviderW.progress,
                ),
                Expanded(
                  child: InAppWebView(
                    // pullToRefreshController: pullToRefreshController,
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                        "${homeProviderW.webController == null ? "https://www.google.com/" : homeProviderW.webController?.getUrl()}",
                      ),
                    ),
                    onProgressChanged: (controller, progress) {
                      homeProviderR.isProcess(progress / 100);
                    },
                    onWebViewCreated: (controller) {
                      homeProviderW.webController = controller;
                    },
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

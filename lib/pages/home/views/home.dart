import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:mirror_app/utils/routes.dart';
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
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    context.read<HomeProvider>().checkConnection();
    context.read<HomeProvider>().checkIndex();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            onRefresh: () {
              if (defaultTargetPlatform == TargetPlatform.android) {
                context.watch<HomeProvider>().webController!.reload();
              }
              // else if (defaultTargetPlatform == TargetPlatform.iOS) {
              //   context.watch<HomeProvider>().webController!.reload();
              // }
            },
          );
    super.initState();
  }

  String? selectedIndex;
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Search Engines"),
                            content: SizedBox(
                              height: 240,
                              width: 400,
                              child: Column(
                                children: [
                                  RadioMenuButton(
                                    value: 'Google',
                                    groupValue: selectedIndex,
                                    onChanged: (val) {
                                      homeProviderW.webController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url:
                                              WebUri("https://www.google.com/"),
                                        ),
                                      );
                                      String url = "https://www.google.com/";
                                      homeProviderR.selectIndex(url);
                                      selectedIndex = val;
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Google"),
                                  ),
                                  RadioMenuButton(
                                    value: 'Bing',
                                    groupValue: selectedIndex,
                                    onChanged: (val) {
                                      homeProviderW.webController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: WebUri("https://www.bing.com/"),
                                        ),
                                      );
                                      String url = "https://www.bing.com/";
                                      homeProviderR.selectIndex(url);
                                      selectedIndex = val;
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Bing"),
                                  ),
                                  RadioMenuButton(
                                    value: 'Yahoo',
                                    groupValue: selectedIndex,
                                    onChanged: (val) {
                                      homeProviderW.webController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: WebUri("https://www.yahoo.com/"),
                                        ),
                                      );
                                      String url = "https://www.yahoo.com/";
                                      homeProviderR.selectIndex(url);
                                      selectedIndex = val;
                                      url = "https://www.yahoo.com/";
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yahoo"),
                                  ),
                                  RadioMenuButton(
                                    value: 'Duck Duck Go',
                                    groupValue: selectedIndex,
                                    onChanged: (val) {
                                      homeProviderW.webController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url:
                                              WebUri("https://duckduckgo.com/"),
                                        ),
                                      );
                                      String? url = "https://duckduckgo.com/";
                                      homeProviderR.selectIndex(url);
                                      selectedIndex = val;
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Duck Duck Go"),
                                  ),
                                  RadioMenuButton(
                                    value: 'Brave',
                                    groupValue: selectedIndex,
                                    onChanged: (val) {
                                      homeProviderW.webController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: WebUri(
                                              "https://brave.com/en-in/"),
                                        ),
                                      );
                                      selectedIndex = val;
                                      String url = "https://brave.com/en-in/";
                                      homeProviderR.selectIndex(url);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Brave"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    if (val == 1) {
                      Navigator.pushNamed(context, Routes.searchhistory);
                    }

                    if (val == 2) {
                      Navigator.pushNamed(context, Routes.settingpage);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 0,
                        child: Text("Search Engine"),
                      ),
                      const PopupMenuItem(
                        value: 1,
                        child: Text("Search History"),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text("Setting"),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        onSubmitted: (val) {
                          var url = WebUri(val);
                          context.read<HomeProvider>().webController?.loadUrl(
                                urlRequest: URLRequest(
                                  url: WebUri(
                                      "https://www.google.com/search?q=$val"),
                                ),
                              );

                          homeProviderR.setSearch(val);
                          homeProviderR.setBookMark(val);
                        },
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.link_sharp),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                        "${homeProviderW.webController == null ? homeProviderW.url : homeProviderW.webController?.getUrl()}",
                      ),
                    ),
                    onProgressChanged: (controller, progress) {
                      homeProviderR.isProcess(progress / 100);

                      if (progress == 100) {
                        pullToRefreshController!.endRefreshing();
                      }
                    },
                    onWebViewCreated: (controller) {
                      homeProviderW.webController = controller;
                    },
                    pullToRefreshController: pullToRefreshController,
                    onLoadStop: (controller, url) {
                      pullToRefreshController!.endRefreshing();
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Icon(Icons.wifi_off, size: 100),
            ),
    );
  }
}

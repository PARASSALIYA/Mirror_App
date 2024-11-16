import 'package:flutter/material.dart';
import 'package:mirror_app/utils/routes.dart';
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
                                      selectedIndex = val;
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
                  child: TextField(
                    onSubmitted: (val) {
                      var url = WebUri(val);
                      context.read<HomeProvider>().webController?.loadUrl(
                            urlRequest: URLRequest(
                              url: WebUri(
                                  "https://www.google.com/search?q=$val"),
                            ),
                          );
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
                Expanded(
                  child: InAppWebView(
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
                    pullToRefreshController: PullToRefreshController(
                      onRefresh: () {
                        webController?.reload();
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

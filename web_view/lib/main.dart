import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(),
      child: Scaffold(
          body: SafeArea(
        child: WebViewWidget(
            controller: controller = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {},
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse('https://pub.dev'))),
      )),
    );
  }

  Future<bool> _willPopCallback() async {
    WebViewController webViewController = controller;
    bool canNavigate = await webViewController.canGoBack();
    if (canNavigate) {
      webViewController.goBack();
      return false;
    } else {
      return true;
    }
  }
}

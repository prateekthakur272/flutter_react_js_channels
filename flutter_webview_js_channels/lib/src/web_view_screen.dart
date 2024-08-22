import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  final WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    webViewController.loadRequest(Uri.parse('http://localhost:5173'));
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.addJavaScriptChannel('TokenChannel', onMessageReceived: (JavaScriptMessage message) {
      log('Received message from React: ${message.message}');
    },);
    webViewController.setOnConsoleMessage((message) {
      log('JS_CONSOLE: ${message.message}');
    });
    String token = 'hgjfhmgfm';
    NavigationDelegate navigationDelegate = NavigationDelegate(
      onPageFinished: (url){
        webViewController.runJavaScript("window.receiveToken('$token');");
      }
    );
    webViewController.setNavigationDelegate(navigationDelegate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('React app')
      ),
      body: WebViewWidget(controller: webViewController,),
    );
  }
}

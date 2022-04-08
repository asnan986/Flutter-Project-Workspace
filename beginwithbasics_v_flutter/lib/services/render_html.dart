import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RenderHtml extends StatefulWidget {
  final String code;
  RenderHtml({this.code});
  @override
  _RenderHtmlState createState() => _RenderHtmlState(code);
}

class _RenderHtmlState extends State<RenderHtml> {
  String code;
  WebViewController _controller;
  _RenderHtmlState(this.code);

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: '',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController controller){
        _controller=controller;
        _controller.loadUrl(Uri.dataFromString(code,encoding: Encoding.getByName('utf-8'),mimeType: 'text/html').toString());
      },
    );
  }
}

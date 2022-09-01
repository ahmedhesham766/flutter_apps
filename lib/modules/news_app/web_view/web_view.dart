import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web_Screen extends StatelessWidget {
  late final String url;
  Web_Screen(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News App')),
      body: WebView(
          initialUrl: url
      ),
    );
  }
}

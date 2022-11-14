import 'package:flutter/material.dart';
import 'package:pistachio/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReleaseNotePage extends StatelessWidget {
  const ReleaseNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: releaseNoteUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
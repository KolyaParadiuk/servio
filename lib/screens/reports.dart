import 'dart:io';

import 'package:flutter/material.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/components/drawer.dart';
import 'package:servio/models/report.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReportsPage extends StatefulWidget {
  final Report report;
  ReportsPage(this.report);
  @override
  ReportsPageState createState() => ReportsPageState();
}

class ReportsPageState extends State<ReportsPage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    Preferences prefs = locator<Preferences>();
    final reportUrl = '${prefs.getServerAddress()}/template/get/${widget.report.id}';
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(widget.report.name),
      ),
      body: Stack(
        children: [
          WebView(
            onWebResourceError: (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(hours: 1),
                content: Text('Возникла ошибка при загрузке страницы!\n${e.description}'),
              ));
            },
            initialUrl: reportUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}

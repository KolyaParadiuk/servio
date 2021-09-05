import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/components/drawer.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReportsPage extends StatefulWidget {
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
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(tr(AppStrings.reports)),
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
            initialUrl: 'https://demo.servio.support/WD/Reports/GenerateReport?id=30&simple=true',
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

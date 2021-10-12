import 'package:flutter/material.dart';
import 'package:servio/app/app_update.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/constants/app_colors.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class AppNeedUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _url = AppUpdateConst.STORE_URL;
    return Scaffold(
      body: Container(
          child: Center(
        child: TextButton(
          onPressed: () async {
            if (await canLaunch(_url)) await launch(_url);
          },
          style: TextButton.styleFrom(backgroundColor: kMain, padding: EdgeInsets.all(18)),
          child: Text(tr(AppStrings.updateApp),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
        ),
      )),
    );
  }
}

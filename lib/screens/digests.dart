import 'package:flutter/material.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/components/drawer.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DigestsScreen extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(tr(AppStrings.digests)),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
        ),
      ),
    );
  }
}

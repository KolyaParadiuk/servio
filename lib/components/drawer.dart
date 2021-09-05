import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/drawer_bloc/drawer_bloc.dart';
import 'package:servio/constants/app_routes.dart';
import 'package:servio/constants/app_strings.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.show_chart_rounded,
              text: tr(AppStrings.digests),
              onTap: () {
                Get.back();
                Get.offNamed(RoutePaths.digests);
              }),
          _createDrawerItem(
              icon: Icons.report,
              text: tr(AppStrings.reports),
              onTap: () {
                Get.back();
                Get.toNamed(RoutePaths.reports);
              }),
          _createDrawerItem(
              icon: Icons.settings,
              text: tr(AppStrings.settings),
              onTap: () {
                Get.back();
                Get.offNamed(RoutePaths.settings);
              }),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: tr(AppStrings.exit),
              onTap: () {
                BlocProvider.of<DrawerBloc>(context).add(ExitEvent(context));
              }),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.blue[900],
      ),
      child: Center(
          child: Text("SERVIO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
              ))),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

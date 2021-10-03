import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/drawer_bloc/drawer_bloc.dart';
import 'package:servio/components/drawer_reports_group.dart';
import 'package:servio/constants/app_colors.dart';
import 'package:servio/constants/app_routes.dart';
import 'package:servio/constants/app_strings.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
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
              _buildReportsList(state),
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
      },
    );
  }

  Widget _buildReportsList(state) {
    if (state is ReportsLoaded) {
      return Column(
        children: state.reports.where((r) => r.parentId == null).map((e) => ReportsGroup(e, state.reports)).toList(),
      );
    }
    return ExpansionPanelList(children: []);
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: kMain,
      ),
      child: Center(
          child: Text(
        "SERVIO",
        style: GoogleFonts.audiowide(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 32.sp,
          ),
        ),
      )),
    );
  }

  Widget _createDrawerItem({
    IconData? icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon == null ? Container() : Icon(icon),
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

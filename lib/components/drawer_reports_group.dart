import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servio/constants/app_routes.dart';
import 'package:servio/models/report.dart';

class ReportsGroup extends StatefulWidget {
  final Report parent;
  final List<Report> reports;
  ReportsGroup(this.parent, this.reports);
  @override
  _ReportsGroupState createState() => _ReportsGroupState();
}

class _ReportsGroupState extends State<ReportsGroup> {
  bool _expanded = false;
  @override
  build(BuildContext context) {
    return (ExpansionPanelList(
      children: [
        ExpansionPanel(
          isExpanded: _expanded,
          canTapOnHeader: true,
          headerBuilder: (context, isOpened) => _createDrawerItem(text: widget.parent.name),
          body: Container(
            child: Column(
              children: widget.reports
                  .where((r) => r.parentId == widget.parent.id)
                  .map((e) => _createDrawerItem(
                        text: e.name,
                        onTap: () {
                          Get.offAndToNamed(RoutePaths.reports, arguments: e);
                        },
                      ))
                  .toList(),
            ),
          ),
        )
      ],
      expansionCallback: (panelIndex, isExpanded) {
        _expanded = !_expanded;
        setState(() {});
      },
    ));
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

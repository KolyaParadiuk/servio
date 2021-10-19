import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final String title;
  final String subTitle;

  GroupedBarChart({
    required this.seriesList,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: false,
      barGroupingType: charts.BarGroupingType.grouped,
      barRendererDecorator: new charts.BarLabelDecorator<String>(
        labelPadding: 2,
        outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 7),
      ),
      domainAxis: new charts.OrdinalAxisSpec(),
      behaviors: [
        new charts.ChartTitle(title,
            subTitle: subTitle,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18,
            subTitleStyleSpec: charts.TextStyleSpec(
              fontSize: 20,
            ),
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 24,
            )),
      ],
    );
  }
}

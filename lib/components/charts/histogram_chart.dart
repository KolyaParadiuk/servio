import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;
  final String title;

  GroupedBarChart(
    this.seriesList, {
    this.animate,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
      behaviors: [
        new charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          desiredMaxColumns: 2,
          defaultHiddenSeries: [],
        ),
        new charts.ChartTitle(title,
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

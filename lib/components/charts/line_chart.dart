import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DigestLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;
  final String title;
  final String subTitle;

  DigestLineChart({
    required this.seriesList,
    required this.title,
    required this.subTitle,
    this.animate,
  });

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
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
          new charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
            desiredMaxRows: 2,
            defaultHiddenSeries: [],
          ),
        ],
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }
}

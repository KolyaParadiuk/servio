import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servio/components/charts/custom_circle_symbol_renderer.dart';
import 'package:servio/utils/date.dart';

class DigestLineChart extends StatefulWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;
  final String title;
  final String subTitle;
  static String? selectedValue;
  static String? selectedDate;

  DigestLineChart({
    required this.seriesList,
    required this.title,
    required this.subTitle,
    this.animate,
  });

  @override
  _DigestLineChartState createState() => _DigestLineChartState();
}

class _DigestLineChartState extends State<DigestLineChart> {
  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(widget.seriesList,
        animate: false, // widget.animate,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        behaviors: [
          charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.tapAndDrag,
          ),
          new charts.ChartTitle(widget.title,
              subTitle: widget.subTitle,
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
            desiredMaxColumns: 3,
            defaultHiddenSeries: [],
          ),
          charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer(),
          )
        ],
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  DigestLineChart.selectedValue =
                      model.selectedSeries[0].measureFn(model.selectedDatum[0].index)?.toStringAsFixed(2);
                  DigestLineChart.selectedDate =
                      formatForInputField(model.selectedSeries[0].domainFn(model.selectedDatum[0].index));
                }
              })
        ],
        defaultRenderer: new charts.LineRendererConfig(includePoints: true),
        domainAxis: new charts.DateTimeAxisSpec(
          showAxisLine: true,
          renderSpec: charts.SmallTickRendererSpec(
            labelRotation: 45,
            // labelRotation: -90,
            // labelAnchor: charts.TickLabelAnchor.before,
          ),
          tickFormatterSpec: charts.BasicDateTimeTickFormatterSpec.fromDateFormat(DateFormat("MM/dd")),
          // tickProviderSpec: charts.AutoDateTimeTickProviderSpec(),
        ));
  }
}

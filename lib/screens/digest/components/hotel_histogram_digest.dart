import 'package:flutter/material.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/components/charts/histogram_chart.dart';
import 'package:servio/components/loading.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:servio/models/digest.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HotelHistogramDigestChart extends StatelessWidget {
  final List<HotelDigest> digests;
  final bool loading;
  HotelHistogramDigestChart({
    required this.digests,
    required this.loading,
  });
  @override
  build(BuildContext context) {
    return (Expanded(
      child: loading
          ? Loading()
          : GroupedBarChart(
              _createSeries(),
              title: tr(AppStrings.hotels),
            ),
    ));
  }

  List<charts.Series<HotelDigest, String>> _createSeries() {
    return [
      new charts.Series<HotelDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#424852"),
        id: tr(AppStrings.income),
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).dwellingPayment,
        labelAccessorFn: (HotelDigest d, _) =>
            '${d.data.firstWhere((dd) => dd.isShadow == false).dwellingPayment.toInt()}',
        data: digests,
      ),
      new charts.Series<HotelDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#D56FAC"),
        id: tr(AppStrings.loading),
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) {
          final l = d.data.firstWhere((dd) => dd.isShadow == false).loading;
          if (l is num) return l;
          return 0;
        },
        labelAccessorFn: (HotelDigest d, _) => '${d.data.firstWhere((dd) => dd.isShadow == false).loading}',
        data: digests,
      ),
      new charts.Series<HotelDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#4A88DA"),
        id: tr(AppStrings.averageRate),
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).sot,
        labelAccessorFn: (HotelDigest d, _) => '${d.data.firstWhere((dd) => dd.isShadow == false).sot}',
        data: digests,
      ),
      new charts.Series<HotelDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#89C053"),
        id: tr(AppStrings.incomeFromRoom),
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).avrOnAllRoom,
        labelAccessorFn: (HotelDigest d, _) =>
            '${d.data.firstWhere((dd) => dd.isShadow == false).avrOnAllRoom.toInt()}',
        data: digests,
      ),
      new charts.Series<HotelDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#F5B945"),
        id: tr(AppStrings.roomsOccupied),
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).roomsOccupied,
        labelAccessorFn: (HotelDigest d, _) => '${d.data.firstWhere((dd) => dd.isShadow == false).roomsOccupied}',
        data: digests,
      ),
      new charts.Series<HotelDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#D94452"),
        id: tr(AppStrings.roomsInExploitation),
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).roomsInExploitation,
        labelAccessorFn: (HotelDigest d, _) => '${d.data.firstWhere((dd) => dd.isShadow == false).roomsInExploitation}',
        data: digests,
      ),
    ];
  }
}

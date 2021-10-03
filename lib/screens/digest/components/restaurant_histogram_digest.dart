import 'package:flutter/material.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/components/charts/histogram_chart.dart';
import 'package:servio/components/loading.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:servio/models/digest.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RestaurantHistogramDigestChart extends StatelessWidget {
  final List<RestaurantDigest> digests;
  final bool loading;
  RestaurantHistogramDigestChart({
    required this.digests,
    required this.loading,
  });
  @override
  build(BuildContext context) {
    return (Expanded(
      child: loading ? Loading() : GroupedBarChart(_createSeries(), title: tr(AppStrings.restaurants)),
    ));
  }

  List<charts.Series<RestaurantDigest, String>> _createSeries() {
    return [
      new charts.Series<RestaurantDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#D56FAC"),
        id: tr(AppStrings.income),
        domainFn: (RestaurantDigest d, _) => d.title,
        measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).proceeds,
        data: digests,
        labelAccessorFn: (RestaurantDigest d, _) =>
            '${d.data.firstWhere((dd) => dd.isShadow == false).proceeds.toInt()}',
      ),
      new charts.Series<RestaurantDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#4A88DA"),
        id: tr(AppStrings.averageInvoiceAmountShort),
        domainFn: (RestaurantDigest d, _) => d.title,
        measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).billTotal,
        labelAccessorFn: (RestaurantDigest d, _) =>
            '${d.data.firstWhere((dd) => dd.isShadow == false).billTotal.toInt()}',
        data: digests,
      ),
      new charts.Series<RestaurantDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#89C053"),
        id: tr(AppStrings.averageAmountPerGuestShort),
        domainFn: (RestaurantDigest d, _) => d.title,
        measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).guestTotal,
        labelAccessorFn: (RestaurantDigest d, _) =>
            '${d.data.firstWhere((dd) => dd.isShadow == false).guestTotal.toInt()}',
        data: digests,
      ),
      new charts.Series<RestaurantDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#F5B945"),
        id: tr(AppStrings.bills),
        domainFn: (RestaurantDigest d, _) => d.title,
        measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).billsCount,
        labelAccessorFn: (RestaurantDigest d, _) =>
            '${d.data.firstWhere((dd) => dd.isShadow == false).billsCount.toInt()}',
        data: digests,
      ),
      new charts.Series<RestaurantDigest, String>(
        seriesColor: charts.Color.fromHex(code: "#D94452"),
        id: tr(AppStrings.guests),
        domainFn: (RestaurantDigest d, _) => d.title,
        measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).guestsCount,
        labelAccessorFn: (RestaurantDigest d, _) =>
            '${d.data.firstWhere((dd) => dd.isShadow == false).guestsCount.toInt()}',
        data: digests,
      ),
    ];
  }
}

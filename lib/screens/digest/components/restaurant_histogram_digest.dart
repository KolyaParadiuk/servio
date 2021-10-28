import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/digests_bloc/digests_bloc.dart';
import 'package:servio/components/charts/histogram_chart.dart';
import 'package:servio/components/loading.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:servio/screens/digest/components/charts_page_view.dart';
import 'package:servio/utils/num.dart';

class RestaurantHistogramDigestChart extends StatelessWidget {
  final List<RestaurantDigest> digests;
  final bool loading;
  RestaurantHistogramDigestChart({
    required this.digests,
    required this.loading,
  });
  @override
  build(BuildContext context) {
    final bloc = BlocProvider.of<DigestsBloc>(context);

    return (digests.length == 0 && !loading
        ? SizedBox.shrink()
        : Expanded(
            child: ChartsPageView(loading: loading, children: [
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.income),
                  seriesList: _createSeries(
                    id: tr(AppStrings.income),
                    // labelAccessorFn: (RestaurantDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).proceeds.toStringFixedWithThousandSeparators()}',
                    dataSources: bloc.dataSources,
                    measureFn: (RestaurantDigestData d) => d.proceeds,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.averageInvoiceAmount),
                  seriesList: _createSeries(
                    id: tr(AppStrings.averageInvoiceAmount),
                    dataSources: bloc.dataSources,
                    // labelAccessorFn: (RestaurantDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).billTotal.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigestData d) => d.billTotal,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.averageAmountPerGuest),
                  seriesList: _createSeries(
                    id: tr(AppStrings.averageAmountPerGuest),
                    dataSources: bloc.dataSources,
                    // labelAccessorFn: (RestaurantDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).guestTotal.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigestData d) => d.guestTotal,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.bills),
                  seriesList: _createSeries(
                    id: tr(AppStrings.bills),
                    dataSources: bloc.dataSources,
                    // labelAccessorFn: (RestaurantDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).billsCount.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigestData d) => d.billsCount,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.guests),
                  seriesList: _createSeries(
                    id: tr(AppStrings.guests),
                    dataSources: bloc.dataSources,
                    // labelAccessorFn: (RestaurantDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).guestsCount.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigestData d) => d.guestsCount,
                  )),
            ]),
          ));
  }

  List<charts.Series<RestaurantDigest, String>> _createSeries({
    required num? Function(RestaurantDigestData) measureFn,
    required List<DataSource> dataSources,
    required String id,
  }) {
    return [
      new charts.Series<RestaurantDigest, String>(
        colorFn: (RestaurantDigest d, _) {
          final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color;
          return charts.Color(r: c.red, g: c.green, b: c.blue).lighter.lighter.lighter;
        },
        seriesCategory: 'shadow',
        id: id,
        domainFn: (RestaurantDigest d, _) => d.title,
        fillPatternFn: (RestaurantDigest sales, _) => charts.FillPatternType.forwardHatch,
        measureFn: (RestaurantDigest d, _) => measureFn(d.data.firstWhere((dd) => dd.isShadow == true)),
        labelAccessorFn: (RestaurantDigest d, _) =>
            measureFn(d.data.firstWhere((dd) => dd.isShadow == true))?.toStringFixedWithThousandSeparators() ?? "",
        data: digests,
        insideLabelStyleAccessorFn: (RestaurantDigest d, _) {
          return new charts.TextStyleSpec(color: charts.MaterialPalette.black);
        },
      ),
      new charts.Series<RestaurantDigest, String>(
        colorFn: (RestaurantDigest d, _) {
          final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color;
          return charts.Color(r: c.red, g: c.green, b: c.blue);
        },
        insideLabelStyleAccessorFn: (RestaurantDigest d, _) {
          return new charts.TextStyleSpec(color: charts.MaterialPalette.black);
        },
        id: id,
        seriesCategory: 'real',
        domainFn: (RestaurantDigest d, _) => d.title,
        measureFn: (RestaurantDigest d, _) => measureFn(d.data.firstWhere((dd) => dd.isShadow == false)), // measureFn,
        labelAccessorFn: (RestaurantDigest d, _) =>
            measureFn(d.data.firstWhere((dd) => dd.isShadow == false))?.toStringFixedWithThousandSeparators() ?? "",
        data: digests,
      ),
    ];
  }
}

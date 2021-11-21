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

  List<charts.Series<RestaurantDigestData, String>> _createSeries({
    required num? Function(RestaurantDigestData) measureFn,
    required List<DataSource> dataSources,
    required String id,
  }) {
    final List<RestaurantDigestData> data = [];
    final List<RestaurantDigestData> shadowData = [];

    digests.forEach((d) {
      d.data.forEach((dd) {
        if (dd.isShadow == true)
          shadowData.add(dd);
        else
          data.add(dd);
      });
    });
    return [
      new charts.Series<RestaurantDigestData, String>(
        colorFn: (RestaurantDigestData d, _) {
          final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalID).color;
          return charts.Color(r: c.red, g: c.green, b: c.blue).lighter.lighter.lighter;
        },
        seriesCategory: 'shadow',
        id: id,
        domainFn: (RestaurantDigestData d, _) => dataSources.firstWhere((ds) => ds.id == d.baseExternalID).name,
        fillPatternFn: (RestaurantDigestData sales, _) => charts.FillPatternType.forwardHatch,
        measureFn: (RestaurantDigestData d, _) => measureFn(d),
        labelAccessorFn: (RestaurantDigestData d, _) => measureFn(d)?.toStringFixedWithThousandSeparators() ?? "",
        data: shadowData,
        insideLabelStyleAccessorFn: (RestaurantDigestData d, _) {
          return new charts.TextStyleSpec(color: charts.MaterialPalette.black);
        },
      ),
      new charts.Series<RestaurantDigestData, String>(
        colorFn: (RestaurantDigestData d, _) {
          final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalID).color;
          return charts.Color(r: c.red, g: c.green, b: c.blue);
        },
        insideLabelStyleAccessorFn: (RestaurantDigestData d, _) {
          return new charts.TextStyleSpec(color: charts.MaterialPalette.black);
        },
        id: id,
        seriesCategory: 'real',
        domainFn: (RestaurantDigestData d, _) => dataSources.firstWhere((ds) => ds.id == d.baseExternalID).name,
        measureFn: (RestaurantDigestData d, _) => measureFn(d), // measureFn,
        labelAccessorFn: (RestaurantDigestData d, _) => measureFn(d)?.toStringFixedWithThousandSeparators() ?? "",
        data: data,
      ),
    ];
  }
}

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
                    labelAccessorFn: (RestaurantDigest d, _) =>
                        '${d.data.firstWhere((dd) => dd.isShadow == false).proceeds.toStringFixedWithThousandSeparators()}',
                    dataSources: bloc.dataSources,
                    measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).proceeds,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.averageInvoiceAmount),
                  seriesList: _createSeries(
                    id: tr(AppStrings.averageInvoiceAmount),
                    dataSources: bloc.dataSources,
                    labelAccessorFn: (RestaurantDigest d, _) =>
                        '${d.data.firstWhere((dd) => dd.isShadow == false).billTotal.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).billTotal,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.averageAmountPerGuest),
                  seriesList: _createSeries(
                    id: tr(AppStrings.averageAmountPerGuest),
                    dataSources: bloc.dataSources,
                    labelAccessorFn: (RestaurantDigest d, _) =>
                        '${d.data.firstWhere((dd) => dd.isShadow == false).guestTotal.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).guestTotal,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.bills),
                  seriesList: _createSeries(
                    id: tr(AppStrings.bills),
                    dataSources: bloc.dataSources,
                    labelAccessorFn: (RestaurantDigest d, _) =>
                        '${d.data.firstWhere((dd) => dd.isShadow == false).billsCount.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).billsCount,
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.restaurants),
                  subTitle: tr(AppStrings.guests),
                  seriesList: _createSeries(
                    id: tr(AppStrings.guests),
                    dataSources: bloc.dataSources,
                    labelAccessorFn: (RestaurantDigest d, _) =>
                        '${d.data.firstWhere((dd) => dd.isShadow == false).guestsCount.toStringFixedWithThousandSeparators()}',
                    measureFn: (RestaurantDigest d, _) => d.data.firstWhere((dd) => dd.isShadow == false).guestsCount,
                  )),
            ]),
          ));
  }

  List<charts.Series<RestaurantDigest, String>> _createSeries(
      {required num? Function(RestaurantDigest, int?) measureFn,
      required List<DataSource> dataSources,
      required String id,
      String Function(RestaurantDigest, int?)? labelAccessorFn}) {
    return [
      new charts.Series<RestaurantDigest, String>(
        colorFn: (RestaurantDigest d, _) {
          final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color;
          return charts.Color(r: c.red, g: c.green, b: c.blue);
        },
        id: id,
        domainFn: (RestaurantDigest d, _) => d.title,
        measureFn: measureFn,
        labelAccessorFn: labelAccessorFn,
        data: digests,
      ),
    ];
  }
}

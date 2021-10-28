import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/digests_bloc/digests_bloc.dart';
import 'package:servio/components/charts/histogram_chart.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:servio/screens/digest/components/charts_page_view.dart';
import 'package:servio/utils/num.dart';

class HotelHistogramDigestChart extends StatelessWidget {
  final List<HotelDigest> digests;
  final bool loading;
  HotelHistogramDigestChart({
    required this.digests,
    required this.loading,
  });
  @override
  build(BuildContext context) {
    final bloc = BlocProvider.of<DigestsBloc>(context);

    return (digests.length == 0 && !loading
        ? SizedBox.shrink()
        : Expanded(
            child: ChartsPageView(
            loading: loading,
            children: [
              GroupedBarChart(
                  title: tr(AppStrings.hotels),
                  subTitle: tr(AppStrings.income),
                  seriesList: _createSeries(
                    id: tr(AppStrings.income),
                    dataSources: bloc.dataSources,
                    measureFn: (HotelDigestData d) => d.dwellingPayment,
                    // labelAccessorFn: (HotelDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).dwellingPayment.toStringFixedWithThousandSeparators()}',
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.hotels),
                  subTitle: tr(AppStrings.loading),
                  seriesList: _createSeries(
                    id: tr(AppStrings.loading),
                    dataSources: bloc.dataSources,
                    measureFn: (HotelDigestData d) {
                      final l = d.loading;
                      if (l is num) return l;
                      return 0;
                    },
                    // labelAccessorFn: (HotelDigest d, _) {
                    //   final l = d.data.firstWhere((dd) => dd.isShadow == false).loading;
                    //   if (l is num)
                    //     return '${(d.data.firstWhere((dd) => dd.isShadow == false).loading as double).toStringWithThousandSeparators()}';
                    //   return '0';
                    // },
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.hotels),
                  subTitle: tr(AppStrings.averageRate),
                  seriesList: _createSeries(
                    id: tr(AppStrings.averageRate),
                    dataSources: bloc.dataSources,
                    measureFn: (HotelDigestData d) => d.sot,
                    // labelAccessorFn: (HotelDigest d, _) {
                    //   return '${d.data.firstWhere((dd) => dd.isShadow == false).sot?.toStringWithThousandSeparators()}';
                    // },
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.hotels),
                  subTitle: tr(AppStrings.incomeFromRoom),
                  seriesList: _createSeries(
                    id: tr(AppStrings.incomeFromRoom),
                    dataSources: bloc.dataSources,
                    measureFn: (HotelDigestData d) => d.avrOnAllRoom,
                    // labelAccessorFn: (HotelDigest d, _) =>
                    // '${d.data.firstWhere((dd) => dd.isShadow == false).avrOnAllRoom.toStringFixedWithThousandSeparators()}',
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.hotels),
                  subTitle: tr(AppStrings.roomsOccupied),
                  seriesList: _createSeries(
                    id: tr(AppStrings.roomsOccupied),
                    dataSources: bloc.dataSources,
                    measureFn: (HotelDigestData d) => d.roomsOccupied,
                    // labelAccessorFn: (HotelDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).roomsOccupied.toStringFixedWithThousandSeparators()}',
                  )),
              GroupedBarChart(
                  title: tr(AppStrings.hotels),
                  subTitle: tr(AppStrings.roomsInExploitation),
                  seriesList: _createSeries(
                    id: tr(AppStrings.roomsInExploitation),
                    dataSources: bloc.dataSources,
                    measureFn: (HotelDigestData d) => d.roomsInExploitation,
                    // labelAccessorFn: (HotelDigest d, _) =>
                    //     '${d.data.firstWhere((dd) => dd.isShadow == false).roomsInExploitation.toStringFixedWithThousandSeparators()}',
                  )),
            ],
          )));
  }

  List<charts.Series<HotelDigest, String>> _createSeries({
    required num? Function(HotelDigestData) measureFn,
    required List<DataSource> dataSources,
    required String id,
    // String Function(HotelDigest, int?)? labelAccessorFn,
  }) {
    return [
      new charts.Series<HotelDigest, String>(
        colorFn: (HotelDigest d, _) {
          final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color;
          return charts.Color(r: c.red, g: c.green, b: c.blue).lighter.lighter.lighter;
        },
        id: id,
        fillPatternFn: (HotelDigest sales, _) => charts.FillPatternType.forwardHatch,
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) => measureFn(d.data.firstWhere((dd) => dd.isShadow == true)),
        labelAccessorFn: (HotelDigest d, _) =>
            measureFn(d.data.firstWhere((dd) => dd.isShadow == true))?.toStringFixedWithThousandSeparators() ?? "",
        data: digests,
        insideLabelStyleAccessorFn: (HotelDigest d, _) {
          return new charts.TextStyleSpec(color: charts.MaterialPalette.black);
        },
      ),
      new charts.Series<HotelDigest, String>(
        colorFn: (HotelDigest d, _) {
          final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color;
          return charts.Color(r: c.red, g: c.green, b: c.blue);
        },
        id: id,
        domainFn: (HotelDigest d, _) => d.title,
        measureFn: (HotelDigest d, _) => measureFn(d.data.firstWhere((dd) => dd.isShadow == false)),
        labelAccessorFn: (HotelDigest d, _) =>
            measureFn(d.data.firstWhere((dd) => dd.isShadow == false))?.toStringFixedWithThousandSeparators() ?? "",
        data: digests,
        insideLabelStyleAccessorFn: (HotelDigest d, _) {
          return new charts.TextStyleSpec(color: charts.MaterialPalette.black);
        },
      ),
    ];
  }
}

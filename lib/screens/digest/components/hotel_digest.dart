import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/digests_bloc/digests_bloc.dart';
import 'package:servio/components/charts/line_chart.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';
import 'package:servio/screens/digest/components/charts_page_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HotelDigestsChart extends StatelessWidget {
  final List<HotelDigest> digests;
  final bool loading;

  HotelDigestsChart({
    required this.digests,
    required this.loading,
  });

  @override
  build(BuildContext context) {
    final bloc = BlocProvider.of<DigestsBloc>(context);

    return digests.length == 0 && !loading
        ? SizedBox.shrink()
        : Expanded(
            child: ChartsPageView(
              loading: this.loading,
              children: <Widget>[
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: tr(AppStrings.income),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.dwellingPayment,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: tr(AppStrings.loading),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) {
                        if (dd.loading is num) return dd.loading;
                        return 0;
                      },
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: tr(AppStrings.averageRate),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.sot,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: tr(AppStrings.incomeFromRoom),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.avrOnAllRoom,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: tr(AppStrings.roomsOccupied),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.roomsOccupied,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: tr(AppStrings.roomsInExploitation),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.roomsInExploitation,
                    )),
              ],
            ),
          );
  }

  List<charts.Series<HotelDigestData, DateTime>> _createSeries({
    required num? Function(HotelDigestData, int?) measureFn,
    required List<DataSource> dataSources,
  }) {
    final List<charts.Series<HotelDigestData, DateTime>> series = [];
    series.addAll(digests.map((d) {
      final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color; // ?? Colors.indigo;
      final color = charts.Color(r: c.red, g: c.green, b: c.blue);
      return charts.Series<HotelDigestData, DateTime>(
        id: d.title,
        seriesColor: color,
        data: d.data.where((element) => element.isShadow == false).toList(),
        domainFn: (HotelDigestData dd, _) => dd.date,
        measureFn: measureFn,
      );
    }).toList());
    series.addAll(digests.map((d) {
      final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color; // ?? Colors.indigo;
      final color = charts.Color(r: c.red, g: c.green, b: c.blue);
      return charts.Series<HotelDigestData, DateTime>(
        id: d.title + "'",
        seriesColor: color,
        data: d.data.where((element) => element.isShadow == true).toList(),
        domainFn: (HotelDigestData dd, _) => dd.date,
        measureFn: measureFn,
        dashPatternFn: (HotelDigestData sales, _) => [2, 2],
        strokeWidthPxFn: (HotelDigestData sales, _) => 2.0,
      );
    }).toList());
    return series;
  }
}

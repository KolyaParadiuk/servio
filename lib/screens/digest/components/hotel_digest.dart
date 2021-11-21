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
import 'package:servio/utils/num.dart';

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
                    subTitle: _createSubtitle(tr(AppStrings.income), (d) => d.summary.dwellingPayment),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.dwellingPayment,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: _createSubtitle(tr(AppStrings.loading), (d) => d.summary.loading),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) {
                        if (dd.loading is num) return dd.loading;
                        return 0;
                      },
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: _createSubtitle(tr(AppStrings.averageRate), (d) => d.summary.sot ?? 0),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.sot,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: _createSubtitle(tr(AppStrings.incomeFromRoom), (d) => d.summary.avrOnAllRoom),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.avrOnAllRoom,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: _createSubtitle(tr(AppStrings.roomsOccupied), (d) => d.summary.roomsOccupied),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.roomsOccupied,
                    )),
                DigestLineChart(
                    title: tr(AppStrings.hotels),
                    subTitle: _createSubtitle(tr(AppStrings.roomsInExploitation), (d) => d.summary.roomsInExploitation),
                    seriesList: _createSeries(
                      dataSources: bloc.dataSources,
                      measureFn: (HotelDigestData dd, _) => dd.roomsInExploitation,
                    )),
              ],
            ),
          );
  }

  String _createSubtitle(String base, num Function(HotelDigest) fn) {
    return base +
        " (" +
        digests
            .fold(0.0, (previousValue, element) => (previousValue as double) + fn(element))
            .toStringFixedWithThousandSeparators() +
        ")";
  }

  List<charts.Series<HotelDigestData, DateTime>> _createSeries({
    required num? Function(HotelDigestData, int?) measureFn,
    required List<DataSource> dataSources,
  }) {
    final List<charts.Series<HotelDigestData, DateTime>> series = [];

    digests.forEach((d) {
      final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color; // ?? Colors.indigo;
      final color = charts.Color(r: c.red, g: c.green, b: c.blue);
      final data = d.data.where((element) => element.isShadow == false).toList();
      final shadowData = d.data.where((element) => element.isShadow == true).toList();
      if (data.isNotEmpty) {
        series.add(
          charts.Series<HotelDigestData, DateTime>(
            id: d.title,
            seriesColor: color,
            data: data,
            domainFn: (HotelDigestData dd, _) => dd.date!,
            measureFn: measureFn,
          ),
        );
      }
      if (shadowData.isNotEmpty) {
        series.add(
          charts.Series<HotelDigestData, DateTime>(
            id: d.title + "'",
            seriesColor: color,
            data: shadowData,
            domainFn: (HotelDigestData dd, _) => dd.date!,
            measureFn: measureFn,
            dashPatternFn: (HotelDigestData sales, _) => [2, 2],
            strokeWidthPxFn: (HotelDigestData sales, _) => 2.0,
          ),
        );
      }
    });
    return series;
  }
}

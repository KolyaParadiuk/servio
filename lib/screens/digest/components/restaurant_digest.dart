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

class RestaurantDigestChart extends StatelessWidget {
  final List<RestaurantDigest> digests;
  final PageController controller = PageController();
  final bool loading;

  RestaurantDigestChart({
    required this.digests,
    required this.loading,
  });

  @override
  build(BuildContext context) {
    final bloc = BlocProvider.of<DigestsBloc>(context);

    return Expanded(
      child: ChartsPageView(
        loading: this.loading,
        children: <Widget>[
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: tr(AppStrings.income),
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.proceeds,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: tr(AppStrings.averageInvoiceAmount),
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.billTotal,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: tr(AppStrings.averageAmountPerGuest),
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.guestTotal,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: tr(AppStrings.bills),
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.billsCount,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: tr(AppStrings.guests),
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.guestsCount,
              )),
        ],
      ),
    );
  }

  List<charts.Series<RestaurantDigestData, DateTime>> _createSeries({
    required num? Function(RestaurantDigestData, int?) measureFn,
    required List<DataSource> dataSources,
  }) {
    final List<charts.Series<RestaurantDigestData, DateTime>> series = [];
    series.addAll(digests.map((d) {
      final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color; // ?? Colors.indigo;
      final color = charts.Color(r: c.red, g: c.green, b: c.blue);
      return charts.Series<RestaurantDigestData, DateTime>(
        id: d.title,
        seriesColor: color,
        data: d.data.where((element) => element.isShadow == false).toList(),
        domainFn: (RestaurantDigestData dd, _) => dd.closedDate,
        measureFn: measureFn,
      );
    }).toList());
    series.addAll(digests.map((d) {
      final Color c = dataSources.firstWhere((ds) => ds.id == d.baseExternalId).color; // ?? Colors.indigo;
      final color = charts.Color(r: c.red, g: c.green, b: c.blue);
      return charts.Series<RestaurantDigestData, DateTime>(
        id: d.title + "'",
        seriesColor: color,
        data: d.data.where((element) => element.isShadow == true).toList(),
        domainFn: (RestaurantDigestData dd, _) => dd.closedDate,
        measureFn: measureFn,
        dashPatternFn: (RestaurantDigestData sales, _) => [2, 2],
        strokeWidthPxFn: (RestaurantDigestData sales, _) => 2.0,
      );
    }).toList());

    return series;
  }
}

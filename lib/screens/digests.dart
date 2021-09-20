import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/digests_bloc/digests_bloc.dart';
import 'package:servio/components/date_input.dart';
import 'package:servio/components/drawer.dart';
import 'package:servio/components/charts/line_chart.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';

class DigestsScreen extends StatefulWidget {
  @override
  _DigestsScreenState createState() => _DigestsScreenState();
}

class _DigestsScreenState extends State<DigestsScreen> {
  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(tr(AppStrings.digests)),
      ),
      body: BlocBuilder<DigestsBloc, DigestsState>(
        builder: (context, state) {
          if (state is DigestData)
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DateInput(
                          lable: tr(AppStrings.dateFrom),
                          initValue: state.from,
                          onChange: (d) {
                            BlocProvider.of<DigestsBloc>(context).add(ChangeTimeFrom(d));
                          },
                        ),
                        DateInput(
                          lable: tr(AppStrings.dateTo),
                          initValue: state.to,
                          onChange: (d) {
                            BlocProvider.of<DigestsBloc>(context).add(ChangeTimeTo(d));
                          },
                        ),
                      ],
                    ),
                    RestaurantDigestCart(
                      digests: state.restaurantDigest,
                    ),
                    HotelDigestsCart(
                      digests: state.hotelDigest,
                    )
                  ],
                ),
              ),
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class RestaurantDigestCart extends StatelessWidget {
  final List<RestaurantDigest> digests;
  final PageController controller = PageController();

  RestaurantDigestCart({required this.digests});

  @override
  build(BuildContext context) {
    final bloc = BlocProvider.of<DigestsBloc>(context);

    return Expanded(
      child: PageView(
        controller: controller,
        children: <Widget>[
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: "Выручка",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.proceeds,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: "Средняя сумма по счету",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.billTotal,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: "Средняя сумма по гостю",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.guestTotal,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: "Счетов",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (RestaurantDigestData dd, _) => dd.billsCount,
              )),
          DigestLineChart(
              title: tr(AppStrings.restaurants),
              subTitle: "Гостей",
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

class HotelDigestsCart extends StatelessWidget {
  final List<HotelDigest> digests;
  final PageController controller = PageController();

  HotelDigestsCart({required this.digests});

  @override
  build(BuildContext context) {
    final bloc = BlocProvider.of<DigestsBloc>(context);

    return Expanded(
      child: PageView(
        controller: controller,
        children: <Widget>[
          DigestLineChart(
              title: tr(AppStrings.hotels),
              subTitle: "Доход",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (HotelDigestData dd, _) => dd.dwellingPayment,
              )),
          DigestLineChart(
              title: tr(AppStrings.hotels),
              subTitle: "Загрузка",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (HotelDigestData dd, _) => dd.sot,
              )),
          DigestLineChart(
              title: tr(AppStrings.hotels),
              subTitle: "Средний Тариф",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (HotelDigestData dd, _) => dd.dwellingPayment,
              )),
          DigestLineChart(
              title: tr(AppStrings.hotels),
              subTitle: "Доход с номера",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (HotelDigestData dd, _) => dd.avrOnAllRoom,
              )),
          DigestLineChart(
              title: tr(AppStrings.hotels),
              subTitle: "Номеров занято",
              seriesList: _createSeries(
                dataSources: bloc.dataSources,
                measureFn: (HotelDigestData dd, _) => dd.roomsOccupied,
              )),
          DigestLineChart(
              title: tr(AppStrings.hotels),
              subTitle: "Номеров всего",
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
        data: d.data, //.where((element) => element.isShadow == false).toList(),
        domainFn: (HotelDigestData dd, _) => dd.date,
        measureFn: measureFn,
      );
    }).toList());
    // series.addAll(digests
    //     .map((d) => Series<HotelDigestData, DateTime>(
    //           id: id,
    //           colorFn: (_, __) => color,
    //           data: d.data.where((element) => element.isShadow == true).toList(),
    //           domainFn: (RestaurantDigestData dd, _) => dd.closedDate,
    //           measureFn: measureFn,
    //           dashPatternFn: (RestaurantDigestData sales, _) => [2, 2],
    //           strokeWidthPxFn: (RestaurantDigestData sales, _) => 2.0,
    //         ))
    //     .toList());
    return series;
  }
}

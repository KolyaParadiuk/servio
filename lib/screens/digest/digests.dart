import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/digests_bloc/digests_bloc.dart';
import 'package:servio/components/checkbox.dart';
import 'package:servio/components/date_input.dart';
import 'package:servio/components/drawer.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servio/screens/digest/components/hotel_digest.dart';
import 'package:servio/screens/digest/components/hotel_histogram_digest.dart';
import 'package:servio/screens/digest/components/restaurant_digest.dart';
import 'package:servio/screens/digest/components/restaurant_histogram_digest.dart';

class DigestsScreen extends StatefulWidget {
  @override
  _DigestsScreenState createState() => _DigestsScreenState();
}

class _DigestsScreenState extends State<DigestsScreen> {
  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text(tr(AppStrings.digests)), actions: [
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<DigestsBloc>(context).add(LoadDigest());
            })
      ]),
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
                    Column(
                      children: [
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
                        Container(
                          width: 325.w,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              CustomCheckbox(
                                title: tr(AppStrings.day),
                                onChanged: (value) {
                                  BlocProvider.of<DigestsBloc>(context).add(SwitchTodayDigestCheckbox(value ?? false));
                                },
                                isChecked: state.showLastDay,
                              ),
                              CustomCheckbox(
                                title: tr(AppStrings.week),
                                onChanged: (value) {
                                  BlocProvider.of<DigestsBloc>(context).add(SwitchWeekDigestCheckbox(value ?? false));
                                },
                                isChecked: state.showLastWeek,
                              ),
                              CustomCheckbox(
                                title: tr(AppStrings.month),
                                onChanged: (value) {
                                  BlocProvider.of<DigestsBloc>(context).add(SwitchMonthDigestCheckbox(value ?? false));
                                },
                                isChecked: state.showLastMonth,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: state.showLastDay
                            ? [
                                RestaurantHistogramDigestChart(
                                  loading: (state is DataLoading),
                                  digests: state.restaurantDigest,
                                ),
                                HotelHistogramDigestChart(
                                  loading: (state is DataLoading),
                                  digests: state.hotelDigest,
                                ),
                              ]
                            : [
                                RestaurantDigestChart(
                                  loading: (state is DataLoading),
                                  digests: state.restaurantDigest,
                                ),
                                HotelDigestsChart(
                                  loading: (state is DataLoading),
                                  digests: state.hotelDigest,
                                ),
                              ],
                      ),
                    ),
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

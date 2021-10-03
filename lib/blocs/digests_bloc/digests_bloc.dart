import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/constants/value_constants.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';
import 'package:servio/services/network/api_impl.dart';
import 'package:servio/utils/date_time.dart';

part 'digests_event.dart';
part 'digests_state.dart';

class DigestsBloc extends Bloc<DigestsEvent, DigestsState> {
  DigestsBloc() : super(DigestsInitial());
  final api = locator<ImplApi>();
  List<DataSource> dataSources = [];
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  bool showLastDay = false;
  bool showLastWeek = false;
  bool showLastMonth = false;
  @override
  Stream<DigestsState> mapEventToState(
    DigestsEvent event,
  ) async* {
    if (event is LoadDataSources) {
      yield DataLoading();
      dataSources = await api.getDataSources();
      add(LoadDigest());
    } else if (event is LoadDigest) {
      final state = this.state;
      if (state is DigestData)
        yield DataLoading.fromDigestData(state,
            showLastDay: showLastDay, showLastWeek: showLastWeek, showLastMonth: showLastMonth, from: from, to: to);
      else
        DataLoading();
      final List<HotelDigest> hotelDigest = await api.getHotelDigest(from, to, dataSources);
      final List<RestaurantDigest> restaurantDigest = await api.getRestaurantDigest(from, to, dataSources);
      yield DigestData(
        from: from,
        to: to,
        hotelDigest: hotelDigest,
        restaurantDigest: restaurantDigest,
        showLastDay: showLastDay,
        showLastWeek: showLastWeek,
        showLastMonth: showLastMonth,
      );
    } else if (event is ChangeTimeFrom) {
      if (event.date.isBefore(to)) {
        from = event.date;
        switchOffSpecificDigest();
        add(LoadDigest());
      }
    } else if (event is ChangeTimeTo) {
      if (event.date.isAfter(from)) {
        to = event.date;
        switchOffSpecificDigest();
        add(LoadDigest());
      }
    } else if (event is SwitchTodayDigestCheckbox) {
      // from = DateTime.now().copyWith(
      //   hour: 0,
      //   minute: 0,
      // );
      // to = DateTime.now().copyWith(
      //   hour: 23,
      //   minute: 59,
      // );
      from = DateTime.parse("2021-09-17").copyWith(
        hour: 0,
        minute: 0,
      );
      to = DateTime.parse("2021-09-17").copyWith(
        hour: 23,
        minute: 59,
      );
      showLastDay = true;
      showLastWeek = false;
      showLastMonth = false;
      add(LoadDigest());
    } else if (event is SwitchWeekDigestCheckbox) {
      to = DateTime.now();
      from = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - 7 * kMilisecondsInDay);
      showLastDay = false;
      showLastWeek = true;
      showLastMonth = false;
      add(LoadDigest());
    } else if (event is SwitchMonthDigestCheckbox) {
      to = DateTime.now();
      from = DateTime.now().copyWith(month: to.month - 1);
      showLastDay = false;
      showLastWeek = false;
      showLastMonth = true;
      add(LoadDigest());
    }
  }

  switchOffSpecificDigest() {
    showLastDay = false;
    showLastWeek = false;
    showLastMonth = false;
  }
}

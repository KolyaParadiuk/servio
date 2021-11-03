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
  bool showLastDay = true;
  bool showLastWeek = false;
  bool showLastMonth = false;

  bool isOneDay() {
    return from.day == to.day && from.month == to.month && from.year == to.year;
  }

  @override
  Stream<DigestsState> mapEventToState(
    DigestsEvent event,
  ) async* {
    if (event is LoadDataSources) {
      yield DataLoading();
      dataSources = await api.getDataSources();
      add(SwitchTodayDigestCheckbox(true));
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
      final currentFrom = event.date.copyWith(
        minute: 0,
        hour: 0,
      );
      if (!currentFrom.isAfter(to)) {
        from = currentFrom;
        switchOffSpecificDigest();
        add(LoadDigest());
      } else
        setOneDay(currentFrom);
    } else if (event is ChangeTimeTo) {
      final currentTo = event.date.copyWith(
        minute: 59,
        hour: 23,
      );
      if (!currentTo.isBefore(from)) {
        to = currentTo;
        switchOffSpecificDigest();
        add(LoadDigest());
      } else
        setOneDay(currentTo);
    } else if (event is SwitchTodayDigestCheckbox) {
      from = DateTime.now().copyWith(
        hour: 0,
        minute: 0,
      );
      to = DateTime.now().copyWith(
        hour: 23,
        minute: 59,
      );
      // from = DateTime.parse("2021-10-07").copyWith(
      //   hour: 0,
      //   minute: 0,
      // );
      // to = DateTime.parse("2021-10-07").copyWith(
      //   hour: 23,
      //   minute: 59,
      // );
      showLastDay = true;
      showLastWeek = false;
      showLastMonth = false;
      add(LoadDigest());
    } else if (event is SwitchWeekDigestCheckbox) {
      to = DateTime.now();
      from =
          DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - 7 * kMilisecondsInDay).copyWith(
        minute: 0,
        hour: 0,
      );
      showLastDay = false;
      showLastWeek = true;
      showLastMonth = false;
      add(LoadDigest());
    } else if (event is SwitchMonthDigestCheckbox) {
      to = DateTime.now();
      from = DateTime.now().copyWith(month: to.month - 1).copyWith(
            minute: 0,
            hour: 0,
          );

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

  setOneDay(DateTime date) {
    to = date.copyWith(
      minute: 59,
      hour: 23,
    );
    from = date.copyWith(
      minute: 0,
      hour: 0,
    );
    switchOffSpecificDigest();
    add(LoadDigest());
  }
}

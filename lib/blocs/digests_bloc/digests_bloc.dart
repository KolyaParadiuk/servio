import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';
import 'package:servio/services/network/api_impl.dart';

part 'digests_event.dart';
part 'digests_state.dart';

class DigestsBloc extends Bloc<DigestsEvent, DigestsState> {
  DigestsBloc() : super(DigestsInitial());
  final api = locator<ImplApi>();
  List<DataSource> dataSources = [];
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  @override
  Stream<DigestsState> mapEventToState(
    DigestsEvent event,
  ) async* {
    if (event is LoadDataSources) {
      yield DataLoading();
      dataSources = await api.getDataSources();
      add(LoadDigest());
    } else if (event is LoadDigest) {
      yield DataLoading();
      final hotelDigest = await api.getHotelDigest(from, to, dataSources);
      final restaurantDigest = await api.getRestaurantDigest(from, to, dataSources);
      yield DigestData(
        from: from,
        to: to,
        hotelDigest: hotelDigest,
        restaurantDigest: restaurantDigest,
      );
    } else if (event is ChangeTimeFrom) {
      from = event.date;
      add(LoadDigest());
    } else if (event is ChangeTimeTo) {
      to = event.date;
      add(LoadDigest());
    }
  }
}

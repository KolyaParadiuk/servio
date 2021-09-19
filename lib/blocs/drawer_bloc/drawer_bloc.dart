import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/main.dart';
import 'package:servio/models/report.dart';
import 'package:servio/services/network/api_impl.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final Preferences prefs = locator<Preferences>();
  final api = locator<ImplApi>();
  DrawerBloc() : super(DrawerInitial());

  @override
  Stream<DrawerState> mapEventToState(
    DrawerEvent event,
  ) async* {
    if (event is InitEvent) {
      final reports = await api.getReports();
      yield ReportsLoaded(reports);
    } else if (event is ExitEvent) {
      await prefs.clearCache();
      RestartWidget.restartApp(event.context);
    }
  }
}

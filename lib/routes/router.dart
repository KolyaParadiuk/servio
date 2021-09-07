import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/blocs/settings_bloc/settings_bloc.dart';
import 'package:servio/constants/app_routes.dart';
import 'package:servio/models/report.dart';
import 'package:servio/screens/digests.dart';
import 'package:servio/screens/reports.dart';
import 'package:servio/screens/settings.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePaths.settings:
      return MaterialPageRoute(
        settings: RouteSettings(name: RoutePaths.settings),
        builder: (context) => BlocProvider<SettingsBloc>(
          create: (_) => SettingsBloc(),
          child: SettingsScreen(),
        ),
      );
    case RoutePaths.welcome:
      return MaterialPageRoute(
        settings: RouteSettings(name: RoutePaths.settings),
        builder: (context) => BlocProvider<SettingsBloc>(
          create: (_) => SettingsBloc(),
          child: SettingsScreen(isWelcome: true),
        ),
      );
    case RoutePaths.digests:
      return MaterialPageRoute(
        settings: RouteSettings(name: RoutePaths.digests),
        builder: (context) => DigestsScreen(),
      );
    case RoutePaths.reports:
      return MaterialPageRoute(
        settings: RouteSettings(name: RoutePaths.reports),
        builder: (context) => ReportsPage(settings.arguments as Report),
      );
    default:
      return MaterialPageRoute(
        settings: RouteSettings(name: RoutePaths.noSuchRoute),
        builder: (context) => Container(),
      );
  }
}

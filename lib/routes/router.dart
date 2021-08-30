import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/constants/app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePaths.settings:
      return MaterialPageRoute(
        settings: RouteSettings(name: RoutePaths.settings),
        builder: (context) => Container(child: Text('settings')),
        // (context) => BlocProvider<RootScreenBloc>(
        //   create: (_) => RootScreenBloc(),
        //   child: NetworkerRoot(),
        // ),
      );
    case RoutePaths.digests:
      return MaterialPageRoute(
        settings: RouteSettings(name: RoutePaths.digests),
        builder: (context) => Container(child: Text('Digests')),
      );
    default:
      return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.noSuchRoute), builder: (context) => Container());
  }
}

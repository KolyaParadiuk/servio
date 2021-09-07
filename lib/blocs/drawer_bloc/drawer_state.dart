part of 'drawer_bloc.dart';

@immutable
abstract class DrawerState {}

class DrawerInitial extends DrawerState {}

class ReportsLoaded extends DrawerState {
  final List<Report> reports;
  ReportsLoaded(this.reports);
}

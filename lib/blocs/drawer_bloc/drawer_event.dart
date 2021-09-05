part of 'drawer_bloc.dart';

@immutable
abstract class DrawerEvent {}

class ExitEvent extends DrawerEvent {
  final BuildContext context;
  ExitEvent(this.context);
}

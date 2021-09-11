part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class InitEvent extends SettingsEvent {}

class SubmitEvent extends SettingsEvent {
  BuildContext context;
  SubmitEvent(this.context);
}

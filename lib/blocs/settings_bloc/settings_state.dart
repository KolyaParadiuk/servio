part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInit extends SettingsState {}

class SettingsControllersState extends SettingsState {
  final addressInputController;
  final loginInputController;
  final passwordInputController;
  SettingsControllersState(
    this.addressInputController,
    this.loginInputController,
    this.passwordInputController,
  );
}

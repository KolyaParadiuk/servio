part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInit extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SubmitError extends SettingsState {
  final String message;
  SubmitError(this.message);
}

class SettingsControllersState extends SettingsState {
  final addressInputController;
  final loginInputController;
  final passwordInputController;
  final String? errorMessage;
  SettingsControllersState(
    this.addressInputController,
    this.loginInputController,
    this.passwordInputController, {
    this.errorMessage,
  });
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/main.dart';
import 'package:servio/services/network/api_impl.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Preferences prefs = locator<Preferences>();
  final addressInputController = TextEditingController();
  final loginInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final ImplApi api = locator<ImplApi>();
  SettingsBloc() : super(SettingsInit()) {
    add(InitEvent());
  }

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is InitEvent) {
      addressInputController.text = prefs.getServerAddress();
      loginInputController.text = prefs.getLogin();
      passwordInputController.text = prefs.getPassword();
      yield SettingsControllersState(
        addressInputController,
        loginInputController,
        passwordInputController,
      );
    } else if (event is SubmitEvent) {
      if (_validateInputs()) {
        yield SettingsLoading();
        try {
          api.updateBaseUrl(addressInputController.text + '/api');
          final loginResponse = await api.authentification(loginInputController.text, passwordInputController.text);
          api.updateHeaders(loginResponse.token);
          prefs.setServerAddress(addressInputController.text);
          prefs.setLogin(loginInputController.text);
          prefs.setPassword(passwordInputController.text);
          prefs.setToken(loginResponse.token);
          RestartWidget.restartApp(event.context);
        } catch (e) {
          yield SettingsControllersState(
            addressInputController,
            loginInputController,
            passwordInputController,
            errorMessage: e.toString(),
          );
        }
      }
    }
  }

  bool _validateInputs() {
    return addressInputController.text.isNotEmpty &&
        loginInputController.text.isNotEmpty &&
        passwordInputController.text.isNotEmpty;
  }
}

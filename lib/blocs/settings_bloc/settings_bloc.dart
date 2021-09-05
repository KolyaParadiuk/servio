import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/constants/app_routes.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Preferences prefs = locator<Preferences>();
  final addressInputController = TextEditingController();
  final loginInputController = TextEditingController();
  final passwordInputController = TextEditingController();
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
        prefs.setServerAddress(addressInputController.text);
        prefs.setLogin(loginInputController.text);
        prefs.setPassword(passwordInputController.text);
        Get.offAllNamed(RoutePaths.digests);
      }
    }
  }

  bool _validateInputs() {
    return addressInputController.text.isNotEmpty &&
        loginInputController.text.isNotEmpty &&
        passwordInputController.text.isNotEmpty;
  }
}

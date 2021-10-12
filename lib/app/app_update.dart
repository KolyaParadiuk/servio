import 'package:servio/services/network/api_impl.dart';

import 'locator.dart';

class AppUpdateConst {
  static const int VERSION = 1;
  static const STORE_URL = "http://demo.servio.support/MSW/mobile/Update";
}

class AppUpdate {
  ///Checks if the app must be updated.
  ///If yes - shows undismissable dialog which leads to the store (depending on the platform)

  bool isNeedUpdate = false;

  initialise() async {
    isNeedUpdate = await _isNeedUpdateFromApi();
  }

  ///Compares values of the recommended version from Api with the current ones.
  ///nullable
  Future<bool> _isNeedUpdateFromApi() async {
    final _api = locator<ImplApi>();
    final settings = await _api.getMobileSettings();
    if (AppUpdateConst.VERSION >= settings.version) return false;
    return true;
  }
}

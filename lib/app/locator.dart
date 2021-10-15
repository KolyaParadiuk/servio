import 'package:get_it/get_it.dart';
import 'package:servio/app/app_update.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/services/network/api_impl.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  setupApiService();
  // setupAppUpdateLocator();
}

void setupApiService() {
  Preferences prefs = locator<Preferences>();

  locator.registerFactory<ImplApi>(() => ImplApi(prefs.getServerAddress() + "/api", prefs.getToken()));
}

void setupAppUpdateLocator() {
  locator.registerSingleton<AppUpdate>(AppUpdate());
}

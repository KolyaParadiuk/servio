import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:servio/app/localization/app_translation_delegate.dart';
import 'package:servio/app/localization/application.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/constants/app_routes.dart';
import 'package:servio/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => Preferences());
  await initHive();
  await locator<Preferences>().openBox();

  await setupLocator();

  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _Servio();
  }
}

Future<void> initHive() async {
  await Hive.initFlutter();
}

class _Servio extends StatefulWidget {
  @override
  _ServioState createState() => _ServioState();
}

class _ServioState extends State<_Servio> {
  LocalTranslationsDelegate _newLocaleDelegate = LocalTranslationsDelegate(
    newLocale: Locale(application.defaultLocaleCode),
  );
  bool isAppActive = false;
  String initialRoute = RoutePaths.settings;

  @override
  void initState() {
    super.initState();
    Preferences prefs = locator<Preferences>();
    isAppActive = prefs.getLogin().isNotEmpty && prefs.getPassword().isNotEmpty && prefs.getServerAddress().isNotEmpty;
    if (isAppActive) {
      initialRoute = RoutePaths.digests;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 922),
      builder: () => GetMaterialApp(
        localizationsDelegates: [
          _newLocaleDelegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: application.supportedLocales(),
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
                supportedLocaleLanguage.countryCode == locale.countryCode) {
              return supportedLocaleLanguage;
            }
          }
          return supportedLocales.first;
        },
        onGenerateRoute: generateRoute,
        initialRoute: initialRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

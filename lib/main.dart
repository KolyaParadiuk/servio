import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:servio/app/app_update.dart';
import 'package:servio/app/localization/app_translation_delegate.dart';
import 'package:servio/app/localization/application.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/blocs/drawer_bloc/drawer_bloc.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/constants/app_routes.dart';
import 'package:servio/routes/router.dart';
import 'package:servio/services/network/api_impl.dart';

import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => Preferences());
  await initHive();
  await locator<Preferences>().openBox();

  await setupLocator();

  await initApi();

  await locator<AppUpdate>().initialise();

  runApp(RestartWidget(child: App()));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return _Servio();
  }
}

Future<void> initHive() async {
  await Hive.initFlutter();
}

Future<void> initApi() async {
  final api = locator<ImplApi>();
  final Preferences prefs = locator<Preferences>();
  if (prefs.isAppActive()) {
    final loginResponse = await api.authentification(
      prefs.getLogin(),
      prefs.getPassword(),
    );
    api.updateHeaders(loginResponse.token);
    prefs.setToken(loginResponse.token);
  }
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
  String initialRoute = RoutePaths.welcome;
  Preferences prefs = locator<Preferences>();
  bool isNeedUpdate = locator<AppUpdate>().isNeedUpdate;

  @override
  void initState() {
    super.initState();
    if (isNeedUpdate) {
      initialRoute = RoutePaths.appUpdate;
    } else {
      isAppActive = prefs.isAppActive();
      if (isAppActive) {
        initialRoute = RoutePaths.digests;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = DrawerBloc();
    if (prefs.getServerAddress().isNotEmpty) bloc..add(InitEvent());
    return ScreenUtilInit(
      designSize: Size(375, 922),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider<DrawerBloc>(create: (_) => bloc),
        ],
        child: GetMaterialApp(
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
            primaryColor: kMain,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme.apply(
                    bodyColor: kMainText,
                    displayColor: kMainText,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child);
  }
}

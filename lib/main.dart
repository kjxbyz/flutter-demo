import 'dart:async';
import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'package:flutter_demo/common/model/app_state.dart';
import 'package:flutter_demo/common/config/flutter_demo_config.dart';
import 'package:flutter_demo/l10n/flutter_demo_localizations.dart';
import 'package:flutter_demo/ui/store/reducers/app_state_reducer.dart';
import 'package:flutter_demo/ui/pages/app_intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AmapService.init(
    iosKey: FlutterDemoConfig.AMAP_CLIENT_KEY_IOS,
    androidKey: FlutterDemoConfig.AMAP_CLIENT_KEY_ANDROID,
  );
  // Create Persistor
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  final initialStateFromStorage = await persistor.load();
  final store = Store<AppState>(appReducer,
      initialState: initialStateFromStorage ?? initialState,
      middleware: [
        persistor.createMiddleware(),
        LoggingMiddleware.printer(),
        thunkMiddleware,
      ]);
  runApp(FlutterDemoApp(
    store: store,
  ));
}

class FlutterDemoApp extends StatefulWidget {
  final Store<AppState> store;

  FlutterDemoApp({Key key, this.store}) : super(key: key);

  @override
  _FlutterDemoAppState createState() => _FlutterDemoAppState();
}

class _FlutterDemoAppState extends State<FlutterDemoApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreConnector<AppState, ThemeMode>(
        converter: (store) => store.state.darkMode,
        builder: (context, darkMode) => StoreConnector<AppState, String>(
          converter: (store) => store.state.localeName,
          builder: (context, localeName) => MaterialApp(
            localizationsDelegates: [
              ...FlutterDemoLocalizations.localizationsDelegates,
              LocaleNamesLocalizationsDelegate()
            ],
            supportedLocales: FlutterDemoLocalizations.supportedLocales,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: darkMode,
            locale: localeName.isEmpty ? null : Locale(localeName),
            onGenerateTitle: (BuildContext context) =>
                FlutterDemoLocalizations.of(context).title,
            home: AppIntroScreen(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

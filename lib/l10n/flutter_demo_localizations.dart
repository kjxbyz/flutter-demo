import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:flutter_demo/l10n/messages_all.dart';

// 1. 在 app 的根目录，使用 lib/main.dart 生成 l10n/intl_messages.arb：
// flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/l10n/flutter_demo_localizations.dart
//
// 2. 在 app 的根目录，生成每个 intl_<locale>.arb 文件对应的 intl_messages_<locale>.dart 文件，
// 以及 intl_messages_all.dart 文件，它引入了所有的信息文件
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/flutter_demo_localizations.dart lib/l10n/intl_*.arb
class FlutterDemoLocalizations {
  FlutterDemoLocalizations(Locale locale)
      : _localeName = Intl.canonicalizedLocale(locale.toString());

  final String _localeName;

  static Future<FlutterDemoLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString())
        .then<FlutterDemoLocalizations>((_) => FlutterDemoLocalizations(locale));
  }

  static FlutterDemoLocalizations of(BuildContext context) {
    return Localizations.of<FlutterDemoLocalizations>(
        context, FlutterDemoLocalizations);
  }

  static const LocalizationsDelegate<FlutterDemoLocalizations> delegate =
  _FlutterDemoLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
  <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  String get title {
    return Intl.message(
      'Flutter Sample',
      name: 'title',
      desc: r'The title of app',
      locale: _localeName,
    );
  }

  String get tabSamplesTitle {
    return Intl.message(
      'Samples',
      name: 'tabSamplesTitle',
      desc: r'Title for Samples tab of bottom navigation.',
      locale: _localeName,
    );
  }

  String get tabCategoriesTitle {
    return Intl.message(
      'Categories',
      name: 'tabCategoriesTitle',
      desc: r'Title for Categories tab of bottom navigation.',
      locale: _localeName,
    );
  }

  String get tabWebViewTitle {
    return Intl.message(
      'WebView',
      name: 'tabWebViewTitle',
      desc: r'Title for WebView tab of bottom navigation.',
      locale: _localeName,
    );
  }

  String get tabSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'tabSettingsTitle',
      desc: r'Title for Settings tab of bottom navigation.',
      locale: _localeName,
    );
  }
}

class _FlutterDemoLocalizationsDelegate
    extends LocalizationsDelegate<FlutterDemoLocalizations> {
  const _FlutterDemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<FlutterDemoLocalizations> load(Locale locale) =>
      FlutterDemoLocalizations.load(locale);

  @override
  bool shouldReload(_FlutterDemoLocalizationsDelegate old) => false;
}
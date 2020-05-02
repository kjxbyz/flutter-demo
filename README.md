# flutter demo

A new Flutter application.

## Getting Started

## Instructions to get to a working l10n state

1. Run `flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/l10n/flutter_demo_localizations.dart`. The `lib/l10n/flutter_demo_localizations.dart` here is the file with the localizations class containing the messages you need to internationalize. This creates the template `intl_messages.arb` file.

2. Use the format of the generated `intl_messages.arb` to generate the template for your other `arb` files. Copy the `intl_messages.arb` file 3 times, and in this case, create `_en.arb`, `zh_.arb`, and `_zh_CN.arb`. After creating those, you can delete the original `intl_messages.arb` since it's just a template.

3. Run `flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n  --no-use-deferred-loading lib/l10n/flutter_demo_localizations.dart lib/l10n/intl_*.arb`. This will create the messages_.*dart files that your Flutter app will use.

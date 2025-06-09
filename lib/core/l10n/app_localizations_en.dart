// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppI18NEn extends AppI18N {
  AppI18NEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Flutter Template';

  @override
  String get hello => 'Hello';

  @override
  String welcomeMessage(Object username) {
    return 'Welcome to our app, $username!';
  }

  @override
  String get language => 'Language';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';
}

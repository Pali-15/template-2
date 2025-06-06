// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppI18NHu extends AppI18N {
  AppI18NHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'A Flutter sablon';

  @override
  String get hello => 'Szia';

  @override
  String welcomeMessage(Object username) {
    return 'Üdvözlünk az alkalmazásban, $username!';
  }

  @override
  String get language => 'Nyelv';

  @override
  String get changeLanguage => 'Nyelv megváltoztatása';

  @override
  String get ok => 'Rendben';

  @override
  String get cancel => 'Mégse';
}

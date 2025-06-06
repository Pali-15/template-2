import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/extensions/locals_extension.dart';
import 'package:template/l10n/app_localizations.dart';

enum Locales {
  en('en'),
  hu('hu');

  final String languageCode;

  const Locales(this.languageCode);
}

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(super.initialLocale);

  void changeLocale(Locales locale) {
    final newLocale = locale.toLocale;
    if (_isSupported(newLocale) && newLocale != state) emit(newLocale);
  }

  List<Locale> get supportedLocales => AppI18N.supportedLocales;

  bool _isSupported(Locale locale) => supportedLocales.contains(locale);
}

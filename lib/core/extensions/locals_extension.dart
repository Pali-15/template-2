import 'dart:ui';

import 'package:template/core/l10n/locale_cubit.dart';

extension LocalsExtension on Locales {
  Locale get toLocale => Locale(languageCode);
  bool sameAs(Locale locale) {
    return locale.languageCode == languageCode;
  }
}

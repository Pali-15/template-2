import 'package:flutter/material.dart';
import 'package:template/l10n/app_localizations.dart';

extension ContextLocalizationExtensions on BuildContext {
  AppI18N get l10n => AppI18N.of(this);
}

import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

import 'gen/app_localizations.dart';

class AppL10n {
  AppL10n._();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    ...AppLocalizations.localizationsDelegates,
    ...PresentationLocalizations.localizationsDelegates,
  ];
}
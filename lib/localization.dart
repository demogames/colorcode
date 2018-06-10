import 'dart:async';

import 'package:flutter/material.dart';

class MasterMindLocalizations {
  static MasterMindLocalizations of(BuildContext context) {
    return Localizations.of<MasterMindLocalizations>(
      context,
      MasterMindLocalizations
    );
  }

  String get appTitle => "MasterMind";
  String get infiniteGuesses => "Infinite number of guesses";
  String get masterMindStandard => "MasterMind Standard";
  String get masterMindSuper => "Super MasterMind";
}

class MasterMindLocalizationsDelegate extends LocalizationsDelegate<MasterMindLocalizations> {
  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains("en");

  @override
  Future<MasterMindLocalizations> load(Locale locale) => Future(() => MasterMindLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<MasterMindLocalizations> old) => false;
}
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
  String get allowDuplicateColors => "Allow duplicate colors";
  String get masterMindClassic => "MasterMind Classic";
  String get masterMindSuper => "MasterMind Super";
  String get chooseGame => "Choose your game!";
  String get about => "About";
}

class MasterMindLocalizationsDelegate extends LocalizationsDelegate<MasterMindLocalizations> {
  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains("en");

  @override
  Future<MasterMindLocalizations> load(Locale locale) => Future(() => MasterMindLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<MasterMindLocalizations> old) => false;
}
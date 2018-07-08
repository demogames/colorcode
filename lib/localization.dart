import 'dart:async';

import 'package:flutter/material.dart';

class ColorCodeLocalizations {
  static ColorCodeLocalizations of(BuildContext context) {
    return Localizations.of<ColorCodeLocalizations>(
      context,
      ColorCodeLocalizations
    );
  }

  String get appTitle => "ColorCode";
  String get infiniteGuesses => "Infinite number of guesses";
  String get allowDuplicateColors => "Allow duplicate colors";
  String get colorCodeClassic => "ColorCode Classic";
  String get colorCodeSuper => "ColorCode Super";
  String get chooseGame => "Choose your game!";
  String get about => "About";
  String get guessesMade => "Guesses Made";
}

class ColorCodeLocalizationsDelegate extends LocalizationsDelegate<ColorCodeLocalizations> {
  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains("en");

  @override
  Future<ColorCodeLocalizations> load(Locale locale) => Future(() => ColorCodeLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<ColorCodeLocalizations> old) => false;
}
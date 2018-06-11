import 'dart:math';

import 'package:flutter/material.dart';

class AppState {

  int gameType;
  bool infiniteGuessesEnabled;
  Code code;
  List<Code> guesses = List<Code>();
  Code currentGuess;

  AppState({
    this.gameType = -1,
    this.infiniteGuessesEnabled = false,
  });

  bool get guessIsFull {
    for (var i=0; i<currentGuess.pinCount; ++i) {
      if (-1 == currentGuess[i])
        return false;
    }
    return true;
  }

  void checkGuess() {
    guesses.insert(0, currentGuess);
    currentGuess = Code(
      pinCount,
      colorCount,
      random: false
    );
  }

  int get pinCount => gameType == 0 ? 4 : 5;
  int get colorCount => gameType == 0 ? 6 : 8;

  void generateCode() {
    guesses.clear();
    currentGuess = Code(
      pinCount,
      colorCount,
      random: false
    );
    code = Code(
      pinCount,
      colorCount,
      random: true
    );
  }

  void changeGameType(int type) {
    this.gameType = type;
  }

  void enableInfiniteGuesses(bool enable) {
    this.infiniteGuessesEnabled = enable;
  }
}


class Code {
  static final rand = Random();

  final pinCount;
  final colorCount;
  List<int> _code;

  Code(int this.pinCount, int this.colorCount, {bool random = false}) {
    _code = List<int>(pinCount).map((i) => random ? rand.nextInt(colorCount) : -1).toList();
  }

  @override
  String toString() {
    return _code.toString();
  }

  @override
  bool operator ==(other) => _code == other._code;
  int  operator [](int i) => _code[i];
  void operator []=(int i, int value) => _code[i] = value;
}


class CodeMapper {
  static final _codeColors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.tealAccent,
    Colors.brown
  ];

  static final _defaultColor = Colors.grey;

  static Color getCodeColor(int code) {
    if (code < 0 || code >= _codeColors.length) {
      return _defaultColor;
    }
    return _codeColors[code];
  }
}
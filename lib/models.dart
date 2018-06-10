import 'dart:math';

import 'package:flutter/material.dart';

class AppState {

  int gameType;
  bool infiniteGuessesEnabled;
  Code code;
  List<Code> guesses;

  AppState({
    this.gameType = -1,
    this.infiniteGuessesEnabled = false,
  });

  void makeGuess() {

  }

  void generateCode() {
    guesses.clear();
    code = Code(
      gameType == 0 ? 4 : 5,
      gameType == 0 ? 6 : 8,
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
    Colors.brown,
    Colors.tealAccent
  ];

  static final _defaultColor = Colors.grey;

  static Color getCodeColor(int code) {
    if (code < 0 || code >= _codeColors.length) {
      return _defaultColor;
    }
    return _codeColors[code];
  }
}
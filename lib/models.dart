import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mastermind/typedefs.dart';

class AppState {

  GameType gameType;
  bool infiniteGuessesEnabled;
  Code code;
  List<MapEntry<Code, int>> guesses = List<MapEntry<Code, int>>();
  Code currentGuess;
  bool isOver = false;

  AppState({
    this.gameType = GameType.UNDEFINED,
    this.infiniteGuessesEnabled = false,
  });

  bool get guessIsFull {
    for (var i=0; i<currentGuess.pinCount; ++i) {
      if (-1 == currentGuess[i])
        return false;
    }
    return true;
  }

  int check(Code code, Code guess) {
    code = new Code.from(code);
    guess = new Code.from(guess);
    int rightPlace = 0;
    int rightColor = 0;

    for (int i=0; i<pinCount; ++i) {
      if (code[i] == guess[i]) {
        rightPlace += 1;
        code[i] = -1;
        guess[i] = -1;
      }
    }
    for (int i=0; i<pinCount; ++i) {
      if (guess[i] == -1) {
        continue;
      }
      for (int j=0; j<pinCount; ++j) {
        if (code[j] == -1) {
          continue;
        }
        if (code[j] == guess[i]) {
          rightColor += 1;
          guess[i] = -1;
          code[j] = -1;
        }
      }
    }

    return (rightPlace << 4) | (rightColor);
  }

  void checkGuess() {
    int result = check(code, currentGuess);
    guesses.insert(0, new MapEntry(currentGuess, result));

    if (((result & 0xF0) >> 4) == pinCount) {
      isOver = true;
      currentGuess = new Code.from(code);
    } else {
      currentGuess = Code(
          pinCount,
          colorCount,
          random: false
      );
    }
  }

  int get pinCount => gameType == GameType.CLASSIC ? 4 : 5;
  int get colorCount => gameType == GameType.CLASSIC ? 6 : 8;

  void startGame() {
    isOver = false;
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

  void changeGameType(GameType type) {
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

  factory Code.from(Code code) {
    Code newCode = new Code(code.pinCount, code.colorCount);
    newCode._code = new List.from(code._code);
    return newCode;
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
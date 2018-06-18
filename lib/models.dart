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

  void checkGuess() {
    final int result = code.check(currentGuess);
    guesses.insert(0, new MapEntry(currentGuess, result));

    if (Code.goodPinCount(result) == pinCount) {
      isOver = true;
    } else {
      currentGuess = new Code.empty(pinCount, colorCount);
    }
  }

  int get pinCount => gameType == GameType.CLASSIC ? 4 : 5;
  int get colorCount => gameType == GameType.CLASSIC ? 6 : 8;

  void startGame() {
    isOver = false;
    guesses.clear();
    currentGuess = new Code.empty(pinCount, colorCount);
    code = new Code.random(pinCount, colorCount);
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

  final int pinCount;
  final int colorCount;
  List<int> _code;

  factory Code.random(int pinCount, int colorCount) => new Code._internal(pinCount, colorCount, true);
  factory Code.empty(int pinCount, int colorCount) => new Code._internal(pinCount, colorCount, false);

  Code._internal(this.pinCount, this.colorCount, bool random) {
    _code = List<int>(pinCount).map((i) => random ? rand.nextInt(colorCount) : -1).toList();
  }

  static int goodPinCount(int v) {
    return (v & 0xF0) >> 4;
  }

  static int goodColorCount(int v) {
    return (v & 0x0F);
  }

  int check(Code guess) {
    var code = new List<int>.from(_code);
    var other = new List<int>.from(guess._code);

    int rightPlace = 0;
    int rightColor = 0;

    for (int i=0; i<pinCount; ++i) {
      if (code[i] == other[i]) {
        rightPlace += 1;
        code[i] = -1;
        other[i] = -1;
      }
    }
    for (int i=0; i<pinCount; ++i) {
      if (other[i] == -1) {
        continue;
      }
      for (int j=0; j<pinCount; ++j) {
        if (code[j] == -1) {
          continue;
        }
        if (code[j] == other[i]) {
          rightColor += 1;
          other[i] = -1;
          code[j] = -1;
        }
      }
    }

    return (rightPlace << 4) | (rightColor);
  }

  @override
  String toString() {
    return _code.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Code &&
              runtimeType == other.runtimeType &&
              pinCount == other.pinCount &&
              colorCount == other.colorCount &&
              _code == other._code;

  @override
  int get hashCode =>
      pinCount.hashCode ^
      colorCount.hashCode ^
      _code.hashCode;

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
import 'package:flutter/material.dart';

import 'package:colorcode/localization.dart';
import 'package:colorcode/models.dart';
import 'package:colorcode/routes.dart';
import 'package:colorcode/screens/HomeScreen.dart';
import 'package:colorcode/screens/GameScreen.dart';
import 'package:colorcode/screens/AboutScreen.dart';
import 'package:colorcode/typedefs.dart';

class ColorCodeApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ColorCodeAppState();
}

class ColorCodeAppState extends State<ColorCodeApp> {
  AppState appState = AppState();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: ColorCodeLocalizations().appTitle,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        ColorCodeLocalizationsDelegate(),
      ],
      routes: {
        ColorCodeRoutes.home: (context) =>
            HomeScreen(
              appState: appState,
              startGame: startGame,
              enableInfiniteGuesses: enableInfiniteGuesses,
              enableDuplicateColors: enableDuplicateColors,
              initGame: initGame,
            ),
        ColorCodeRoutes.game: (context) =>
            GameScreen(
              appState: appState,
              restartGame: startGame,
              checkGuess: checkGuess,
              setColor: setColor,
            ),
        ColorCodeRoutes.about: (context) =>
            AboutScreen(

            )
      },
    );
  }

  void setColor(int pin, int color) {
    setState(() {
      appState.currentGuess[pin] = color;
    });
  }

  void checkGuess() {
    setState(() {
      appState.checkGuess();
    });
  }

  void startGame() {
    setState(() {
      appState.startGame();
    });
  }

  void enableInfiniteGuesses(bool enable) {
    setState(() {
      appState.enableInfiniteGuesses(enable);
    });
  }

  void enableDuplicateColors(bool enable) {
    setState(() {
      appState.enableDuplicateColors(enable);
    });
  }

  void initGame(GameType type) {
    appState.changeGameType(type);
    appState.startGame();
  }
}

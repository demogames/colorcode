import 'package:flutter/material.dart';

import 'package:mastermind/localization.dart';
import 'package:mastermind/models.dart';
import 'package:mastermind/routes.dart';
import 'package:mastermind/screens/HomeScreen.dart';
import 'package:mastermind/screens/GameScreen.dart';
import 'package:mastermind/screens/AboutScreen.dart';
import 'package:mastermind/typedefs.dart';

class MasterMindApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MasterMindAppState();
}

class MasterMindAppState extends State<MasterMindApp> {
  AppState appState = AppState();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: MasterMindLocalizations().appTitle,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        MasterMindLocalizationsDelegate(),
      ],
      routes: {
        MasterMindRoutes.home: (context) =>
            HomeScreen(
              appState: appState,
              startGame: startGame,
              enableInfiniteGuesses: enableInfiniteGuesses,
              initGame: initGame,
            ),
        MasterMindRoutes.game: (context) =>
            GameScreen(
              appState: appState,
              restartGame: startGame,
              checkGuess: checkGuess,
              setColor: setColor,
            ),
        MasterMindRoutes.about: (context) =>
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

  void initGame(GameType type) {
    appState.changeGameType(type);
    appState.startGame();
  }
}

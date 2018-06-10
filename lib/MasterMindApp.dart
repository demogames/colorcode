import 'package:flutter/material.dart';

import 'package:mastermind/localization.dart';
import 'package:mastermind/models.dart';
import 'package:mastermind/routes.dart';
import 'package:mastermind/screens/HomeScreen.dart';
import 'package:mastermind/screens/GameScreen.dart';

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
              generateCode: generateCode,
              changeGameType: changeGameType,
              enableInfiniteGuesses: enableInfiniteGuesses,
            ),
        MasterMindRoutes.game: (context) =>
            GameScreen(
              appState: appState,
              generateCode: generateCode,
            ),
      },
    );
  }

  void makeGuess() {
    setState(() {
      appState.makeGuess();
    });
  }

  void generateCode() {
    setState(() {
      appState.generateCode();
    });
  }

  void changeGameType(int type) {
    setState(() {
      appState.changeGameType(type);
    });
  }

  void enableInfiniteGuesses(bool enable) {
    setState(() {
      appState.enableInfiniteGuesses(enable);
    });
  }
}

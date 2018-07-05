import 'package:flutter/material.dart';
import 'package:mastermind/routes.dart';
import 'package:mastermind/typedefs.dart';

import 'package:mastermind/widgets/CodeWidget.dart';
import 'package:mastermind/keys.dart';
import 'package:mastermind/localization.dart';
import 'package:mastermind/models.dart';
import 'package:mastermind/widgets/ColorChooser.dart';
import 'package:mastermind/widgets/HintWidget.dart';
import 'package:mastermind/widgets/StatsWidget.dart';

class GameScreen extends StatefulWidget {
  final AppState appState;
  final Function restartGame;
  final ColorSetter setColor;
  final Function checkGuess;

  GameScreen({
    @required this.appState,
    @required this.restartGame,
    @required this.setColor,
    @required this.checkGuess
  }) : super(key : MasterMindKeys.gameScreen);

  @override
  createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: widget.appState.gameType == GameType.CLASSIC
          ? Text(MasterMindLocalizations.of(context).masterMindClassic)
          : Text(MasterMindLocalizations.of(context).masterMindSuper),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.sync,
              color: Theme.of(context).buttonColor,
            ),
            tooltip: "regenerate code",
            onPressed: widget.restartGame
          ),
          new IconButton(
            icon: new Icon(
              Icons.info_outline,
              color: Theme.of(context).buttonColor,
            ),
            tooltip: "about",
            onPressed: () {
              Navigator.pushNamed(context, MasterMindRoutes.about);
            },
          ),
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new StatsWidget(
            appState: widget.appState
          ),
          new Divider(
            color: Colors.grey,
          ),
          new Expanded(
            child: new ListView(
              children: widget.appState.guesses.map((guess) {
                return new Row (
                  children: <Widget>[
                    new Expanded(
                      child: new CodeWidget(
                          code: guess.key,
                      ),
                      flex: 4,
                    ),
                    new Expanded(
                      child: new AspectRatio(
                        aspectRatio: 1.0,
                        child: new HintWidget(guess.value, widget.appState.pinCount),
                      ),
                      flex: 1,
                    ),
                  ],
                );
              }).toList(),
              reverse: true,
            ),
          ),
          new Divider(
            color: Colors.grey,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new CodeWidget(
                  code: widget.appState.currentGuess,
                  selectColor: widget.appState.isOver
                    ? null
                    : selectColor,
                ),
                flex: 4,
              ),
              new Expanded(
                child: new AspectRatio(
                  aspectRatio: 1.0,
                  child: new FittedBox(
                    fit: BoxFit.fill,
                    child: new IconButton(
                      icon: new Icon(
                        Icons.check,
                      ),
                      onPressed: widget.appState.guessIsFull && !widget.appState.isOver
                        ? widget.checkGuess
                        : null,
                    ),
                  ),
                ),
                flex: 1,
              )
            ],
          ),
        ],
      ),
    );
  }

  void selectColor(int i) {
    showDialog(
        context: context,
        builder: (buildContext) => new ColorChooser(widget.appState.colorCount)
    ).then((color) {
      if (color != null) {
        widget.setColor(i, color);
      }
    });
  }
}
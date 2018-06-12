import 'package:flutter/material.dart';
import 'package:mastermind/typedefs.dart';
import 'dart:math';

import 'package:mastermind/widgets/CodeWidget.dart';
import 'package:mastermind/keys.dart';
import 'package:mastermind/localization.dart';
import 'package:mastermind/models.dart';
import 'package:mastermind/widgets/ColorChooser.dart';

class GameScreen extends StatefulWidget {
  final AppState appState;
  final Function generateCode;
  final ColorSetter setColor;
  final Function checkGuess;

  GameScreen({
    @required this.appState,
    @required this.generateCode,
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
              onPressed: widget.generateCode
          ),
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Expanded(
            child: new ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: widget.appState.guesses.map((guess) {
                  return new ListTile(
                    title: new CodeWidget(
                      code: guess,
                    ),
                    trailing: new Icon(Icons.apps),
                  );
                }),
              ).toList(),
              reverse: true,
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new CodeWidget(
                  code: widget.appState.currentGuess,
                  selectColor: selectColor
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
                      onPressed: widget.appState.guessIsFull
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
        builder: (BuildContext) => new ColorChooser(widget.appState.colorCount)
    ).then((color) {
      if (color != null) {
        widget.setColor(i, color);
      }
    });
  }
}
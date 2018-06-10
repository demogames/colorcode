import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mastermind/code.dart';
import 'package:mastermind/keys.dart';
import 'package:mastermind/localization.dart';
import 'package:mastermind/models.dart';

class GameScreen extends StatefulWidget {
  final AppState appState;
  final Function generateCode;

  GameScreen({
    @required this.appState,
    @required this.generateCode,
  }) : super(key : MasterMindKeys.gameScreen);

  @override
  createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: widget.appState.gameType == 0
          ? Text(MasterMindLocalizations.of(context).masterMindStandard)
          : Text(MasterMindLocalizations.of(context).masterMindSuper),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.sync,
                color: Theme.of(context).buttonColor,
              ),
              tooltip: "regenerate code",
              onPressed: widget.appState.generateCode
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
                      interactive: false
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
                  code: new Code(
                    widget.appState.gameType == 0 ? 4 : 5,
                    widget.appState.gameType == 0 ? 6 : 8,
                  ),
                  interactive: true
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
                      onPressed: null,
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
}
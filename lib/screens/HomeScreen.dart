import 'package:flutter/material.dart';

import 'package:mastermind/keys.dart';
import 'package:mastermind/localization.dart';
import 'package:mastermind/models.dart';
import 'package:mastermind/routes.dart';
import 'package:mastermind/typedefs.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  final Function generateCode;
  final InfiniteGuessesEnabler enableInfiniteGuesses;
  final GameStarter initGame;

  HomeScreen({
    @required this.appState,
    @required this.generateCode,
    @required this.enableInfiniteGuesses,
    @required this.initGame,
  }) : super(key: MasterMindKeys.homeScreen);

  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MasterMindLocalizations.of(context).appTitle),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new MaterialButton(
                onPressed: () {
                  widget.initGame(GameType.CLASSIC);
                  Navigator.pushNamed(context, MasterMindRoutes.game);
                },
                child: new Text(
                  MasterMindLocalizations.of(context).masterMindClassic
                ),
              ),
              new MaterialButton(
                onPressed: () {
                  widget.initGame(GameType.SUPER);
                  Navigator.pushNamed(context, MasterMindRoutes.game);
                },
                child: new Text(
                    MasterMindLocalizations.of(context).masterMindSuper
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Checkbox(
                value: widget.appState.infiniteGuessesEnabled,
                onChanged: widget.enableInfiniteGuesses,
              ),
              new Text(
                MasterMindLocalizations.of(context).infiniteGuesses
              ),
            ],
          )
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

import 'package:mastermind/keys.dart';
import 'package:mastermind/localization.dart';
import 'package:mastermind/models.dart';
import 'package:mastermind/routes.dart';
import 'package:mastermind/typedefs.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  final Function generateCode;
  final GameTypeChanger changeGameType;
  final InfiniteGuessesEnabler enableInfiniteGuesses;

  HomeScreen({
    @required this.appState,
    @required this.generateCode,
    @required this.changeGameType,
    @required this.enableInfiniteGuesses,
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
                  widget.changeGameType(0); // FIXME add constant
                  widget.generateCode();
                  Navigator.pushNamed(context, MasterMindRoutes.game);
                },
                child: new Text(
                  MasterMindLocalizations.of(context).masterMindStandard
                ),
              ),
              new MaterialButton(
                onPressed: () {
                  widget.changeGameType(1); // FIXME add constant
                  widget.generateCode();
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


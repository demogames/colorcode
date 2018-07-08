import 'package:flutter/material.dart';

import 'package:colorcode/keys.dart';
import 'package:colorcode/localization.dart';
import 'package:colorcode/models.dart';
import 'package:colorcode/routes.dart';
import 'package:colorcode/typedefs.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  final Function startGame;
  final BooleanOptionSetter enableInfiniteGuesses;
  final BooleanOptionSetter enableDuplicateColors;
  final GameStarter initGame;

  HomeScreen({
    @required this.appState,
    @required this.startGame,
    @required this.enableInfiniteGuesses,
    @required this.enableDuplicateColors,
    @required this.initGame,
  }) : super(key: ColorCodeKeys.homeScreen);

  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ColorCodeLocalizations.of(context).appTitle),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.info_outline,
              color: Theme.of(context).buttonColor,
            ),
            tooltip: "about",
            onPressed: () {
              Navigator.pushNamed(context, ColorCodeRoutes.about);
            },
          ),
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Text(
              ColorCodeLocalizations.of(context).chooseGame,
              style: new TextStyle(
                fontSize: 32.0,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new RaisedButton (
                  onPressed: () {
                    widget.initGame(GameType.CLASSIC);
                    Navigator.pushNamed(context, ColorCodeRoutes.game);
                  },
                  child: new Text(
                    ColorCodeLocalizations.of(context).colorCodeClassic.replaceAll(' ', '\n'),
                    style: new TextStyle(
                      fontSize: 24.0,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  elevation: 2.0,
                  color: Colors.white,
                  padding: new EdgeInsets.all(16.0),
                ),
                new RaisedButton(
                  onPressed: () {
                    widget.initGame(GameType.SUPER);
                    Navigator.pushNamed(context, ColorCodeRoutes.game);
                  },
                  child: new Text(
                    ColorCodeLocalizations.of(context).colorCodeSuper.replaceAll(' ', '\n'),
                    style: new TextStyle(
                      fontSize: 24.0,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  elevation: 2.0,
                  color: Colors.white,
                  padding: new EdgeInsets.all(16.0),
                ),
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Checkbox(
                  value: widget.appState.infiniteGuessesEnabled,
                  onChanged: widget.enableInfiniteGuesses,
                ),
                new Text(
                  ColorCodeLocalizations.of(context).infiniteGuesses
                ),
              ],
            )
          ),
          new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Checkbox(
                  value: widget.appState.duplicateColorsEnabled,
                  onChanged: widget.enableDuplicateColors,
                ),
                new Text(
                    ColorCodeLocalizations.of(context).allowDuplicateColors
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}


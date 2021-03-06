import 'package:flutter/material.dart';
import 'package:colorcode/localization.dart';
import 'package:colorcode/models.dart';

class StatsWidget extends StatelessWidget {
  final AppState appState;

  const StatsWidget({
    Key key,
    @required this.appState
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      new Padding(
        padding: new EdgeInsets.only(top: 8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
                ColorCodeLocalizations.of(context).guessesMade
            ),
            new Text(
              appState.guesses.length.toString().padLeft(3)
            ),
            new Text(
              "/"
            ),
            new Text(
              appState.maxGuessCount < 0 ? "∞" : appState.maxGuessCount.toString()
            ),
          ],
        ),
      );
  }
}
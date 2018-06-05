import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mastermind/code.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new GamePage(),

    );
  }
}

class GamePage extends StatefulWidget {
  @override
  GameState createState() => new GameState();
}

class GameState extends State<GamePage> {
  var _code;
  final _rand = new Random();

  var _guesses = new List<Code>();

  GameState() {
    _code = _generateCode();
  }

  Code _generateCode() {
    Code code = new Code();
    for (int i=0; i<code.pinCount(); ++i) {
      code[i] = _rand.nextInt(6);
    }
    return code;
  }

  void _regenerateCode() {
    setState(() {
      _guesses.insert(0, _code);
      _code = _generateCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    final guessWidgets = _guesses.map(
      (guess) {
        return new ListTile(
          title: new CodeWidget(guess),
          trailing: new Icon(Icons.apps),
        );
      }
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Brain Master"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.sync,
              color: Theme.of(context).buttonColor,
            ),
            tooltip: "regenerate code",
            onPressed: _regenerateCode
          ),
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Theme.of(context).buttonColor,
            ),
            tooltip: "resolve",
            onPressed: null
          )
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Expanded(
            child: new ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: guessWidgets
              ).toList(),
              reverse: true,
            ),
          ),
          new GuessWidget()
        ],
      ),
    );
  }
}

class GuessWidget extends StatefulWidget {
  @override
  createState() => new GuessState();
}

class GuessState extends State<GuessWidget> {
  var _codeWidget;

  GuessState() {
    _codeWidget = new CodeWidget(new Code());
  }

  _checkGuess() {
    print("Check Guess");
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: _codeWidget,
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
                onPressed: _checkGuess
              ),
            ),
          ),
          flex: 1,
        )
      ],
    );
  }
}
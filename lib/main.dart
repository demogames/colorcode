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
  _GameState createState() => new _GameState();
}

class _GameState extends State<GamePage> {
  var code = <int>[0,0,0,0];
  var rand = new Random();

  var _guesses = new List<List<int>>();

  var _currentGuess = <int>[0,0,0,0];

  List<int> generateCode() {
    return code.map((c) { return rand.nextInt(6); }).toList();
  }

  void _regenerateCode() {
    setState(() {
      _guesses.add(code);
      code = generateCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    final guessWidgets = _guesses.map(
        (guess) {
          return new ListTile(
            title: new Text('Hello, World'),
          );
        }
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Brain Master"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Expanded(
            child: new ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: guessWidgets).toList()
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
  _checkGuess() {
    print("Check Guess");
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new CodeWidget(),
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
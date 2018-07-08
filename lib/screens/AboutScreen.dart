
import 'package:flutter/material.dart';
import 'package:colorcode/localization.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(ColorCodeLocalizations.of(context).about)
      ),
      body: new ListView(
        children: <Widget>[
          new ExpansionTile(
            title: new Text('How to play'),
            children: <Widget>[
              new Text('Lorem Ipsum'),
            ],
            initiallyExpanded: true,
          ),
          new ExpansionTile(
            title: new Text('Impressum'),
            children: <Widget>[
              new Text('Lorem Ipsum'),
            ],
          ),
          new ExpansionTile(
            title: new Text('Datenschutzerklärung'),
            children: <Widget>[
              new Text('Lorem Ipsum'),
            ],
          ),
        ],
      )
    );
  }
}
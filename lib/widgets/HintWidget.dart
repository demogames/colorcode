import 'package:flutter/material.dart';
import 'package:mastermind/models.dart';

class HintWidget extends StatelessWidget {
  final int _goodPins;
  final int _goodColors;

  HintWidget(int hint)
    : _goodPins = Code.goodPinCount(hint)
    , _goodColors = Code.goodColorCount(hint)
  { }

  Widget hintPin(BuildContext contect, int i) {
    return new Padding(
      padding: new EdgeInsets.all(4.0),
      child: new Container(
        child: new Icon(
          Icons.brightness_1,
          color: _goodPins > i ? Colors.black : Theme.of(contect).canvasColor,
        ),
        decoration: new BoxDecoration(
          color: _goodPins + _goodColors > i ? Colors.black : Theme.of(contect).canvasColor,
          shape: BoxShape.circle,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            hintPin(context, 0),
            hintPin(context, 1),
          ]
        ),
        new Row(
          children: <Widget>[
            hintPin(context, 2),
            hintPin(context, 3),
          ]
        ),
      ],
    );
  }
}
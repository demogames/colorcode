import 'package:flutter/material.dart';
import 'package:mastermind/models.dart';

class HintWidget extends StatelessWidget {
  final int _pinCount;

  final int _goodPins;
  final int _goodColors;

  HintWidget(int hint, this._pinCount)
    : _goodPins = Code.goodPinCount(hint)
    , _goodColors = Code.goodColorCount(hint);

  Widget hintPin(BuildContext context, int i) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Container(
        foregroundDecoration: new BoxDecoration(
          color: _goodPins > i ? Colors.black : Theme.of(context).canvasColor,
          shape: BoxShape.circle,
          border: new Border.all(
              color: _goodPins + _goodColors > i ? Colors.black : Theme.of(context).canvasColor,
              width: 2.0
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          primary: false,
          children: <Widget>[
            hintPin(context, 0),
            hintPin(context, 1),
            hintPin(context, 2),
            hintPin(context, 3),
          ],
        ),
        _pinCount == 5
          ? new Padding(
            padding: new EdgeInsets.all(20.0),
            child: hintPin(context, 4)
          )
          : new Container()
        ,
      ]
    );
  }
}
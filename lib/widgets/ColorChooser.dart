import 'package:flutter/material.dart';

import 'package:mastermind/models.dart';

class ColorChooser extends StatelessWidget {
  final int colorCount;

  ColorChooser(this.colorCount);

  @override
  Widget build(BuildContext context) {
    var colorWidgets = <Widget>[];
    for (int i = 0; i < colorCount; ++i) {
      colorWidgets.add(
        new Expanded(
          child: new AspectRatio(
            aspectRatio: 1.0,
            child: new FittedBox(
              fit: BoxFit.fill,
              child: new IconButton(
                icon: new Icon(
                  Icons.brightness_1,
                  color: CodeMapper.getCodeColor(i),
                ),
                onPressed: () {
                  Navigator.pop(context, i);
                },
                splashColor: null,
                highlightColor: null,
              ),
            ),
          ),
        ),
      );
    }
    return new AlertDialog(
      title: new Text("Choose Color"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Row(
            children: colorWidgets.sublist(0, (0.5 * colorWidgets.length).floor()),
          ),
          new Row(
            children: colorWidgets.sublist((0.5 * colorWidgets.length).floor(), colorWidgets.length),
          ),
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';

import 'package:mastermind/models.dart';

class CodeWidget extends StatefulWidget {
  Code code;
  bool interactive;

  CodeWidget({Code this.code, bool this.interactive});

  @override
  createState() => new CodeState();
}

class CodeState extends State<CodeWidget> {

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: createPinWidgets(),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  createPinWidgets() {
    var pinWidgets = <Widget>[];
    for (int i = 0; i < widget.code.pinCount(); ++i) {
      pinWidgets.add(
        new Expanded(
          child: new AspectRatio(
            aspectRatio: 1.0,
            child: new FittedBox(
              fit: BoxFit.fill,
              child: new IconButton(
                icon: new Icon(
                  Icons.brightness_1,
                  color: CodeMapper.getCodeColor(widget.code[i]),
                ),
                onPressed: () {
                  selectColor(i);
                },
                splashColor: null,
                highlightColor: null,
              ),
            ),
          ),
        ),
      );
    }
    return pinWidgets;
  }

  selectColor(int i) {
    showDialog(
        context: context,
        builder: (BuildContext) => new ColorChooser(widget.code.colorCount())
    ).then((color) {
      if (color != null) {
        setState(() {
          widget.code[i] = color;
        });
      }
    });
  }
}

class ColorChooser extends StatelessWidget {
  final colorCount;

  ColorChooser(int this.colorCount);

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
      content: new Row(
        children: colorWidgets,
      ),
    );
  }
}

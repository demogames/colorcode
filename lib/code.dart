import 'package:flutter/material.dart';
import 'dart:math';

class CodeMapper {
  static var _codeColors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple
  ];

  static var _defaultColor = Colors.grey;

  static Color getCodeColor(int code) {
    if (code < 0 || code >= _codeColors.length) {
      return _defaultColor;
    }
    return _codeColors[code];
  }

  static int colorCount() => _codeColors.length;
}

class Code {
  var _code = <int>[-1, -1, -1, -1];

  operator [](int i) => _code[i];
  operator []=(int i, int value) => _code[i] = value;

  int pinCount() => _code.length;
}

class CodeWidget extends StatefulWidget {
  Code _code;

  CodeWidget(Code this._code);

  @override
  createState() => new CodeState(_code);
}

class CodeState extends State<CodeWidget> {
  Code _code;

  CodeState(Code this._code);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: createPinWidgets(),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  createPinWidgets() {
    var pinWidgets = <Widget>[];
    for (int i = 0; i < _code.pinCount(); ++i) {
      pinWidgets.add(
        new Expanded(
          child: new AspectRatio(
            aspectRatio: 1.0,
            child: new FittedBox(
              fit: BoxFit.fill,
              child: new IconButton(
                icon: new Icon(
                  Icons.brightness_1,
                  color: CodeMapper.getCodeColor(_code[i]),
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
        builder: (BuildContext) => new ColorChooser()
    ).then((color) {
      if (color != null) {
        setState(() {
          _code[i] = color;
        });
      }
    });
  }
}

class ColorChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var colorWidgets = <Widget>[];
    for (int i = 0; i < CodeMapper.colorCount(); ++i) {
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

import 'package:flutter/material.dart';

import 'package:mastermind/models.dart';
import 'package:mastermind/typedefs.dart';

class CodeWidget extends StatelessWidget {
  final Code code;
  final ColorSelector selectColor;

  const CodeWidget({
    Key key,
    @required this.code,
    this.selectColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: createPinWidgets(),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  createPinWidgets() {
    var pinWidgets = <Widget>[];
    for (int i = 0; i < code.pinCount; ++i) {
      pinWidgets.add(
        new Expanded(
          child: new AspectRatio(
            aspectRatio: 1.0,
            child: new FittedBox(
              fit: BoxFit.fill,
              child: new IconButton(
                icon: new Icon(
                  Icons.brightness_1,
                  color: CodeMapper.getCodeColor(code[i]),
                ),
                onPressed: selectColor == null
                    ? null
                    : () { selectColor(i); },
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
}

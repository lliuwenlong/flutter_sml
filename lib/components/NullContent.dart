import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import 'package:flutter_sml/services/ScreenAdaper.dart';


class NullContent extends StatelessWidget {
    String text;
    double width;
    double height;
    NullContent(this.text, {Key key, this.width, this.height}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Text(text, style: TextStyle(
                color: ColorClass.subTitleColor,
                fontSize: ScreenAdaper.fontSize(34)
            ))
        );
    }
}
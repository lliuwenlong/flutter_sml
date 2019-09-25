import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';

class Label extends StatelessWidget {
    final String text;
    Label(this.text, {Key key});

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(24),
                ScreenAdaper.height(16),
                ScreenAdaper.width(24),
                ScreenAdaper.height(16)
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Text(this.text, style: TextStyle(
                color: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            )),
        );
    }
}
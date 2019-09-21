import 'package:flutter/material.dart';
// import 'package:city_pickers/city_pickers.dart';

import '../services/ScreenAdaper.dart';
import '../common/Color.dart';
import 'dart:ui';

class FotterButton extends StatelessWidget {
    final String buttonName;
    final Function onTapHandler;
    FotterButton(this.buttonName, {Key key, this.onTapHandler}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            width: double.infinity,
            height: ScreenAdaper.height(88) + MediaQueryData.fromWindow(window).padding.bottom,
            padding: EdgeInsets.only(
                bottom: MediaQueryData.fromWindow(window).padding.bottom + ScreenAdaper.height(10),
                top: ScreenAdaper.height(10),
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                    BoxShadow(color: Colors.grey[300],offset: Offset(1, 1)),
                    BoxShadow(color: Colors.grey[300], offset: Offset(-1, -1), blurRadius: 2),
                    BoxShadow(color: Colors.grey[300], offset: Offset(1, -1), blurRadius: 2),
                    BoxShadow(color: Colors.grey[300], offset: Offset(-1, 1), blurRadius: 2)
                ] 
            ),
            child: RaisedButton(
                elevation: 0,
                onPressed: () {
                    this.onTapHandler != null && this.onTapHandler();
                },
                color: ColorClass.common,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                ),
                child: Text(buttonName, style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenAdaper.fontSize(40)
                ))
            )
        );
    }
}
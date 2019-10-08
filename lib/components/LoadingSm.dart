import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
class Loading extends StatelessWidget {
    bool isCenter;
    Loading({Key key, this.isCenter = false}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: <Widget>[
                    Container(
                        width: ScreenAdaper.width(104),
                        height: ScreenAdaper.width(144),
                        child: Image.asset(
                            "images/loading.gif",
                            fit: BoxFit.cover,
                        ),
                    ),
                    SizedBox(height: ScreenAdaper.height(50)),
                    Text("正在努力加载中，请稍后...", style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(28),
                        color: Color(0xFF666666)
                    ))
                ]
            )
        );
    }
}
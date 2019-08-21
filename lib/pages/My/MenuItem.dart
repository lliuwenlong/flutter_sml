import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
class MenuItem extends StatelessWidget {
    final Icon icon;
    final String name;
    final String tip;
    const MenuItem(this.icon, this.name, {this.tip = ""});

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(35),
                ScreenAdaper.height(23),
                ScreenAdaper.width(35),
                ScreenAdaper.height(23)
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    icon,
                    SizedBox(width: ScreenAdaper.width(20)),
                    Text(name, style: TextStyle(
                        color: Color(0XFF333333),
                        fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                    )),
                    Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                Text(tip,style: TextStyle(
                                    color: Color(0XFF999999),
                                    fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                                )),
                                SizedBox(width: ScreenAdaper.width(20)),
                                Icon(IconData(0xe61e, fontFamily: 'iconfont'), size: ScreenAdaper.fontSize(24, allowFontScaling: true))
                            ]
                        ),
                    )
                ]
            )
        );
    }
}
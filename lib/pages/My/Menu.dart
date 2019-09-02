import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
class Menu extends StatelessWidget {
    const Menu({Key key}) : super(key: key);

    Widget _menuItem (context, String name, String url, double width, double height, String routeName) {
        return GestureDetector(
            onTap: () {
                Navigator.pushNamed(context, routeName);
            },
            child: Column(
              
                children: <Widget>[
                    Container(
                        width: ScreenAdaper.width(width),
                        height: ScreenAdaper.width(height),
                        child: Image.asset(url, fit: BoxFit.cover)
                    ),
                    Container(
                        margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                        child: Text(name, style: TextStyle(
                            fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true),
                            color: Color(0XFFF333333)
                        )),
                    )
                ]
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            padding: EdgeInsets.fromLTRB(
                0, ScreenAdaper.height(30), 0, ScreenAdaper.height(30)
            ),
            child: Row(
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: this._menuItem(context, "我的神木", "images/wodeshenmu.png", 44, 61, "/product")
                    ),
                    Expanded(
                        flex: 1,
                        child: this._menuItem(context, "我的钱包", "images/wodeqianbao.png", 57, 61, "/myWallet")
                    ),
                    Expanded(
                        flex: 1,
                        child: this._menuItem(context, "我的动态", "images/wodedongtai.png", 54, 57, "/myDynamics")
                    )
                ]
            )
        );
    }
}
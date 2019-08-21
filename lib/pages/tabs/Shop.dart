import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';

class ShopPage extends StatefulWidget {
    ShopPage({Key key}) : super(key: key);
    _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
    
    Widget _commodityItem () {
        return Container(
            width: (ScreenAdaper.getScreenWidth() - 40 ) / 2,
            padding: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
                children: <Widget>[
                    Stack(
                        children: <Widget>[
                            AspectRatio(
                                aspectRatio: 335 / 400,
                                child: Container(
                                    width: double.infinity,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                        child: Image.network(
                                            "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                            fit: BoxFit.cover,
                                        )
                                    ),
                                )
                            ),
                            Positioned(
                                top: ScreenAdaper.width(20),
                                left: ScreenAdaper.width(20),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenAdaper.width(36),
                                        ScreenAdaper.height(16),
                                        ScreenAdaper.width(36),
                                        ScreenAdaper.height(16)
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("金丝榔", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenAdaper.fontSize(30)
                                    )),
                                ),
                            )
                        ],
                    ),
                    SizedBox(height: ScreenAdaper.height(20)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20), 0, ScreenAdaper.width(20), 0
                        ),
                        child: Row(
                            children: <Widget>[
                                Icon(IconData(0xe61d, fontFamily: 'iconfont'), color: Color(0xFF22b0a1)),
                                SizedBox(width: ScreenAdaper.width(20)),
                                Text("神木基地名称", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true),
                                    color: Color(0xFF666666)
                                ))
                            ],
                        )
                    ),
                    SizedBox(height: ScreenAdaper.height(15)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20), 0, ScreenAdaper.width(20), 0
                        ),
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("¥1000.00", style: TextStyle(
                                        color: Color(0xFFfb4135),
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: RaisedButton(
                                            onPressed: () {},
                                            color: Color(0xFF22b0a1),
                                            splashColor: Color.fromRGBO(0, 0, 0, 0),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(6))
                                            ),
                                            child: Text("立即购买", style: TextStyle(
                                                fontSize: ScreenAdaper.fontSize(24),
                                                color: Color(0xFFffffff)
                                            )),
                                        ),
                                    ),
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("商城", style: TextStyle(
                    color: Colors.black
                )),
                elevation: 0,
                brightness: Brightness.light,
                backgroundColor: Colors.white
            ),
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: <Widget>[
                            this._commodityItem(),
                            this._commodityItem(),
                            this._commodityItem(),
                            this._commodityItem(),
                            this._commodityItem(),
                            this._commodityItem(),
                        ],
                    )
                )
            )
        );
    }
}
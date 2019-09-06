import 'package:flutter/material.dart';
import '../../../services/ScreenAdaper.dart';
import '../../../common/Color.dart';
import 'dart:ui';
class Reserve extends StatelessWidget {
    BuildContext _selfContext;
    Reserve({Key key}) : super(key: key);

    Widget _header (String name) {
        return Container(
            padding: EdgeInsets.all(
                ScreenAdaper.width(30)
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: ColorClass.borderColor,
                        width: ScreenAdaper.width(1)
                    )
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Text(name, style: TextStyle(
                        color: ColorClass.fontColor,
                        fontSize: ScreenAdaper.fontSize(30)
                    )),
                    GestureDetector(
                        onTap: () {
                            Navigator.pop(_selfContext);
                        },
                        child: Icon(
                            IconData(0xe633, fontFamily: "iconfont"),
                            color: ColorClass.borderColor,
                            size: ScreenAdaper.fontSize(30)
                        )
                    )
                ]
            )
        );
    }

    Widget _rowItem (String name, String value) {
        return Row(
            children: <Widget>[
                Text(name, style: TextStyle(
                    color: ColorClass.fontColor,
                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                )),
                SizedBox(width: ScreenAdaper.width(20)),
                Text(value, style: TextStyle(
                    color: ColorClass.titleColor,
                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                ))
            ]
        );
    }

    Widget _banner () {
        return Column(
            children: <Widget>[
                Stack(
                    children: <Widget>[
                        AspectRatio(
                            aspectRatio: 750 / 300,
                            child: Image.network(
                                "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                fit: BoxFit.cover,
                            ),
                        ),
                        Positioned(
                            bottom: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30),
                            child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenAdaper.width(25),
                                    ScreenAdaper.height(5),
                                    ScreenAdaper.width(25),
                                    ScreenAdaper.height(5)
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    color: Color.fromRGBO(0, 0, 0, 0.7)
                                ),
                                child: Text("1/4", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdaper.fontSize(30)
                                )),
                            ),
                        )
                    ],
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenAdaper.height(25)
                    ),
                    padding: EdgeInsets.only(
                        left: ScreenAdaper.width(30),
                        right: ScreenAdaper.width(30)
                    ),
                    child: Column(
                        children: <Widget>[
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: this._rowItem("面积", "25㎡")
                                    ),
                                    Expanded(
                                        child: this._rowItem("可住", "1人")
                                    )
                                ],
                            ),
                            SizedBox(height: ScreenAdaper.height(25)),
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: this._rowItem("窗户", "有窗")
                                    ),
                                    Expanded(
                                        child: this._rowItem("床型", "大床")
                                    )
                                ],
                            ),
                            SizedBox(height: ScreenAdaper.height(25)),
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: this._rowItem("宽带", "免费WIFI")
                                    ),
                                    Expanded(
                                        child: this._rowItem("卫浴", "有")
                                    )
                                ],
                            )
                        ]
                    )
                )
            ]
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        this._selfContext = context;
        return Container(
            padding: EdgeInsets.only(
                bottom: MediaQueryData.fromWindow(window).padding.bottom
            ),
            child: Wrap(
                children: <Widget>[
                    _header("高级大床房"),
                    _banner(),
                    Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(65)
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child:Container(
                                        height: ScreenAdaper.height(110),
                                        alignment: Alignment.center,
                                        child: Text.rich(new TextSpan(
                                            style: TextStyle(
                                                color: Color(0xFFfb4135),
                                                fontWeight: FontWeight.w500
                                            ),
                                            children: <TextSpan>[
                                                TextSpan(
                                                    text: '¥',
                                                    style: TextStyle(
                                                        fontSize: ScreenAdaper.fontSize(26)
                                                    )
                                                ),
                                                TextSpan(
                                                    text: '188',
                                                    style: TextStyle(
                                                        fontSize: ScreenAdaper.fontSize(44)
                                                    )
                                                )
                                            ]
                                        )),
                                    ),
                                ),
                                Container(
                                    height: ScreenAdaper.height(110),
                                    child: RaisedButton(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero
                                        ),
                                        onPressed: () {
                                            Navigator.pushNamed(context, "/placeOrder");
                                        },
                                        color: ColorClass.common,
                                        child: Text("在线预订，商家确认后付款", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenAdaper.fontSize(34)
                                        ))
                                    ),
                                )
                                
                            ]
                        ),
                    )
                ]
            )
        );
    }
}
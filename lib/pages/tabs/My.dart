import 'package:flutter/material.dart';
import '../My/Menu.dart';
import '../My/MenuItem.dart';
import '../../services/ScreenAdaper.dart';
import 'dart:ui';

class MyPage extends StatefulWidget {
    MyPage({Key key}) : super(key: key);
    _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
    Widget _buildTopBar () {
        double top = MediaQueryData.fromWindow(window).padding.top;
        return Container(
            height: ScreenAdaper.height(300),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/zhuangtailan.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Container(
                margin: EdgeInsets.only(top: top),
                
                child: Column(
                   
                    children: <Widget>[

                        Container(
                            height: ScreenAdaper.height(88),
                            padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Icon(
                                        IconData(0xe652, fontFamily: 'iconfont'),
                                        size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                        color: Colors.white,
                                    ),
                                    IconButton(
                                      alignment:Alignment.center,
                                      icon: Icon(IconData(0xe653, fontFamily: 'iconfont')),
                                      iconSize:ScreenAdaper.fontSize(40, allowFontScaling: true),
                                      color: Colors.white,
                                      onPressed: (){
                                        Navigator.pushNamed(context, '/setting');
                                      }
                                    )
                                ],
                            )
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
                            width: double.infinity,
                            child: Row(
                                children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, '/userInfo');
                                      },
                                      child: Container(
                                        width: ScreenAdaper.width(160),
                                        child: Stack(
                                            children: <Widget>[
                                                Positioned(
                                                    child: Container(
                                                        width: ScreenAdaper.width(140),
                                                        height: ScreenAdaper.width(140),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(150),
                                                            image: DecorationImage(
                                                                image: NetworkImage("https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"),
                                                                fit: BoxFit.cover
                                                            )
                                                        )
                                                    ),
                                                ),
                                                Positioned(
                                                    bottom: ScreenAdaper.height(12),
                                                    right: ScreenAdaper.width(0),
                                                    child: Container(
                                                        width: ScreenAdaper.width(40),
                                                        height: ScreenAdaper.width(40),
                                                        child: Image.asset(
                                                            "images/jia-v.png",
                                                            fit: BoxFit.cover
                                                        )
                                                    )
                                                )
                                            ],
                                        )
                                    )
                                    ),
                                    SizedBox(width: ScreenAdaper.width(20)),
                                    Text("小童宝贝", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(40),
                                        color: Colors.white
                                    )),
                                    Expanded(
                                        flex: 1,
                                        child: Stack(
                                            children: <Widget>[
                                                Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Padding(
                                                        padding: EdgeInsets.only(right: ScreenAdaper.width(30)),
                                                        child: Icon(
                                                            IconData(0Xe654, fontFamily: "iconfont"),
                                                            size: ScreenAdaper.fontSize(60),
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                )
                                            ],
                                        )
                                    )
                                ]
                            )
                        )
                    ],
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            body: SafeArea(
                top: false,
                child: Column(
                    children: <Widget>[
                        this._buildTopBar(),
                        Container(
                            child: Menu(),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                            child: MenuItem(
                                Icon(
                                    IconData(0xe64e, fontFamily: 'iconfont'),
                                    size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                    color: Color(0XFF7c7874),
                                ),
                                "我的订单",
                                "/order",
                                tip: "查看全部订单",
                            ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                            child: MenuItem(
                                Icon(
                                    IconData(0xe64d, fontFamily: 'iconfont'),
                                    size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                    color: Color(0XFF7c7874),
                                ),
                                "我的优惠券",
                                "/coupon"
                            ),
                        ),
                        Container(
                            child: MenuItem(
                                Icon(
                                    IconData(0xe651, fontFamily: 'iconfont'),
                                    size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                    color: Color(0XFF7c7874),
                                ),
                                "实名认证",
                                "/authentication"
                            ),
                        ),
                        Container(
                            child: MenuItem(
                                Icon(
                                    IconData(0xe650, fontFamily: 'iconfont'),
                                    size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                    color: Color(0XFF7c7874),
                                ),
                                "我的发票",
                                "/invoice"
                            ),
                        ),
                        Container(
                            child: MenuItem(
                                Icon(
                                    IconData(0xe64f, fontFamily: 'iconfont'),
                                    size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                    color: Color(0XFF7c7874),
                                ),
                                "联系客服",
                                "/contactCustomerService"
                            ),
                        )
                    ],
                ),
            )
        );
    }
}
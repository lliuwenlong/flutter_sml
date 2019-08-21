import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class Coupon extends StatefulWidget {
    Coupon({Key key}) : super(key: key);
    _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> with SingleTickerProviderStateMixin {
    TabController _tabController;
    @override
    void initState () {
        super.initState();
        _tabController = new TabController(
            vsync: this,
            length: 2
        );
    }
    Widget _cardItem () {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(25),
                0,
                ScreenAdaper.width(25),
                0
            ),
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Card(
                child: Column(
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(30),
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(30)
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Container(
                                        width: ScreenAdaper.height(80),
                                        height: ScreenAdaper.height(80),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.network(
                                                "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                                fit: BoxFit.cover,
                                            ),
                                        ),
                                    ),
                                    SizedBox(width: ScreenAdaper.width(20)),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text("住宿代金券", style: TextStyle(
                                                color: Color(0XFF333333),
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )),
                                            SizedBox(height: ScreenAdaper.height(15)),
                                            Text("有效期至：2019-09-151", style: TextStyle(
                                                color: Color(0XFF999999),
                                                fontSize: ScreenAdaper.fontSize(24)
                                            ))
                                        ],
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: ScreenAdaper.height(80),
                                            child: Stack(
                                                children: <Widget>[
                                                    Align(
                                                        alignment: Alignment.bottomRight,
                                                        child: Text("¥ 300", style: TextStyle(
                                                            color: Color(0XFFfb4135),
                                                            fontSize: ScreenAdaper.fontSize(44)
                                                        )),
                                                    )
                                                ]
                                            ),
                                        ),
                                    )
                                ]
                            )
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left: ScreenAdaper.width(35),
                                right: ScreenAdaper.width(35)
                            ),
                            child: Divider(
                                color: Color(0XFFd9d9d9),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(20),
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(20)
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Text("平台赠送", style: TextStyle(
                                        color: ColorClass.fontColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    )),
                                    OutlineButton(
                                        onPressed: () {},
                                        child: Text("立即使用", style: TextStyle(
                                            color: ColorClass.common,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        )),
                                        borderSide:new BorderSide(color: ColorClass.common),
                                        splashColor: Color.fromRGBO(0, 0, 0, 0),
                                        shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(2))
                                        )
                                    )
                                ]
                            )
                        )
                    ]
                )
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("神木基地", style: TextStyle(
                    color: Colors.black,
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light,
                bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: ScreenAdaper.height(6),
                    indicatorColor: Color(0XFF22b0a1),
                    controller: this._tabController,
                    tabs: <Widget>[
                        Container(
                            child: Tab(child: Text("未使用", style: TextStyle(
                                color: Colors.black, fontSize: ScreenAdaper.fontSize(34)
                            ))),
                        ),
                        Tab(child: Text("已过期", style: TextStyle(
                            color: Color(0XFF666666),
                            fontSize: ScreenAdaper.fontSize(34)
                        )))
                    ]
                )
            ),
            body: TabBarView(
                controller: this._tabController,
                children: <Widget>[
                    ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                            return this._cardItem();
                        }
                    ),
                    ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                            return this._cardItem();
                        }
                    )
                ]
            )
        );
    }
}
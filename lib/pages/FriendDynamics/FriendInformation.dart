import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'dart:ui';

class FriendInformation extends StatelessWidget {
    BuildContext context;
    FriendInformation({Key key}) : super(key: key);
    Widget _buildTopBar () {
        double top = MediaQueryData.fromWindow(window).padding.top;
        return Container(
            height: ScreenAdaper.height(335) + top,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            height: ScreenAdaper.height(88),
                            padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
                            child: GestureDetector(
                                onTap: () {
                                    Navigator.pop(this.context);
                                },
                                child: Icon(
                                    Icons.arrow_back_ios,
                                    size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                    color: Colors.white,
                                )
                            )
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
                            width: double.infinity,
                            child: Row(
                                children: <Widget>[
                                    Container(
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
                                    ),
                                    SizedBox(width: ScreenAdaper.width(20)),
                                    Text("小童宝贝", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(40),
                                        color: Colors.white
                                    ))
                                ]
                            )
                        ),
                        SizedBox(
                            height: ScreenAdaper.height(40),
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        children: <Widget>[
                                            Text("186", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(34),
                                                fontWeight: FontWeight.w500
                                            )),
                                            Text("关注", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(24)
                                            ))
                                        ],
                                    ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        children: <Widget>[
                                            Text("1490", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(34),
                                                fontWeight: FontWeight.w500
                                            )),
                                            Text("粉丝", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(24)
                                            ))
                                        ],
                                    ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        children: <Widget>[
                                            Text("12", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(34),
                                                fontWeight: FontWeight.w500
                                            )),
                                            Text("动态", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(24)
                                            ))
                                        ]
                                    )
                                )
                            ]
                        )
                    ],
                ),
            ),
        );
    }

    Widget _headPortrait (String url) {
        return Row(
            children: <Widget>[
                Container(
                    width: ScreenAdaper.width(85),
                    height: ScreenAdaper.width(85),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.network(
                            "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                            fit: BoxFit.cover,
                        ),
                    ),
                ),
                SizedBox(width: ScreenAdaper.width(20)),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text("张丽", style: TextStyle(
                            color: ColorClass.common,
                            fontSize: ScreenAdaper.fontSize(30),
                            fontWeight: FontWeight.w500
                        )),
                        Text("昨天 12:31", style: TextStyle(
                            color: ColorClass.subTitleColor,
                            fontSize: ScreenAdaper.fontSize(24)
                        ))
                    ]
                )
            ]
        );
    }

    Widget iconFont (int icon, String text, {bool isBorder = false}) {
        return Container(
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(30)
            ),
            decoration: BoxDecoration(
                border: isBorder ? Border(
                    left: BorderSide(color: ColorClass.borderColor, width: ScreenAdaper.width(1)),
                    right: BorderSide(color: ColorClass.borderColor, width: ScreenAdaper.width(1))
                ) : null
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Icon(
                        IconData(icon, fontFamily: "iconfont"),
                        color: ColorClass.iconColor,
                        size: ScreenAdaper.fontSize(35),
                    ),
                    SizedBox(width: ScreenAdaper.width(15)),
                    Text(text, style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(27),
                        color: ColorClass.iconColor
                    ))
                ]
            )
        );         
    }

    Widget _optBar () {
        return Row(
            children: <Widget>[
                Expanded(
                    flex: 1,
                    child: this.iconFont(0xe63f, (158).toString()),
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/friendDynamicsComment");
                        },
                        child: this.iconFont(0xe640, (158).toString(), isBorder: true)
                    ),
                ),
                Expanded(
                    flex: 1,
                    child: this.iconFont(0xe641, (158).toString()),
                )
            ]
        );
    }

    Widget _itemWidget (double marginNum) {
        return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(marginNum)
            ),
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    this._headPortrait("123"),
                    Container(
                        margin:EdgeInsets.only(
                            top: ScreenAdaper.width(30)
                        ),
                        child: Text("品鉴停留在舌尖上的金丝楠、金丝榔、香樟亲身体验用味蕾感受金丝楠、金丝榔、香樟在这样的氛围里喝酒吃肉怎能不快哉？"),
                    ),
                    SizedBox(height: ScreenAdaper.height(30)),
                    Wrap(
                        spacing: ScreenAdaper.width(15),
                        runSpacing: ScreenAdaper.width(15),
                        children: <Widget>[
                            Container(
                                width: ScreenAdaper.width(220),
                                height: ScreenAdaper.width(220),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    child: Image.network(
                                        "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                        fit: BoxFit.cover,
                                    )
                                )
                            ),
                            Container(
                                width: ScreenAdaper.width(220),
                                height: ScreenAdaper.width(220),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    child: Image.network(
                                        "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                        fit: BoxFit.cover,
                                    )
                                )
                            ),
                            Container(
                                width: ScreenAdaper.width(220),
                                height: ScreenAdaper.width(220),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    child: Image.network(
                                        "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                        fit: BoxFit.cover,
                                    )
                                )
                            )
                        ]
                    ),
                    this._optBar()
                ]
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        this.context = context;
        return Scaffold(
            body: Column(
                children: <Widget>[
                    this._buildTopBar(),
                    Expanded(
                        // flex: 1,
                        child: new MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                    return this._itemWidget(index ==0 ? 0 : 20);
                                },
                                itemCount: 10,
                            )
                        )
                    )
                ],
            ),
        );
    }
}
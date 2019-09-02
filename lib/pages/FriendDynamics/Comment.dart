import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../components/AppBarWidget.dart';
import 'dart:ui';
class FriendDynamicsComment extends StatefulWidget {
  FriendDynamicsComment({Key key}) : super(key: key);

  _FriendDynamicsCommentState createState() => _FriendDynamicsCommentState();
}

class _FriendDynamicsCommentState extends State<FriendDynamicsComment> {
    var selfContext;
    _FriendDynamicsCommentState({Key key});
    _reportHandler () {
        showModalBottomSheet(
            context: this.selfContext,
            builder: (BuildContext context) {
                return Container(
                    height: ScreenAdaper.height(281),
                    width: double.infinity,
                    color: Colors.black54,
                    child: Container(
                        height: ScreenAdaper.height(281),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)
                            )
                        ),
                        child: Column(
                            children: <Widget>[
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushNamed(context, "/friendDynamicsReport");
                                        },
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                Icon(
                                                    IconData(0xe642, fontFamily: "iconfont"),
                                                    size: ScreenAdaper.fontSize(42)
                                                ),
                                                SizedBox(width: ScreenAdaper.width(20)),
                                                Text("举报", style: TextStyle(
                                                    color: ColorClass.titleColor,
                                                    fontSize: ScreenAdaper.fontSize(30)
                                                ))
                                            ]
                                        )
                                    )
                                ),
                                GestureDetector(
                                    onTap: () {
                                        Navigator.pop(context);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            top: ScreenAdaper.height(33),
                                            bottom: ScreenAdaper.height(33),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: ColorClass.borderColor,
                                                    width: ScreenAdaper.width(2)
                                                )
                                            )
                                        ),
                                        width: double.infinity,
                                        child: Text("关闭", style: TextStyle(
                                            color: ColorClass.titleColor,
                                            fontSize: ScreenAdaper.fontSize(34)
                                        ))
                                    )
                                )
                                
                            ]
                        )
                    )
                );
            }
        );
    }

    _shareHandler () {
        showModalBottomSheet(
            context: this.selfContext,
            builder: (BuildContext context) {
                return Container(
                    height: ScreenAdaper.height(407),
                    width: double.infinity,
                    color: Colors.black54,
                    child: Container(
                        height: ScreenAdaper.height(407),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)
                            )
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenAdaper.width(30),
                                        left: ScreenAdaper.width(30)
                                    ),
                                    child: Text("分享到", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(30),
                                        color: ColorClass.titleColor
                                    ))
                                ),
                                SizedBox(height: ScreenAdaper.height(40)),
                                Expanded(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            Column(
                                                children: <Widget>[
                                                    Icon(
                                                        IconData(0xe667, fontFamily: "iconfont"),
                                                        size: ScreenAdaper.fontSize(100),
                                                        color: Color(0xFF22b0a1)
                                                    ),
                                                    SizedBox(height: ScreenAdaper.height(20)),
                                                    Text("微信好友", style: TextStyle(
                                                        fontSize: ScreenAdaper.fontSize(24),
                                                        color: ColorClass.fontColor
                                                    ))
                                                ]
                                            ),
                                            SizedBox(width: ScreenAdaper.width(167)),
                                            Column(
                                                children: <Widget>[
                                                    Icon(
                                                        IconData(0xe668, fontFamily: "iconfont"),
                                                        size: ScreenAdaper.fontSize(100),
                                                        color: Color(0xFF22b0a1)
                                                    ),
                                                    SizedBox(height: ScreenAdaper.height(20)),
                                                    Text("微信朋友圈", style: TextStyle(
                                                        fontSize: ScreenAdaper.fontSize(24),
                                                        color: ColorClass.fontColor
                                                    ))
                                                ]
                                            )
                                        ]
                                    )
                                ),
                                GestureDetector(
                                    onTap: () {
                                        Navigator.pop(context);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            top: ScreenAdaper.height(33),
                                            bottom: ScreenAdaper.height(33),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: ColorClass.borderColor,
                                                    width: ScreenAdaper.width(2)
                                                )
                                            )
                                        ),
                                        width: double.infinity,
                                        child: Text("关闭", style: TextStyle(
                                            color: ColorClass.titleColor,
                                            fontSize: ScreenAdaper.fontSize(34)
                                        ))
                                    )
                                )
                                
                            ]
                        )
                    )
                );
            }
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
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                                this._reportHandler();
                            },
                            icon: Icon(IconData(0xe666, fontFamily: "iconfont")),
                            color: ColorClass.fontColor,
                            iconSize: ScreenAdaper.fontSize(37),
                        )
                    )
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
                    )
                ]
            )
        );
    }

    Widget _commentItem () {
        return Container(
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30),
                top: ScreenAdaper.width(30),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(width: ScreenAdaper.width(30),),
                    Expanded(
                        flex: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                SizedBox(height: ScreenAdaper.height(10)),
                                Text("小白", style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(30),
                                    fontWeight: FontWeight.w500
                                )),
                                SizedBox(height: ScreenAdaper.height(15)),
                                Container(
                                    width: double.infinity,
                                    child: Text("我最喜欢百合花了，这个养的真不错，等到收获得季节就更美了 。", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(28),
                                    )),
                                ),
                                SizedBox(height: ScreenAdaper.height(5)),
                                Text("7月25日", style: TextStyle(
                                    color: ColorClass.subTitleColor,
                                    fontSize: ScreenAdaper.fontSize(24),
                                ))
                            ]
                        )
                    )
                ]
            ),
        );
    }

    Widget _comment () {
        return Container(
            color: Colors.white,
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(20)
            ),
            padding: EdgeInsets.only(
                bottom: ScreenAdaper.width(30)
            ),
            child: Column(
                children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorClass.borderColor,
                                    width: ScreenAdaper.width(2)
                                )
                            )
                        ),
                        padding: EdgeInsets.all(ScreenAdaper.width(30)),
                        child: Text("全部评论（2）", style: TextStyle(
                            color: ColorClass.subTitleColor,
                            fontSize: ScreenAdaper.fontSize(30)
                        )),
                    ),
                    this._commentItem(),
                    this._commentItem(),
                    this._commentItem(),
                    this._commentItem(),
                ]
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        this.selfContext = context;
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("详情"),
            body: Column(
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: ListView(
                            children: <Widget>[
                                this._itemWidget(0),
                                this._comment()
                            ]
                        ),
                    ),
                    
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(color: Colors.grey[300],offset: Offset(1, 1)),
                                BoxShadow(color: Colors.grey[300], offset: Offset(-1, -1), blurRadius: 2),
                                BoxShadow(color: Colors.grey[300], offset: Offset(1, -1), blurRadius: 2),
                                BoxShadow(color: Colors.grey[300], offset: Offset(-1, 1), blurRadius: 2)
                            ]
                        ),
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20),
                            ScreenAdaper.height(10),
                            ScreenAdaper.width(20),
                            ScreenAdaper.height(10) + MediaQueryData.fromWindow(window).padding.bottom
                        ),
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                            fillColor: Color(0xFFf5f5f5),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                                borderSide: BorderSide.none,
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                ScreenAdaper.width(30),
                                                ScreenAdaper.width(25),
                                                ScreenAdaper.width(30),
                                                ScreenAdaper.width(25)
                                            ),
                                            hintText: "快给他评价一下吧",
                                            hintStyle: TextStyle(
                                                color: ColorClass.subTitleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )
                                        ),
                                    )
                                ),
                                SizedBox(width: ScreenAdaper.width(40)),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Text("128", style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontSize: ScreenAdaper.fontSize(18)
                                        )),
                                        SizedBox(height: ScreenAdaper.height(10)),
                                        Icon(
                                            IconData(0xe63f, fontFamily: "iconfont"),
                                            color: ColorClass.iconColor,
                                            size: ScreenAdaper.fontSize(35)
                                        ),
                                    ]
                                ),
                                SizedBox(width: ScreenAdaper.width(40)),
                                GestureDetector(
                                    onTap: () {
                                        this._shareHandler();
                                    },
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                            Text("2", style: TextStyle(
                                                color: ColorClass.subTitleColor,
                                                fontSize: ScreenAdaper.fontSize(18)
                                            )),
                                            SizedBox(height: ScreenAdaper.height(10)),
                                            Icon(
                                                IconData(0xe641, fontFamily: "iconfont"),
                                                color: ColorClass.iconColor,
                                                size: ScreenAdaper.fontSize(35)
                                            ),
                                        ]
                                    )
                                )
                            ],
                        )
                    )
                ]
            )
        );
    }
}
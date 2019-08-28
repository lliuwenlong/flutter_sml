import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
class FriendDynamicsPage extends StatefulWidget {
    FriendDynamicsPage({Key key}) : super(key: key);
    _FriendDynamicsPageState createState() => _FriendDynamicsPageState();
}

class _FriendDynamicsPageState extends State<FriendDynamicsPage> with SingleTickerProviderStateMixin {
    TabController _tabController;
    @override
    void initState() {
        super.initState();
        _tabController = TabController(vsync: this, length: 2);
    }

    AppBar _appBar () {
        return AppBar(
            title: Text("树友圈", style: TextStyle(
                color: Colors.black,
                fontSize: ScreenAdaper.fontSize(34)
            )),
            elevation: 1,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            brightness: Brightness.light,
            actions: <Widget>[
                Center(
                    child: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/friendDynamicsRelease");
                        },
                        child: Text("发布", style: TextStyle(
                            fontSize: ScreenAdaper.fontSize(30),
                            color: ColorClass.fontColor
                        ))
                    )
                ),
                SizedBox(width: ScreenAdaper.width(30))
            ],
            bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: ScreenAdaper.height(6),
                indicatorColor: Color(0XFF22b0a1),
                controller: this._tabController,
                tabs: <Widget>[
                    Tab(child: Text("最新动态", style: TextStyle(
                        color: Color(0XFF666666),
                        fontSize: ScreenAdaper.fontSize(34)
                    ))),
                    Tab(child: Text("好友动态", style: TextStyle(
                        color: Color(0XFF666666),
                        fontSize: ScreenAdaper.fontSize(34)
                    )))
                ]
            )
        );
    }

    Widget _headPortrait (String url) {
        return Row(
            children: <Widget>[
                GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(context, "/friendInformation");
                    },
                    child: Container(
                        width: ScreenAdaper.width(85),
                        height: ScreenAdaper.width(85),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.network(
                                "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                fit: BoxFit.cover,
                            ),
                        ),
                    )
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
        return Scaffold(
            appBar: this._appBar(),
            body: TabBarView(
                controller: this._tabController,
                children: <Widget>[
                    ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return this._itemWidget(index == 0 ? 0 : 20);
                        },
                        itemCount: 10
                    ),
                    ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return this._itemWidget(index == 0 ? 0 : 20);
                        },
                        itemCount: 10
                    )
                ]
            ),
        );
    }
}
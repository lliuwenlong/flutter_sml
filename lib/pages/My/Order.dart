import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
class Order extends StatefulWidget {
    Order({Key key}) : super(key: key);
    _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with SingleTickerProviderStateMixin{
    final List<Map> _tabList = [
        {"id": 1, "name": "全部"},
        {"id": 2, "name": "待付款"},
        {"id": 3, "name": "待使用"},
        {"id": 4, "name": "待评价"},
        {"id": 5, "name": "退款"}
    ];
    TabController _tabController;
    void initState () {
        super.initState();
        _tabController = new TabController(
            vsync: this,
            length: 5
        );
    }

    Widget _itemWidget () {
        return Container(
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(20)
            ),
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            color: Colors.white,
            child: Column(
                children: <Widget>[
                    Row(
                        children: <Widget>[
                            Icon(
                                IconData(0xe659, fontFamily: "iconfont"),
                                color: Colors.red,
                                size: ScreenAdaper.fontSize(30),
                            ),
                            SizedBox(width: ScreenAdaper.width(20)),
                            Text("神木林湖景酒店", style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(30)
                            )),
                            Expanded(
                                flex: 1,
                                child: Text("待使用",  style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                ), textAlign: TextAlign.end),
                            )
                        ]
                    ),
                    SizedBox(height: ScreenAdaper.height(30)),
                    Row(
                        children: <Widget>[
                            Container(
                                width: ScreenAdaper.width(120),
                                height: ScreenAdaper.width(120),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    child: Image.network(
                                        "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                        fit: BoxFit.cover,
                                    )
                                ),
                            ),
                            SizedBox(
                                width: ScreenAdaper.width(20),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text("下单时间：2019-02-05", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    )),
                                    SizedBox(height: ScreenAdaper.height(5)),
                                    Text("总价：¥998.00", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    ))
                                ]
                            )
                        ]
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: ScreenAdaper.width(160),
                            height: ScreenAdaper.width(60),
                            child: OutlineButton(
                                borderSide: BorderSide(
                                    color: Color(0XFF999999),
                                    width: ScreenAdaper.width(1)
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                                ),
                                highlightedBorderColor: Color(0XFF999999),
                                onPressed: () {
                                    Navigator.pushNamed(context, "/acknowledgement");
                                },
                                child: Text("去购买", style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                )),
                            )
                        )
                    )
                ]
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("我的神木", style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenAdaper.fontSize(32)
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
                    isScrollable: true,
                    unselectedLabelColor: ColorClass.fontColor,
                    unselectedLabelStyle: TextStyle(
                        fontSize: ScreenAdaper.fontSize(30),
                        fontWeight: FontWeight.w500
                    ),
                    labelColor: ColorClass.titleColor,
                    labelStyle: TextStyle(
                        fontSize: ScreenAdaper.fontSize(34),
                        fontWeight: FontWeight.w600
                    ),
                    tabs: this._tabList.map((val) {
                        return Tab(child: Text(
                            val['name']
                        ));
                    }).toList()
                ),
            ),
            body: TabBarView(
                controller: this._tabController,
                children: <Widget>[
                    ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return this._itemWidget();
                        },
                        itemCount: 10,
                    ),
                    ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return this._itemWidget();
                        },
                        itemCount: 10,
                    ),
                    ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return this._itemWidget();
                        },
                        itemCount: 10,
                    ),
                    ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return this._itemWidget();
                        },
                        itemCount: 10,
                    ),
                    ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return this._itemWidget();
                        },
                        itemCount: 10,
                    )
                ]
            )
        );
    }
}
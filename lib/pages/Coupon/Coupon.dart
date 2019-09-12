import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';

import '../../components/LoadingSm.dart';
import '../../model/api/coupon/CouponData.dart';

class Coupon extends StatefulWidget {
    Coupon({Key key}) : super(key: key);
    _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> with SingleTickerProviderStateMixin {
    TabController _tabController;
    bool isNotUseLoading = false;
    bool isBeOverdueLoading = false;
    HttpUtil http = HttpUtil();
    int notUsePage = 1;
    int beOverdue = 1;
    User userModel;
    List notUseList = [];
    List beOverdueList = [];
    void didChangeDependencies() {
        super.didChangeDependencies();
        userModel = Provider.of<User>(context);
    }

    @override
    void initState () {
        super.initState();
        _tabController = new TabController(
            vsync: this,
            length: 2
        );
    }

    _getNoUseData ({bool isInit = false}) async {
        final Map<String, dynamic> response = await this.http.get("/api/v1/coupon/data", data: {
            "pageNO": this.notUsePage,
            "pageSize": 10,
            "userId": this.userModel.userId,
            "type": 1
        });
    
        // final CouponDataModel res = new CouponDataModel.fromJson(response);
        Map<String, dynamic> resItem = {
            "couponSn": "string",
            "coverImage": "string",
            "endDate": "2019-10-10",
            "firmId": 0,
            "id": 0,
            "name": "string",
            "title": "string",
            "type": "house",
            "worth": "string"
        };

        Map<String, dynamic> resData = {
            "code": 200,
            "data": {
                "currPage": 10,
                "list": [
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem
                ],
                "pageSize": 0,
                "totalCount": 0,
                "totalPage": 0
            },
            "msg": "string"
        };

        if (response["code"] == 200) {
            // final res = new CouponDataModel.fromJson(response);
            final res = new CouponDataModel.fromJson(resData);
            if (isInit) {
                setState(() {
                    notUseList = res.data.list;
                    isNotUseLoading = false;
                });
                return response;
            } else {
                setState(() {
                    notUseList.addAll(res.data.list);
                });
                return response;
            }
        }
        return response;
    }

    _getBeOverdueData ({bool isInit = false}) async {
        final Map<String, dynamic> response = await this.http.get("/api/v1/coupon/data", data: {
            "pageNO": this.beOverdue,
            "pageSize": 10,
            "userId": this.userModel.userId,
            "type": 2
        });
    
        // final CouponDataModel res = new CouponDataModel.fromJson(response);
        Map<String, dynamic> resItem = {
            "couponSn": "string",
            "coverImage": "string",
            "endDate": "2019-10-10",
            "firmId": 0,
            "id": 0,
            "name": "string",
            "title": "string",
            "type": "house",
            "worth": "string"
        };

        Map<String, dynamic> resData = {
            "code": 200,
            "data": {
                "currPage": 10,
                "list": [
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem,
                    resItem
                ],
                "pageSize": 0,
                "totalCount": 0,
                "totalPage": 0
            },
            "msg": "string"
        };

        if (response["code"] == 200) {
            // final res = new CouponDataModel.fromJson(response);
            final res = new CouponDataModel.fromJson(resData);
            if (isInit) {
                setState(() {
                    beOverdueList = res.data.list;
                    isBeOverdueLoading = false;
                });
                return response;
            } else {
                setState(() {
                    beOverdueList.addAll(res.data.list);
                });
                return response;
            }
        }
        return response;     
    }

    Widget _cardItem ({isBeOverdue: false}) {
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
                                                color: isBeOverdue ? ColorClass.iconColor : Color(0XFF333333),
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )),
                                            SizedBox(height: ScreenAdaper.height(15)),
                                            Text("有效期至：2019-09-151", style: TextStyle(
                                                color: isBeOverdue ? ColorClass.iconColor : Color(0XFF999999),
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
                                                            color: isBeOverdue ? ColorClass.iconColor : Color(0XFFfb4135),
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
                            padding: isBeOverdue
                            ? EdgeInsets.only(
                                left: ScreenAdaper.width(35)
                            )
                            : EdgeInsets.fromLTRB(
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(20),
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(20)
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Text("平台赠送", style: TextStyle(
                                        color: isBeOverdue ? ColorClass.iconColor : ColorClass.fontColor,
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                    isBeOverdue
                                        ? Container(
                                            width: ScreenAdaper.height(128),
                                            height: ScreenAdaper.width(100),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("images/beoverdue.png"),
                                                    fit: BoxFit.contain
                                                )
                                            )
                                        )
                                        : Container(
                                            width: ScreenAdaper.width(136),
                                            height: ScreenAdaper.height(50),
                                            child: OutlineButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {},
                                                child: Text("立即使用", style: TextStyle(
                                                    color: ColorClass.common,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                )),
                                                highlightedBorderColor: ColorClass.common,
                                                borderSide:new BorderSide(color: ColorClass.common),
                                                splashColor: Color.fromRGBO(0, 0, 0, 0),
                                                shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(ScreenAdaper.width(5)))
                                                )
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
                title: Text("我的优惠卷", style: TextStyle(
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
                    labelStyle: TextStyle(
                        fontSize: ScreenAdaper.fontSize(34),
                        fontWeight: FontWeight.w700
                    ),
                    unselectedLabelStyle: TextStyle(
                        fontSize: ScreenAdaper.fontSize(34),
                        fontWeight: FontWeight.w700
                    ),
                    labelColor: ColorClass.titleColor,
                    unselectedLabelColor: ColorClass.fontColor,
                    tabs: <Widget>[
                        Container(
                            child: Tab(child: Text("未使用")),
                        ),
                        Tab(child: Text("已过期"))
                    ],
                    onTap: (int index) {
                        print(index);
                        index == 0 ? this._getNoUseData(isInit: true) : this._getBeOverdueData(isInit: true);
                    }
                )
            ),
            body: TabBarView(
                controller: this._tabController,
                children: <Widget>[
                    ListView.builder(
                        itemCount: this.notUseList.length,
                        itemBuilder: (BuildContext context, int index) {
                            return this._cardItem();
                        }
                    ),
                    ListView.builder(
                        itemCount: this.beOverdueList.length,
                        itemBuilder: (BuildContext context, int index) {
                            return this._cardItem(isBeOverdue: true);
                        }
                    )
                ]
            )
        );
    }
}
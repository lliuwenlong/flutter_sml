import 'dart:ui';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter/material.dart' as prefix0;

import 'package:flutter_sml/components/oldNestedScrollView/nested_scroll_view_inner_scroll_position_key_widget.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';
import 'package:flutter_sml/model/store/user/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/oldNestedScrollView/old_extended_nested_scroll_view.dart';
import '../Restaurant/Evaluate.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/LoadingSm.dart';
import './FoodServiceItem.dart';
import './Business.dart';
import '../../components/NullContent.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../components/SliverAppBarDelegate.dart';

import '../../model/api/restaurant/FoodFirmApiModel.dart';
import '../../model/api/restaurant/CouponsApiModel.dart';
import '../../model/api/restaurant/AppraiseDataModelApi.dart';
import './ServiceHtml.dart';
import 'package:intl/intl.dart';

class RestaurantDetails extends StatefulWidget {
    int id;
    int type;
    RestaurantDetails({Key key, this.id, this.type}) : super(key: key);
    _RestaurantDetailsState createState() => _RestaurantDetailsState();

}

class DefaultCombineDayWidgeta extends BaseCombineDayWidget {
    DefaultCombineDayWidgeta(DateModel dateModel) : super(dateModel);

    @override
    Widget getNormalWidget(DateModel dateModel) {
        return Container(
            width: ScreenAdaper.width(107),
            height: ScreenAdaper.width(115),
            alignment: Alignment.center,
            child: Text("${dateModel.day}")
        );
    }

    @override
    Widget getSelectedWidget(DateModel dateModel) {
        return Text("${dateModel.day}");
    }
}

Widget defaultCustomDayWidget(DateModel dateModel) {
    return DefaultCombineDayWidgeta(
        dateModel,
    );
}
class _RestaurantDetailsState extends State<RestaurantDetails> with SingleTickerProviderStateMixin{
    ScrollController _scrollViewController;
    ScrollController _scrollController;
    TabController _tabController;
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    int cutIndex = 0;
    double offset = 0;
    bool isOpen = true;
    HttpUtil http = HttpUtil();
    FoodFirmApiModel firm;
    bool _isLoading = true;
    List<CouponsDataApiModel> couponsData = [];
    int evaluateType = 1;
    List<AppraiseDataModelList> appraiseList = [];
    User _userModel;

    @override
    void initState() {
        super.initState();
        _scrollViewController = ScrollController(initialScrollOffset: 0.0);
        _scrollController = ScrollController(initialScrollOffset: 0.0);
        _tabController = TabController(vsync: this, length: 3);
        this._couponsData();
        this._getData();
        _scrollController.addListener(() {
            setState(() {
                this.offset = _scrollController.offset;
            });
        });
        _tabController.addListener(() {
            setState(() {
                this.cutIndex = _tabController.index;
            });
        });
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        this._appraiseData(0);
    }

    @override
    void dispose() {
        super.dispose();
        _scrollViewController.dispose();
        _tabController.dispose();
    }

    void showModalBottomSheetHandler () {}

    _getData () async {
        Map response = await this.http.get("/api/v1/firm/${widget.id}");
        if (response["code"] == 200) {
            setState(() {
                this.firm = FoodFirmApiModel.fromJson(response["data"]);
                this._isLoading = false;
            });
        }
    }

    _couponsData () async {
        Map response = await this.http.get("/api/v1/firm/${widget.id}/coupons/");
        if (response["code"] == 200) {
            CouponsApiModel res = CouponsApiModel.fromJson(response);
            setState(() {
                this.couponsData = res.data;
            });
        }
    }

    _appraiseData (int pic) async {
        Map response = await this.http.get("/api/v1/firm/${widget.id}/appraise", data: {
            "pageNO": 0,
            "pageSize": 0,
            "pic": pic
        });
        if (response["code"] == 200) {
            AppraiseDataModelApi res = AppraiseDataModelApi.fromJson(response);
            setState(() {
                this.appraiseList = res.data.list;
            });
        }
    }

    //拨打电话  
    _launchPhone () async {
        String url = 'tel:${this.firm.telphone}';
        if (await canLaunch(url)) {
            await launch(url);
        } else {
            throw 'Could not launch $url';
        }
    }

    //地图跳转
    _launchMap () async {
        String url = "androidamap://navi?sourceApplication=appname&poiname=fangheng&lat=36.547901&lon=104.258354&dev=1&style=2";
        if (await canLaunch(url)) {
            await launch(url);
        } else {
            throw 'Could not launch $url';
        }
    }

    void showModalCalendaHandler () {}
    
    // 领取优惠券
    _receiveCoupon (int id) async {
        Map res = await http.post("/api/v1/coupon/draw", data: {
            "couponId": id,
            "firmId": this.firm.firmId,
            "userId": this._userModel.userId
        });
        if (res["code"] == 200) {
            Fluttertoast.showToast(
                msg: "领取成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
        } else {
            Fluttertoast.showToast(
                msg: res["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
        }
    }

    dateFormData (String timee) {
        DateTime time = DateTime.parse(timee);
        DateFormat formatter = new DateFormat('yyyy-MM-dd');
        return formatter.format(time);
    }

    // label 标签
    Widget _label (String name) {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(10),
                ScreenAdaper.height(5),
                ScreenAdaper.width(10),
                ScreenAdaper.height(5)
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFFdac4a3), width: 1.0),
                color: Color(0XFFf8f5e8)
            ),
            child: Text("${name}", style: TextStyle(
                color: ColorClass.fontRed,
                fontSize: ScreenAdaper.fontSize(20)
            )),
        );
    }

    // 优惠券
    Widget _coupon (String name, String endTime, String price, int id) {
        return Container(
            width: ScreenAdaper.width(624),
            height: ScreenAdaper.height(180),
            margin: EdgeInsets.only(
                bottom: ScreenAdaper.height(30)
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "images/couponbg.png",
                    ),
                    fit: BoxFit.fill
                )
            ),
            child: Container(
                padding: EdgeInsets.all(ScreenAdaper.width(30)),
                child: Row(
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(419),
                            height: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "images/couponborder.png",
                                    ),
                                    fit: BoxFit.fill
                                )
                            ),
                            child: Row(
                                children: <Widget>[
                                    SizedBox(width: ScreenAdaper.width(20)),
                                    Text.rich(
                                        TextSpan(
                                            style: TextStyle(
                                                color: ColorClass.fontRed
                                            ),
                                            children: [
                                                TextSpan(
                                                    text: "¥",
                                                    style: TextStyle(
                                                        fontSize: ScreenAdaper.fontSize(30),
                                                        fontWeight: FontWeight.w500
                                                    )
                                                ),
                                                TextSpan(
                                                    text: "${price}",
                                                    style: TextStyle(
                                                        fontSize: ScreenAdaper.fontSize(80),
                                                        fontWeight: FontWeight.w500
                                                    )
                                                )
                                            ]
                                        )
                                    ),
                                    SizedBox(width: ScreenAdaper.width(20)),
                                    Container(
                                        height: double.infinity,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                Text("优惠券", style: TextStyle(
                                                    color: ColorClass.fontRed,
                                                    fontSize: ScreenAdaper.fontSize(30)
                                                )),
                                                Text("有效期至${dateFormData(endTime)}", style: TextStyle(
                                                    color: ColorClass.fontColor,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                ))
                                            ]
                                        )
                                    )
                                ]
                            ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: ScreenAdaper.width(20),
                                right: ScreenAdaper.width(20)
                            ),
                            width: ScreenAdaper.width(1),
                            height: ScreenAdaper.height(125),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "images/doashed.png",
                                    ),
                                    fit: BoxFit.fill
                                )
                            ),
                        ),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () {
                                    this._receiveCoupon(id);
                                },
                                child: Container(
                                    width: ScreenAdaper.width(94),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "images/couponborder2.png",
                                            ),
                                            fit: BoxFit.fill
                                        )
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                            Container(
                                                child: Column(
                                                    children: <Widget>[
                                                        Text("立即", style: TextStyle(
                                                            fontSize: ScreenAdaper.fontSize(24),
                                                            color: ColorClass.fontRed
                                                        )),
                                                        Text("领取", style: TextStyle(
                                                            fontSize: ScreenAdaper.fontSize(24),
                                                            color: ColorClass.fontRed
                                                        ))
                                                    ]
                                                ),
                                            ),
                                            Container(
                                                width: ScreenAdaper.width(70),
                                                height: ScreenAdaper.height(30),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Color(0xFFc1a786)
                                                ),
                                                child: Text("GO>", style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(24),
                                                    color: Colors.white
                                                ))
                                            )
                                        ]
                                    )
                                ),
                            )
                        )
                    ]
                ),
            )
        );
    }

    Widget _information () {
        return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Text(this.firm.name, style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(42, allowFontScaling: true)
                            )),
                            Text("营业时间：${this.firm.openTime}-${this.firm.closeTime}", style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                            ))
                        ]
                    ),
                    SizedBox(height: ScreenAdaper.height(34)),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            GestureDetector(
                                onTap: this._launchMap,
                                child: Icon(
                                    IconData(0Xe61d, fontFamily: "iconfont"),
                                    color: ColorClass.common,
                                    size: ScreenAdaper.fontSize(30,  allowFontScaling: true)
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenAdaper.width(20)
                                    ),
                                    child: Row(
                                        children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Text("${this.firm.city}${this.firm.county}${this.firm.address}", style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true),
                                                    color: ColorClass.fontColor
                                                )),
                                            ),
                                            SizedBox(
                                                width: ScreenAdaper.width(75)
                                            ),
                                            GestureDetector(
                                                onTap: this._launchPhone,
                                                child: Icon(
                                                    IconData(0Xe639, fontFamily: "iconfont"),
                                                    color: ColorClass.common,
                                                    size: ScreenAdaper.fontSize(40,  allowFontScaling: true)
                                                )
                                            )
                                        ]
                                    ),
                                ),
                            )
                        ]
                    ),
                    SizedBox(height: ScreenAdaper.height(this.couponsData.isNotEmpty ? 25 : 0)),
                    this.isOpen ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: this.couponsData.isNotEmpty ? <Widget>[
                            Expanded(
                                flex: 1,
                                child: Wrap(
                                    spacing: ScreenAdaper.width(10),
                                    runSpacing: ScreenAdaper.height(10),
                                    children: (this.couponsData.length > 2 ? this.couponsData.take(2) : this.couponsData).map((item) {
                                        return _label(item.name);
                                    }).toList(),
                                )
                            ),
                            Container(
                                width: ScreenAdaper.width(40),
                                height: ScreenAdaper.height(50),
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: () {
                                        setState(() {
                                            this.isOpen = false;
                                        });
                                    },
                                    icon: Icon(
                                        IconData(0xe63a, fontFamily: "iconfont"),
                                        size: ScreenAdaper.fontSize(16),
                                        color: ColorClass.iconColor,
                                    )
                                )
                            )
                        ] : []
                    ) : Container(
                        alignment: Alignment.center,
                        child: Column(
                            children: <Widget>[
                                ...this.couponsData.map((item) {
                                    return  _coupon(item.name, item.endDate, item.worth, item.couponId);
                                }).toList(),
                                IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                        setState(() {
                                            this.isOpen = true;
                                        });
                                    },
                                    icon: Icon(
                                        IconData(0xe63b, fontFamily: "iconfont"),
                                        size: ScreenAdaper.fontSize(16),
                                        color: ColorClass.iconColor,
                                    )
                                )
                            ],
                        )
                    )
                ]
            ),
        );
    }

    Widget _dateWidget () {
        return Container(
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(20)
            ),
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                ScreenAdaper.height(30),
                ScreenAdaper.width(30),
                ScreenAdaper.height(30)
            ),
            child: GestureDetector(
                onTap: () {
                    showModalCalendaHandler();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                Text("8月3日", style: TextStyle(
                                    color: ColorClass.date,
                                    fontSize: ScreenAdaper.fontSize(34, allowFontScaling: true)
                                )),
                                SizedBox(width: ScreenAdaper.width(20)),
                                Text("今日入住", style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                                )),
                                SizedBox(width: ScreenAdaper.width(30)),
                                Container(
                                    width: ScreenAdaper.width(40),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                            color: Color(0XFFd9d9d9),
                                            width: 1
                                        ))
                                    ),
                                ),
                                SizedBox(width: ScreenAdaper.width(30)),
                                Text("8月3日", style: TextStyle(
                                    color: ColorClass.date,
                                    fontSize: ScreenAdaper.fontSize(34, allowFontScaling: true)
                                )),
                                SizedBox(width: ScreenAdaper.width(20)),
                                Text("周五离店", style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                                ))
                            ]
                        ),
                        Row(
                            children: <Widget>[
                                Text("共1晚", style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                                )),
                                SizedBox(
                                    width: ScreenAdaper.width(20),
                                ),
                                Icon(
                                    IconData(0Xe61e, fontFamily: "iconfont"),
                                    color: Color(0XFFaaaaaa),
                                    size: ScreenAdaper.fontSize(24,  allowFontScaling: true)
                                )
                            ]
                        )
                    ]
                ),
            )
        ); 
    }

    // appBar
    Widget _sliverBuilder () {
        return SliverAppBar(
            title: Text(this.offset > 20 ? "${this.firm.name}" : "", style: TextStyle(
                color: Colors.black,
                fontSize: ScreenAdaper.fontSize(28)
            )),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            expandedHeight: ScreenAdaper.height(300),
            floating: false,
            brightness: Brightness.light,
            pinned: true,
            snap: false,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
                background: GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(context, "/merchantAlbum",arguments: {
                          'imgList':this.firm.goodsAttaches
                        });
                    },
                    child: Image.network(
                      	this.firm.logo,
                        fit: BoxFit.fill
                    )
                ),
            )
        );
    }
    
    // 评价button 
    Widget __evaluateButton () {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Container(
                    width: ScreenAdaper.width(460),
                    height: ScreenAdaper.width(75),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                    ),
                    child: Row(
                        children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: RaisedButton(
                                    elevation: 0,
                                    color: evaluateType == 1 ? Color(0XFF22b0a1) : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(ScreenAdaper.width(10)),
                                            bottomLeft: Radius.circular(ScreenAdaper.width(10))
                                        ),
                                        side: BorderSide(
                                            color: ColorClass.common,
                                            width: 1
                                        )
                                    ),
                                    onPressed: () {
                                        this._appraiseData(0);
                                        setState(() {
                                            this.evaluateType = 1;
                                        });
                                    },
                                    child: Text("全部", style: TextStyle(
                                        color:  evaluateType == 1 ? Colors.white : Color(0XFF22b0a1),
                                        fontSize: ScreenAdaper.fontSize(30)
                                    )),
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: RaisedButton(
                                    elevation: 0,
                                    color:evaluateType != 1 ? Color(0XFF22b0a1) : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(ScreenAdaper.width(10)),
                                            bottomRight: Radius.circular(ScreenAdaper.width(10))
                                        ),
                                        side: BorderSide(
                                            color: ColorClass.common,
                                            width: 1
                                        )
                                    ),
                                    onPressed: () {
                                        this._appraiseData(1);
                                        setState(() {
                                            this.evaluateType = 2;
                                        });
                                    },
                                    child: Text("有图", style: TextStyle(
                                        color: evaluateType != 1 ? Colors.white : Color(0XFF22b0a1),
                                        fontSize: ScreenAdaper.fontSize(30)
                                    )),
                                )
                            )
                        ]
                    )
                ),
                GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(context, "/releaseEvaluate", arguments: {
                            "firmId": this.firm.firmId,
                            "name": this.firm.name,
                        });
                    },
                    child: Container(
                        width: ScreenAdaper.width(160),
                        height: ScreenAdaper.width(75),
                        decoration: BoxDecoration(
                            color: Color(0XFFc1a786),
                            border: Border.all(
                                color: Color(0XFFc1a786),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Icon(
                                    IconData(0xe640, fontFamily: 'iconfont'),
                                    color: Colors.white,
                                    size: ScreenAdaper.fontSize(37),
                                ),
                                SizedBox(width: ScreenAdaper.width(10)),
                                Text("评价", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(30),
                                    color: Colors.white
                                ))
                            ],
                        ),
                    )
                )
            ]
        );
    }
    
    @override
    Widget build(BuildContext context) {
        final double statusBarHeight = MediaQuery.of(context).padding.top;
        var primaryTabBar =TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: ScreenAdaper.height(6),
            indicatorColor: Color(0XFF22b0a1),
            controller: this._tabController,
            labelColor: ColorClass.titleColor,
            unselectedLabelColor: ColorClass.fontColor,
            labelStyle: TextStyle(
                fontWeight: FontWeight.w600
            ),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal
            ),
            tabs: <Widget>[
                Tab(child: Text("服务", style: TextStyle(
                    fontSize: ScreenAdaper.fontSize(34),
                ))),
                Tab(child: Text("评价", style: TextStyle(
                    fontSize: ScreenAdaper.fontSize(34),
                ))),
                Tab(child: Text("商家", style: TextStyle(
                    fontSize: ScreenAdaper.fontSize(34),
                )))
            ]
        );
        var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
        return Scaffold(
            bottomSheet:  widget.type ==4 ? null : Container(
                width: double.infinity,
                height: ScreenAdaper.height(110) + MediaQueryData.fromWindow(window).padding.bottom,
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom + ScreenAdaper.height(10),
                    top: ScreenAdaper.height(10),
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 1)
                    ]
                ),
                child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                        Navigator.pushNamed(context, "/payment", arguments: {
                            "amount": 155,
                            "type": widget.type,
                            "firmId": widget.id
                        });
                    },
                    color: ColorClass.common,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                    ),
                    child: Text(widget.type == 1 ? "买单" : "付款", style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdaper.fontSize(28)
                    ))
                )
            ),
            body: !_isLoading
                ? NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (c, f) {
                        return [
                            this._sliverBuilder(),
                            SliverToBoxAdapter(
                                child: Column(
                                    children: <Widget>[
                                        this._information(),
                                        SizedBox(height: ScreenAdaper.height(20))
                                    ]
                                ),
                            )
                        ];
                    },
                    pinnedHeaderSliverHeightBuilder: () {
                        return pinnedHeaderHeight;
                    },
                    innerScrollPositionKeyBuilder: () {
                        var index = "Tab";
                        index += _tabController.index.toString();
                        return Key(index);
                    },
                    body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0XFFd9d9d9),
                                            width: 1
                                        )
                                    )
                                ),
                                child: primaryTabBar,
                            ),
                            Expanded(
                                child: TabBarView(
                                    controller: _tabController,
                                    children: <Widget>[
                                        NestedScrollViewInnerScrollPositionKeyWidget(
                                            Key("Tab0"),
                                            new MediaQuery.removePadding(
                                                removeTop: true,
                                                context: context,
                                                child: this.firm.goods != null && this.firm.goods.isNotEmpty
                                                ? ListView.builder(
                                                    key: PageStorageKey("Tab0"),
                                                    padding: EdgeInsets.only(
                                                        bottom: ScreenAdaper.height(110) + MediaQueryData.fromWindow(window).padding.bottom,
                                                    ),
                                                    itemBuilder: (BuildContext context, int index) {
                                                        Goods good = this.firm.goods[index];
                                                        return GestureDetector(
                                                            onTap: () {
                                                                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                                                    return new ServiceHtml(good.goodsId, widget.type, price: good.price, firmId: this.firm.firmId);
                                                                }));
                                                            },
                                                            child: FoodServiceItem(
                                                                good.name,
                                                                good.picture,
                                                                good.title,
                                                                good.price,
                                                                isShowBorder: index == this.firm.goods.length - 1 ? false : true
                                                            ),
                                                        );
                                                    },
                                                    itemCount: this.firm.goods != null ? this.firm.goods.length : 0,
                                                )
                                                : NullContent("暂无数据"),
                                            )
                                            
                                        ),
                                        NestedScrollViewInnerScrollPositionKeyWidget(
                                            Key("Tab1"),
                                            new MediaQuery.removePadding(
                                                removeTop: true,
                                                context: context,
                                                child: ListView(
                                                    key: PageStorageKey("Tab1"),
                                                    padding: EdgeInsets.only(
                                                        bottom: ScreenAdaper.height(110) + MediaQueryData.fromWindow(window).padding.bottom,
                                                    ),
                                                    children: <Widget>[
                                                        Container(
                                                            margin: EdgeInsets.only(
                                                                top: ScreenAdaper.height(20)
                                                            ),
                                                            padding: EdgeInsets.only(
                                                                left: ScreenAdaper.width(30),
                                                                right: ScreenAdaper.width(30),
                                                            ),
                                                            child: this.__evaluateButton(),
                                                        ),
                                                        this.appraiseList != null && this.appraiseList.isNotEmpty
                                                            ? ListView.builder(
                                                                shrinkWrap: true,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemBuilder: (BuildContext context, int index) {
                                                                    AppraiseDataModelList appraiseDataModelList = this.appraiseList[index];
                                                                    return Evaluate(
                                                                        appraiseDataModelList.content,
                                                                        appraiseDataModelList.createTime,
                                                                        appraiseDataModelList.nickName,
                                                                        appraiseDataModelList.headerImage,
                                                                        appraiseDataModelList.imageUrl,
                                                                        isBorder: index == this.appraiseList.length - 1 ? false : true,
                                                                    );
                                                                },
                                                                itemCount: this.appraiseList.length,
                                                            )
                                                            : Container(
                                                                height: 300,
                                                                child: NullContent("暂无数据"),
                                                            )
                                                    ]
                                                )
                                            )
                                        ),
                                        NestedScrollViewInnerScrollPositionKeyWidget(
                                            Key("Tab2"),
                                            Wrap(
                                                key: PageStorageKey("Tab2"),
                                                children: <Widget>[
                                                    Business("商家名称", subTitle: this.firm.name),
                                                    Business("商家分类", subTitle: this.firm.tags),
                                                    Business("商家地址", subTitle: '${this.firm.province}${this.firm.city}${this.firm.county}${this.firm.address}'),
                                                    GestureDetector(
                                                        onTap: _launchPhone,
                                                        child: Business("商家电话", subTitle: this.firm.telphone, isBorder: false, color: ColorClass.common),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: ScreenAdaper.height(20)
                                                        ),
                                                        child: GestureDetector(
                                                        onTap: (){
                                                            Navigator.pushNamed(context, '/businessQualification',arguments: {
                                                              'imgList':this.firm.attachs
                                                            });
                                                        },
                                                        child: Business(
                                                            "商家资质",
                                                            subTitle: "",
                                                            isBorder: false,
                                                            isIcon: true,
                                                            icon: Icon(IconData(
                                                                0xe61e,
                                                                fontFamily: "iconfont"
                                                            ), color: Color(0xFFaaaaaa), size: ScreenAdaper.fontSize(30),)
                                                        ),
                                                        )
                                                    )
                                                ]
                                            )
                                        )
                                    ]
                                ),
                            )
                        ],
                    ),
                )
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 200
                    ),
                    child: Loading()
                )
        );
    }
}
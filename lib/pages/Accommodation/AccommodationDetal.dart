import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter/material.dart' as prefix0;

import 'package:flutter_sml/components/LoadingSm.dart';
import 'package:flutter_sml/components/NullContent.dart';
import 'package:flutter_sml/components/oldNestedScrollView/nested_scroll_view_inner_scroll_position_key_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Restaurant/Evaluate.dart';
import '../../services/ScreenAdaper.dart';
import './bottomSheet/Reserve.dart';
import '../../components/oldNestedScrollView/old_extended_nested_scroll_view.dart';
import '../Restaurant/ServiceItem.dart';
import './Business.dart';
import '../../components/ShowBottomModelAlert.dart' as ShowBottomModelAlert;
import '../../components/calendarPage/calendar_page.dart';

import '../../common/Color.dart';
import 'package:flutter_sml/common/HttpUtil.dart';

import '../../model/api/restaurant/AppraiseDataModelApi.dart';
import 'package:flutter_sml/model/api/restaurant/CouponsApiModel.dart';
import 'package:flutter_sml/model/api/restaurant/FoodFirmApiModel.dart';

class AccommodationDetal extends StatefulWidget {
    int id;
    AccommodationDetal({Key key, this.id}) : super(key: key);
    _AccommodationDetalState createState() => _AccommodationDetalState();

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
class _AccommodationDetalState extends State<AccommodationDetal> with SingleTickerProviderStateMixin{
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

    @override
    void initState() {
        super.initState();
        _scrollViewController = ScrollController(initialScrollOffset: 0.0);
        _scrollController = ScrollController(initialScrollOffset: 0.0);
        _tabController = TabController(vsync: this, length: 3);
        this._getData();
        this._couponsData();
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
    void dispose() {
        super.dispose();
        _scrollViewController.dispose();
        _tabController.dispose();
    }
    
    void showModalBottomSheetHandler () {
        ShowBottomModelAlert.showModalBottomSheet(
            context: context,
            shape:  RoundedRectangleBorder(
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(ScreenAdaper.width(10)),
					topRight: Radius.circular(ScreenAdaper.width(10)),
				)
			),
            builder: (BuildContext context){
                return Container(
                    color: Colors.white,
                    child: Reserve()
                );
            }
        );
    }
    
    void showModalCalendaHandler () {
        showModalBottomSheet(
            context: context,
            shape:  RoundedRectangleBorder(
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(ScreenAdaper.width(10)),
					topRight: Radius.circular(ScreenAdaper.width(10)),
				)
			),
            builder: (BuildContext context){
                return Container(
                    color: Colors.white,
                    child: CalendarPage()
                );
            }
        );
    }

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

    _appraiseData () async {
        Map response = await this.http.get("/api/v1/firm/${widget.id}/appraise", data: {
            "pageNO": 1,
            "pageSize": 10
        });
        if (response["code"] == 200) {
            AppraiseDataModelApi res = AppraiseDataModelApi.fromJson(response);
            setState(() {
                this.appraiseList = res.data.list;
            });
        }
    }

    _launchPhone () async {
        String url = 'tel:${this.firm.telphone}';
        if (await canLaunch(url)) {
            await launch(url);
        } else {
            throw 'Could not launch $url';
        }
    }

    _launchMap () async {
        String url = Platform.isAndroid
            ? "androidamap://navi?sourceApplication=appname&poiname=fangheng&lat=36.547901&lon=104.258354&dev=1&style=2"
            : "iosamap://navi?sourceApplication=applicationName&poiname=fangheng&poiid=BGVIS&lat=36.547901&lon=104.258354&dev=1&style=2";

        if (await canLaunch(url)) {
            try {
                await launch(url);
            } catch (e) {

            }
        } else {
            throw 'Could not launch $url';
        }
    }
    // 优惠券
    Widget _coupon () {
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
                                                    text: "20",
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
                                                Text("有效期至2019.07.09", style: TextStyle(
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
                            )
                        )
                        
                    ]
                ),
            )
        );
    }

    // label 标签
    Widget _label () {
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
            child: Text("10元优惠券", style: TextStyle(
                color: ColorClass.fontRed,
                fontSize: ScreenAdaper.fontSize(20)
            )),
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
                    this.couponsData.isNotEmpty
                        ? SizedBox(height: ScreenAdaper.height(18))
                        : SizedBox(),
                    this.isOpen ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: this.couponsData.isNotEmpty ? <Widget>[
                            Expanded(
                                flex: 1,
                                child: Wrap(
                                    spacing: ScreenAdaper.width(10),
                                    runSpacing: ScreenAdaper.height(10),
                                    children: <Widget>[
                                        this._label(),
                                        this._label()
                                    ],
                                )
                            ),
                            Container(
                                width: ScreenAdaper.width(30),
                                height: ScreenAdaper.height(40),
                                alignment: Alignment.center,
                                child: GestureDetector(
                                    onTap: () {
                                        setState(() {
                                            this.isOpen = false;
                                        });
                                    },
                                    child: Icon(
                                        IconData(0xe63a, fontFamily: "iconfont"),
                                        size: ScreenAdaper.fontSize(16),
                                        color: ColorClass.iconColor,
                                    ),
                                )
                            )
                        ] : []
                    ) : Container(
                        alignment: Alignment.center,
                        child: Column(
                            children: <Widget>[
                                _coupon(),
                                _coupon(),
                                _coupon(),
                                _coupon(),
                                GestureDetector(
                                    onTap: () {
                                        setState(() {
                                            this.isOpen = true;
                                        });
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        child: Icon(
                                            IconData(0xe63b, fontFamily: "iconfont"),
                                            size: ScreenAdaper.fontSize(16),
                                            color: ColorClass.iconColor,
                                        )
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
            title: Text(this.offset > 20 ? "标题" : "", style: TextStyle(
                color: Colors.black,
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
                background: Image.network(
                    "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                        fit: BoxFit.fill
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

    Widget _evaluate () {
        return Container(
            padding: EdgeInsets.only(
                top: ScreenAdaper.width(30)
            ),
            child: Column(
                children: <Widget>[
                    _tabController.index != 1
                        ? Container(
                            padding: EdgeInsets.only(
                                left: ScreenAdaper.width(30),
                                right: ScreenAdaper.width(30)
                            ),
                            child: this.__evaluateButton(),
                        )
                        : SizedBox(),
                    new Wrap(
                        children: <Widget>[
                            Evaluate(),
                            Evaluate(),
                            Evaluate(),
                            Evaluate(),
                            Evaluate(),
                            Evaluate()
                        ]
                    )
                ]
            )
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
                    // fontWeight: FontWeight.normal
                ))),
                Tab(child: Text("评价", style: TextStyle(
                    fontSize: ScreenAdaper.fontSize(34),
                    // fontWeight: FontWeight.normal
                ))),
                Tab(child: Text("商家", style: TextStyle(
                    fontSize: ScreenAdaper.fontSize(34),
                    // fontWeight: FontWeight.normal
                )))
            ]
        );

        var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
        return Scaffold(
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
                                    this._dateWidget(),
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
                                        this.firm.goods != null && this.firm.goods.length > 0
                                            ? new MediaQuery.removePadding(
                                                removeTop: true,
                                                context: context,
                                                child: SmartRefresher(
                                                    controller: _refreshController,
                                                    enablePullDown: false,
                                                    enablePullUp: false,
                                                    header: WaterDropHeader(),
                                                    footer: ClassicFooter(
                                                        loadStyle: LoadStyle.ShowWhenLoading,
                                                        idleText: "上拉加载",
                                                        failedText: "加载失败！点击重试！",
                                                        canLoadingText: "加载更多",
                                                        noDataText: "没有更多数据",
                                                        loadingText: "加载中"
                                                    ),
                                                    child: ListView.builder(
                                                        key: PageStorageKey("Tab0"),
                                                        itemBuilder: (BuildContext context, int index) {
                                                            return GestureDetector(
                                                                onTap: () {
                                                                    showModalBottomSheetHandler();
                                                                },
                                                                child: ServiceItem(),
                                                            );
                                                        },
                                                        itemCount: this.firm.goods != null ? this.firm.goods.length : 0,
                                                    )
                                                ),
                                            )
                                            : NullContent("暂无数据")
                                        
                                    ),
                                    NestedScrollViewInnerScrollPositionKeyWidget(
                                        Key("Tab1"),
                                        new MediaQuery.removePadding(
                                            removeTop: true,
                                            context: context,
                                            child: ListView(
                                                key: PageStorageKey("Tab1"),
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
                                                    this.appraiseList.isNotEmpty
                                                        ? Wrap(
                                                            children: <Widget>[
                                                                Evaluate(),
                                                                Evaluate(),
                                                                Evaluate(),
                                                                Evaluate(),
                                                                Evaluate(),
                                                                Evaluate()
                                                            ]
                                                        )
                                                        : Container(
                                                            height: 300,
                                                            child: NullContent("暂无数据"),
                                                        )
                                                ],
                                            )
                                        )
                                    ),
                                    NestedScrollViewInnerScrollPositionKeyWidget(
                                        Key("Tab2"),
                                        Wrap(
                                            key: PageStorageKey("Tab2"),
                                            children: <Widget>[
                                                Business("商家名称", subTitle: "人间有味"),
                                                Business("商家分类", subTitle: "住宿"),
                                                Business("商家地址", subTitle: "贵州省黔西南布依族苗族自治州兴义市湖南街30附近"),
                                                Business("商家电话", subTitle: "0859-3567373", isBorder: false),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenAdaper.height(20)
                                                    ),
                                                    child: GestureDetector(
                                                        onTap: (){
                                                            Navigator.pushNamed(context, '/businessQualification');
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
            : Center(
                child: Loading(isCenter: true),
            )
        );
    }
}
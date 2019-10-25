import 'package:flutter/material.dart';
import 'package:flutter_sml/pages/Accommodation/AccommodationDetal.dart';
import 'package:flutter_sml/pages/Restaurant/RestaurantDetails.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
import '../../components/LoadingSm.dart';
import '../../model/api/coupon/CouponData.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/NullContent.dart';
class Coupon extends StatefulWidget {
    Coupon({Key key}) : super(key: key);
    _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> with SingleTickerProviderStateMixin {
    TabController _tabController;
    RefreshController _notUseRefreshController = RefreshController(initialRefresh: false);
    RefreshController _beOverdueListRefreshController = RefreshController(initialRefresh: false);
    bool isNotUseLoading = true;
    bool isBeOverdueLoading = true;
    HttpUtil http = HttpUtil();
    int notUsePage = 1;
    int beOverduePage = 1;
    User userModel;
    List notUseList = [];
    List beOverdueList = [];
    Map<String, Icon> iconMap = {
        "food": Icon(IconData(0xe659, fontFamily: "iconfont"), color: Color(0xFFf6cf70), size: ScreenAdaper.fontSize(80)),
        "house": Icon(IconData(0xe657, fontFamily: "iconfont"),  color: Color(0xFFc1a786), size: ScreenAdaper.fontSize(80)),
    };

    Map<String, Icon> beOverdueIconMap = {
        "food": Icon(IconData(0xe659, fontFamily: "iconfont"), color: Color(0xFFaaaaaa), size: ScreenAdaper.fontSize(80)),
        "house": Icon(IconData(0xe657, fontFamily: "iconfont"),  color: Color(0xFFaaaaaa), size: ScreenAdaper.fontSize(80)),
    };

    Map<String, int> typeMap = {
        "food": 1,
        "nearplay": 3,
        "shopping": 2
    };
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        userModel = Provider.of<User>(context);
        this._getData(isInit: true);
    }

    @override
    void initState () {
        super.initState();
        _tabController = new TabController(
            vsync: this,
            length: 3
        );
    }



    _getData ({bool isInit = false}) async {
        if (
            isInit
            && ((this._tabController.index == 0 && this.isNotUseLoading == false)
            || (this._tabController.index == 1 && this.isBeOverdueLoading == false))
        ) {
            return null;
        }

        final Map<String, dynamic> response = await this.http.get("/api/v1/coupon/data", data: {
            "pageNO": _tabController.index == 0 ? this.notUsePage : this.beOverduePage,
            "pageSize": 10,
            "userId": this.userModel.userId,
            "type": _tabController.index + 1
        });
        if (response["code"] == 200) {
            final res = new CouponDataModel.fromJson(response);
            if (isInit) {
                setState(() {
                    if (_tabController.index == 0) {
                        notUseList = res.data.list;
                        isNotUseLoading = false;
                    } else {
                        beOverdueList = res.data.list;
                        isBeOverdueLoading = false;
                    }
                    
                });
            } else {
                setState(() {
                    if (_tabController.index == 0) {
                        notUseList.addAll(res.data.list);
                    } else {
                        beOverdueList.addAll(res.data.list);
                    }
                });
            }
        }
        return response;
    }

    void _onLoading() async{
        setState(() {
            if (_tabController.index == 0) {
                this.beOverduePage++;
            } else {
                this.notUsePage++;
            }
        });
        var controller = _tabController.index == 0
            ? this._notUseRefreshController
            : this._beOverdueListRefreshController;
        var response = await _getData();
        if (response["data"].length == 0) {
            controller.loadNoData();
        } else {
            controller.loadComplete();
        }
    }

    void _onRefresh() async{
        setState(() {
            if (_tabController.index == 0) {
                this.beOverduePage = 1;
            } else {
                this.notUsePage = 1;
            }
        });
        var controller = _tabController.index == 0
            ? this._notUseRefreshController
            : this._beOverdueListRefreshController;
        final Map res = await _getData(isInit: true);
        controller.refreshCompleted();
        if (controller.footerStatus == LoadStatus.noMore) {
            controller.loadComplete();
        }
    }

    Widget _cardItem (ListItem data,{isBeOverdue: false}) {
        Map<String, Icon> icon = isBeOverdue ? this.beOverdueIconMap : this.iconMap;
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
                                            child: data.firmId == 0 || data.firmId == null
                                                ? icon[data.type]
                                                : Image.network(
                                                    data.coverImage != null ? data.coverImage : "",
                                                    fit: BoxFit.cover,
                                                ),
                                        ),
                                    ),
                                    SizedBox(width: ScreenAdaper.width(20)),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(data.name != null ? data.name : "", style: TextStyle(
                                                color: isBeOverdue ? ColorClass.iconColor : Color(0XFF333333),
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )),
                                            SizedBox(height: ScreenAdaper.height(15)),
                                            Text("有效期至：${data.endDate}", style: TextStyle(
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
                                                        child: Text.rich(
                                                            TextSpan(
                                                                children: [
                                                                    TextSpan(text: "¥", style: TextStyle(
                                                                        color: isBeOverdue ? ColorClass.iconColor : Color(0XFFfb4135),
                                                                        fontSize: ScreenAdaper.fontSize(24)
                                                                    )),
                                                                    TextSpan(text: "${data.worth}", style: TextStyle(
                                                                        color: isBeOverdue ? ColorClass.iconColor : Color(0XFFfb4135),
                                                                        fontSize: ScreenAdaper.fontSize(44)
                                                                    ))
                                                                ]
                                                            )
                                                        )
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
                            height: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("images/doast.png"),
                                        fit: BoxFit.fill
                                    )
                                ),
                            ),
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
                                    data.firmId==0?Text("平台赠送", style: TextStyle(
                                        color: isBeOverdue ? ColorClass.iconColor : ColorClass.fontColor,
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )):Text(data.title != null ? data.title : "", style: TextStyle(
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
                                                onPressed: () {
                                                    if(data.firmId == 0 || data.firmId == null){
                                                        if (data.type == 'house') {
                                                            Navigator.pushNamed(context, '/accommodation');
                                                        } else if (data.type == 'havefun') {
                                                            Navigator.pushNamed(context, '/entertainment');
                                                        } else {
                                                            Navigator.pushNamed(context, '/restaurant', arguments: {
                                                                "type": this.typeMap[data.type]
                                                            });
                                                        }
                                                    } else{
                                                        if (data.type == 'house') {
                                                            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                                                return new AccommodationDetal(id: data.firmId);
                                                            }));
                                                        } else if (data.type == 'havefun') {
                                                            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                                                return new RestaurantDetails(id: data.firmId, type: 4);
                                                            }));
                                                        } else {
                                                            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                                                return new RestaurantDetails(id: data.firmId, type: this.typeMap[data.type]);
                                                            }));
                                                        }
                                                    }
                                                },
                                                child: Text("立即使用", style: TextStyle(
                                                    color: ColorClass.common,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                )),
                                                highlightedBorderColor: ColorClass.common,
                                                borderSide: new BorderSide(color: ColorClass.common),
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
                title: Text("我的优惠券", style: TextStyle(
                    color: Colors.black,
                     fontSize: ScreenAdaper.fontSize(34)
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
                        Tab(child: Text("已过期")),
                        Tab(child: Text("已使用"))
                    ],
                    onTap: (int index) {
                        this._getData(isInit: true);
                    }
                )
            ),
            body: TabBarView(
                controller: this._tabController,
                children: <Widget>[
                    SmartRefresher(
                        controller: _notUseRefreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: ClassicFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                            idleText: "上拉加载",
                            failedText: "加载失败！点击重试！",
                            canLoadingText: "加载更多",
                            noDataText: "没有更多数据",
                            loadingText: "加载中"
                        ),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: this.isNotUseLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.notUseList.length <= 0 ? NullContent('暂无数据'):
                             ListView.builder(
                                itemCount: this.notUseList.length,
                                itemBuilder: (BuildContext context, int index) {
                                    var data = this.notUseList[index];
                                    return this._cardItem(data);
                                }
                            )
                    ),
                    SmartRefresher(
                        controller: _beOverdueListRefreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: ClassicFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                            idleText: "上拉加载",
                            failedText: "加载失败！点击重试！",
                            canLoadingText: "加载更多",
                            noDataText: "没有更多数据",
                            loadingText: "加载中"
                        ),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: this.isBeOverdueLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ):this.beOverdueList.length <=0 ? NullContent('暂无数据')
                            : ListView.builder(
                                itemCount: this.beOverdueList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = this.beOverdueList[index];
                                    return this._cardItem(data,isBeOverdue: true);
                                }
                            )
                    ),
                    Container(
                        child: NullContent('暂无数据')
                    )
                ]
            )
        );
    }
}
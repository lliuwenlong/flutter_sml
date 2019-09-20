import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/restaurant/FoodModel.dart';
import '../../components/LoadingSm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Accommodation extends StatefulWidget {
    Accommodation({Key key}) : super(key: key);
    _AccommodationState createState() => _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
    final HttpUtil http = HttpUtil();
    int _page = 1;
    bool isLoading = true;
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    List list = [];

    @override
    initState() {
        super.initState();
        this._getData(isInit: true);
    }

    _getData ({isInit: false}) async {
        Map response = await this.http.post("/api/v1/firm/house/", data: {
            "pageNO": _page,
            "pageSize": 10
        });
        Map<String, dynamic> resItem = {
            "account": "string",
            "accountBank": "string",
            "accountName": "string",
            "accountPhone": "string",
            "address": "string",
            "applyStatus": "string",
            "cardNo": "string",
            "city": "string",
            "closeTime": "string",
            "county": "string",
            "createTime": "2019-09-09T01:56:47.415Z",
            "firmId": 0,
            "idcardBack": "string",
            "idcardFront": "string",
            "idcardHuman": "string",
            "logo": "string",
            "mainGoods": "string",
            "name": "string",
            "officerName": "string",
            "officerPhone": "string",
            "openTime": "string",
            "perPrice": "string",
            "province": "string",
            "status": "string",
            "telphone": "string",
            "type": "string"
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
            // final res = new FoodModel.fromJson(response);
            final res = new FoodModel.fromJson(resData);
            if (isInit) {
                setState(() {
                    list = res.data.list;
                    isLoading = false;
                });
                return response;
            } else {
                setState(() {
                    list.addAll(res.data.list);
                });
                return response;
            }
        }
        return response;
    }

    void _onLoading() async{
        setState(() {
            this._page++;
        });
        var response = await _getData();
        if (response["data"].length == 0) {
            _refreshController.loadNoData();
        } else {
            _refreshController.loadComplete();
        }
    }

    void _onRefresh() async{
        setState(() {
            this._page = 1;
        });
        await _getData(isInit: true);
        _refreshController.refreshCompleted();
        if (_refreshController.footerStatus == LoadStatus.noMore) {
            _refreshController.loadComplete();
        }
    }

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
                fontSize: ScreenAdaper.fontSize(24)
            )),
        );
    }
    Widget _listItem (String name, String type, double price, String city) {
        return Container(
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Container(
                padding: EdgeInsets.all(ScreenAdaper.width(30)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(190),
                            height: ScreenAdaper.height(238),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                    "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                    fit: BoxFit.cover,
                                ),
                            ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.only(left: ScreenAdaper.width(30)),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                                Text(name, style: TextStyle(
                                                    color: ColorClass.titleColor,
                                                    fontSize: ScreenAdaper.fontSize(30)
                                                )),
                                                SizedBox(width: ScreenAdaper.width(10)),
                                                Text(type, style: TextStyle(
                                                    color: ColorClass.titleColor,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                )),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                        alignment: Alignment.bottomRight,
                                                        child: Text("<500米", style: TextStyle(
                                                            color: ColorClass.fontColor,
                                                            fontSize: ScreenAdaper.fontSize(24)
                                                        )
                                                    ),
                                                ))
                                            ]
                                        ),
                                        SizedBox(height: ScreenAdaper.height(30)),
                                        Text(city, style: TextStyle(
                                            color: ColorClass.fontColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ), overflow: TextOverflow.ellipsis),
                                        SizedBox(height: ScreenAdaper.height(20)),
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                                Text("¥", style: TextStyle(
                                                    color: ColorClass.fontRed,
                                                    fontSize: ScreenAdaper.fontSize(26)
                                                )),
                                                Text(price.toString(), style: TextStyle(
                                                    color: ColorClass.fontRed,
                                                    fontSize: ScreenAdaper.fontSize(44)
                                                )),
                                                Text("起", style: TextStyle(
                                                    color: ColorClass.subTitleColor,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                ))
                                            ]
                                        ),
                                        SizedBox(height: ScreenAdaper.height(25)),
                                        Wrap(
                                            spacing: ScreenAdaper.width(10),
                                            runSpacing: ScreenAdaper.height(10),
                                            children: <Widget>[
                                                this._label(),
                                                this._label()
                                            ]
                                        )
                                    ]
                                )
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
        return Container(
            child: Scaffold(
                appBar: PreferredSize(
                    child: AppBarWidget().buildAppBar("神木住宿"),
                    preferredSize: Size.fromHeight(ScreenAdaper.height(110))
                ),
                body: this.isLoading
                    ? Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(200)
                        ),
                        child: Loading()
                    )
                    :  SmartRefresher(
                    controller: _refreshController,
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
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(context, "/accommodationDetal");
                                },
                                child: this._listItem(
                                    "边屯酒家",
                                    "豪华型",
                                    188,
                                    "贵州省黔西南布依族苗族自治州兴义市鲁"
                                )
                            );
                        },
                        itemCount: this.list.length,
                    )
                )
            )
        );
    }
}
import 'package:flutter/material.dart';
import 'package:flutter_sml/common/CommonHandler.dart';
import 'package:flutter_sml/services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/restaurant/FoodModel.dart';
import '../../components/LoadingSm.dart';
import './AccommodationDetal.dart';
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

        if (response["code"] == 200) {
            var loction = await getLoction();
            print(loction);
            if (loction != null && loction["latitude"] != null && loction["longitude"]!=null) {
                List data = response["data"]["list"];
                data.forEach((item) {
                    double distance = calculatedDistance(loction["latitude"], loction["longitude"], double.parse(item["latitude"]), double.parse(item["longitude"]));
                    item["distance"] = distance;
                });
            }
            final res = new FoodModel.fromJson(response);
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

    Widget _label (String name) {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(10),
                ScreenAdaper.height(3),
                ScreenAdaper.width(10),
                ScreenAdaper.height(3)
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
    Widget _listItem (String name, String type, int price, String city, String url, String distance, List coupons) {
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
                            width: ScreenAdaper.height(190),
                            height: ScreenAdaper.height(238),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                    url,
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
                                                    fontSize: ScreenAdaper.fontSize(30),
                                                    fontWeight: FontWeight.w600
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
                                                        child: Text("${distance}", style: TextStyle(
                                                            color: ColorClass.fontColor,
                                                            fontSize: ScreenAdaper.fontSize(24)
                                                        )
                                                    ),
                                                ))
                                            ]
                                        ),
                                        SizedBox(height: ScreenAdaper.height(20)),
                                        Text(city, style: TextStyle(
                                            color: ColorClass.fontColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ), overflow: TextOverflow.ellipsis),
                                        SizedBox(height: ScreenAdaper.height(15)),
                                        Text.rich(new TextSpan(
                                            style: TextStyle(
                                                color: Color(0xFFfb4135),
                                            ),
                                            children: <TextSpan>[
                                                TextSpan(text: "¥", style: TextStyle(
                                                    color: ColorClass.fontRed,
                                                    fontSize: ScreenAdaper.fontSize(26)
                                                )),
                                                TextSpan(text: price.toString(), style: TextStyle(
                                                    color: ColorClass.fontRed,
                                                    fontSize: ScreenAdaper.fontSize(44)
                                                )),
                                                TextSpan(text: "起", style: TextStyle(
                                                    color: ColorClass.subTitleColor,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                ))
                                            ]
                                        )),
                                        SizedBox(height: ScreenAdaper.height(25)),
                                        Wrap(
                                            spacing: ScreenAdaper.width(10),
                                            runSpacing: ScreenAdaper.height(10),
                                            children: (coupons.length > 2 ? coupons.take(2) : coupons).map((item) {
                                                return _label(item);
                                            }).toList()
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
                    preferredSize: Size.fromHeight(ScreenAdaper.height(88))
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
                            ListModel data = this.list[index];
                            List coupons = data.coupons != null ?  data.coupons.split(',') : [];
                            return GestureDetector(
                                onTap: () {
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                        return new AccommodationDetal(id: data.firmId);
                                    }));
                                },
                                child: this._listItem(
                                    data.name,
                                    data.tags,
                                    int.parse(data.perPrice),
                                    "${data.city}${data.county}${data.address}",
                                    data.logo,
                                    getDistanceText(data.distance),
                                    coupons
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
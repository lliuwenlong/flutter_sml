import 'package:flutter/material.dart';
import 'package:flutter_sml/common/CommonHandler.dart';
import 'package:flutter_sml/components/AppBarWidget.dart';
import 'package:flutter_sml/pages/Restaurant/RestaurantDetails.dart';
import '../../components/CommonListItem.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/restaurant/FoodModel.dart';
import '../../components/LoadingSm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class Entertainment extends StatefulWidget {
    Entertainment({Key key}) : super(key: key);
    _EntertainmentState createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
     HttpUtil http = HttpUtil();
    List list = [];
    bool isLoading = true;
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    int _page = 1;

    @override
    initState () {
        super.initState();
        this._getData(isInit: true);
    }

    _getData ({isInit: false}) async {
        Map response = await this.http.post("/api/v1/firm/havefun/", data: {
            "pageNO": _page,
            "pageSize": 10
        });
       
        if (response["code"] == 200) {
            var loction = await getLoction();
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
            } else {
                setState(() {
                    list.addAll(res.data.list);
                });
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

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar("神木娱乐"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(80))
            ),
            body: isLoading
                ? Container(
                    margin: EdgeInsets.only(
                        top: ScreenAdaper.height(200)
                    ),
                    child: Loading(),
                )
                : SmartRefresher(
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
                        itemCount: this.list.length,
                        itemBuilder: (BuildContext context, int index) {
                            ListModel data = this.list[index];
                            return GestureDetector(
                                onTap: () {
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                        return new RestaurantDetails(id: data.firmId, type: 4);
                                    }));
                                },
                                child:  CommonListItem(
                                    data.logo,
                                    data.name,
                                    data.mainGoods,
                                    "${data.city}${data.county}${data.address}",
                                    double.parse(data.perPrice),
                                    getDistanceText(data.distance)
                                )
                            );
                        },
                    )
                )
        );
    }
}

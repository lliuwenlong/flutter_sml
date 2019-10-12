import 'package:flutter/material.dart';
import '../../components/CommonListItem.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/restaurant/FoodModel.dart';
import '../../components/LoadingSm.dart';
import '../../components/AppBarWidget.dart';
import './RestaurantDetails.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Restaurant extends StatefulWidget {
    final Map arguments;
    Restaurant({Key key, this.arguments});
    _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
    HttpUtil http = HttpUtil();
    List<ListModel> list = [];
    bool isLoading = true;
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    int _page = 1;
    Map<int, String> nameMap = {
        1: "神木餐饮",
        2: "神木购物",
        3: "周边游",
    };

    Map<int, String> urlMap = {
        1: "/api/v1/firm/food/",
        2: "/api/v1/firm/shopping/",
        3: "/api/v1/firm/nearplay/",
    };
    @override
    initState () {
        super.initState();
        this._getData(isInit: true);
    }
    
    _getData ({isInit: false}) async {
        Map response = await this.http.post(this.urlMap[widget.arguments["type"]], data: {
            "pageNO": _page,
            "pageSize": 10
        });

        if (response["code"] == 200) {
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
        print(123);
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
        final selft = context;
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar(this.nameMap[widget.arguments["type"]]),
                preferredSize: Size.fromHeight(ScreenAdaper.height(80))
            ),
            body: isLoading
                ? Center(
                    child: Loading(isCenter: true),
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
                        physics: ClampingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                            ListModel data = this.list[index];
                            return GestureDetector(
                                onTap: () {
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                        return new RestaurantDetails(id: data.firmId, type: widget.arguments["type"]);
                                    }));
                                },
                                child: CommonListItem(
                                    data.logo,
                                    data.name,
                                    data.mainGoods != null ? data.mainGoods : "",
                                    "${data.city}${data.county}${data.address}",
                                    double.parse(data.perPrice),
                                    "<500",
                                )
                            );
                        },
                    )
                )
        );
    }
}

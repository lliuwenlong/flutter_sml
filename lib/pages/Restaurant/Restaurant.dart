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
    Restaurant({Key key}) : super(key: key);
    _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
    HttpUtil http = HttpUtil();
    List<ListModel> list = [];
    bool isLoading = true;
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    int _page = 1;

    @override
    initState () {
        super.initState();
        this._getData(isInit: true);
    }
    
    _getData ({isInit: false}) async {
        Map response = await this.http.post("/api/v1/firm/food/", data: {
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
                child: AppBarWidget().buildAppBar("神木餐饮"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(110))
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
                        physics: ClampingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                    // Navigator.pushNamed(context, '/restaurantDetails', arguments: {
                                    //     "id": "123"
                                    // });
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                        return new RestaurantDetails(params: this.list[index]);
                                    }));
                                },
                                child: CommonListItem(
                                    "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                    "边屯酒家",
                                    "海鲜自助餐",
                                    "贵州省黔西南布依族苗族自治州兴义市鲁",
                                    76,
                                    "<500"
                                )
                            );
                        },
                    )
                )
        );
    }
}

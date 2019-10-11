import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../Shop/Purchase.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/shop/ShopModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/LoadingSm.dart';
import '../../model/store/shop/Shop.dart';

class ShopPage extends StatefulWidget {
    ShopPage({Key key}) : super(key: key);
    _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
    RefreshController _refreshController = RefreshController(initialRefresh: false);
	BuildContext _selfContext;
    int _page = 1;
    bool isLoading = true;
    List<Data> shopList = [];
    @override
    initState() {
        super.initState();
        this._getData(isInit: true);
    }

    _getData ({bool isInit: false}) async {
        Map<String, dynamic> response = await HttpUtil().post(
            "/api/v1/wood/shop/",
            data: {
                "pageNO": _page,
                "pageSize": 10
            }
        );
        if (response["code"] == 200) {
            final ShopApiModel shopModel =  new ShopApiModel.fromJson(response);
            if (isInit) {
                setState(() {
                    shopList = shopModel.data;
                    isLoading = false;
                });
                return response;
            } else {
                setState(() {
                    shopList.addAll(shopModel.data);
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
        final Map res = await _getData(isInit: true);
        _refreshController.refreshCompleted();
        if (_refreshController.footerStatus == LoadStatus.noMore) {
            _refreshController.loadComplete();
        }
    }

    _purchase (Data val) {
        Provider.of<ShopModel>(context).setShopNum(1);
		showModalBottomSheet(
			context: this._selfContext,
			shape:  RoundedRectangleBorder(
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(ScreenAdaper.width(10)),
					topRight: Radius.circular(ScreenAdaper.width(10)),
				)
			),
			builder: (BuildContext context) {
				return Purchase(id: val.woodId, price: double.parse(val.price));
			}
		);
	}

    Widget _commodityItem (Data val) {
        return Container(
            width: (ScreenAdaper.getScreenWidth() - 40 ) / 2,
            padding: EdgeInsets.only(bottom: ScreenAdaper.height(10)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
                children: <Widget>[
                    Stack(
                        children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(context, "/shenmuDetails", arguments: {
                                        "id": val.woodId
                                    });
                                },
                                child: AspectRatio(
                                    aspectRatio: 335 / 400,
                                    child: Container(
                                        width: double.infinity,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                            child: Image.network(
                                              val.image,
                                                fit: BoxFit.fill,
                                            )
                                        ),
                                    )
                                )
                            ),
                            Positioned(
                                top: ScreenAdaper.width(20),
                                left: ScreenAdaper.width(20),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenAdaper.width(24),
                                        ScreenAdaper.height(16),
                                        ScreenAdaper.width(24),
                                        ScreenAdaper.height(16)
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text(val.name, style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenAdaper.fontSize(30)
                                    )),
                                ),
                            )
                        ],
                    ),
                    SizedBox(height: ScreenAdaper.height(20)),
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20), 0, ScreenAdaper.width(20), 0
                        ),
                        child: Row(
                            children: <Widget>[
                                Icon(
                                    IconData(0xe61d, fontFamily: 'iconfont'),
                                    color: Color(0xFF22b0a1),
                                    size: ScreenAdaper.fontSize(30)
                                ),
                                SizedBox(width: ScreenAdaper.width(20)),
                                Text(val.baseName, style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true),
                                    color: Color(0xFF666666)
                                ))
                            ],
                        )
                    ),
                    SizedBox(height: ScreenAdaper.height(0)),
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20), 0, ScreenAdaper.width(20), 0
                        ),
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("¥${val.price}", style: TextStyle(
                                        color: Color(0xFFfb4135),
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: MaterialButton(
                                            padding: EdgeInsets.all(0),
                                            height: ScreenAdaper.height(50),
                                            minWidth: ScreenAdaper.width(141),
                                            onPressed: () {
                                              this._purchase(val);
                                            },
                                            color: Color(0xFF22b0a1),
                                            splashColor: Color.fromRGBO(0, 0, 0, 0),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(ScreenAdaper.width(10)))
                                            ),
                                            child: Text("立即购买", style: TextStyle(
                                                fontSize: ScreenAdaper.fontSize(24),
                                                color: Color(0xFFffffff)
                                            )),
                                        ),
                                    ),
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
		this._selfContext = context;
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar("商城"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(110))
            ),
            body:  this.isLoading
                ? Container(
                    margin: EdgeInsets.only(
                        top: ScreenAdaper.height(200)
                    ),
                    child: Loading()
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
                child: ListView(
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(15),
                            child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: this.shopList.map((Data val) {
                                    return this._commodityItem(val);
                                }).toList(),
                            )
                        )
                    ]
                )
            )
        );
    }
}
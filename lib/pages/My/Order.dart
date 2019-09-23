import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/store/user/User.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/order/OrderData.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
class Order extends StatefulWidget {
    Order({Key key}) : super(key: key);
    _OrderState createState() => _OrderState();
}
class _OrderState extends State<Order> with SingleTickerProviderStateMixin{
    final List<Map> _tabList = [
        {"id": 1, "name": "全部"},
        {"id": 2, "name": "待付款"},
        {"id": 3, "name": "待使用"},
        {"id": 4, "name": "待评价"},
        {"id": 5, "name": "退款"},
		    {"id": 6, "name": "已完成"}
    ];
    
    TabController _tabController;
    void initState () {
        super.initState();
        _tabController = new TabController(
            vsync: this,
            length: 6
        );
    }
    User _userModel;

    RefreshController  allController = new RefreshController(initialRefresh: false);
    RefreshController  paymentController = new RefreshController(initialRefresh: false);
    RefreshController  toBeUsedController = new RefreshController(initialRefresh: false);
    RefreshController  toBeEvaluatedController = new RefreshController(initialRefresh: false);
    RefreshController  refundController = new RefreshController(initialRefresh: false);
    RefreshController  finishedController = new RefreshController(initialRefresh: false);

    bool allLoading = true;
    bool paymentLoading = true;
    bool toBeUsedLoading = true;
    bool toBeEvaluatedLoading = true;
    bool refundLoading = true;
	bool finishedLoading = true;
	bool loading = true;
    int allPage = 1;
    int paymentPage = 1;
    int toBeUsedPage = 1;
    int toBeEvaluatedPage = 1;
    int refundPage = 1;
	int finishedPage = 1;
	int page = 1;

    List allList = [];
    List paymentList = [];
    List toBeUsedList = [];
    List toBeEvaluatedList = [];
    List refundList = [];
	List finishedList = [];

	String status = '0'; 
	// 0-全部
	// 1-待付款
	// 2-待使用
	// 3-待评价
	// 4-退款
	// 9-已完成
    void _onLoading () async {
        setState(() {
            if ( _tabController.index == 0 ) {
                this.allPage++;
				this.page = this.allPage;
            } else if( _tabController.index == 1 ) {
                this.paymentPage++;
				this.page = this.paymentPage;
            } else if( _tabController.index == 2 ) {
                this.toBeUsedPage++;
				this.page = this.toBeUsedPage;
            } else if ( _tabController.index == 3 ) {
                this.toBeEvaluatedPage++;
				this.page = this.toBeEvaluatedPage;
            } else if (_tabController.index == 4) {
                this.refundPage++;
				this.page = this.refundPage;
            }else {
				this.finishedPage++;
				this.page = this.finishedPage;
			}
        });
        var controller;
        if ( _tabController.index == 0 ) {
            controller = this.allController;
        } else if( _tabController.index == 1 ) {
            controller = this.paymentController;
        } else if( _tabController.index == 2 ) {
            controller = this.toBeUsedController;
        } else if ( _tabController.index == 3 ) {
            controller = this.toBeEvaluatedController;
        } else if ( _tabController.index == 4 ) {
            controller = this.refundController;
        }else {
			controller = this.finishedController;
		}
        var response = await _getData();
        if (response["data"].length == 0) {
            controller.loadNoData();
        } else {
            controller.loadComplete();
        }
    }
    
    void _onRefresh() async{
        setState(() {
            if ( _tabController.index == 0 ) {
                this.allPage = 1;
				this.page = this.allPage;
            } else if( _tabController.index == 1 ) {
                this.paymentPage = 1;
				this.page = this.paymentPage;
            } else if( _tabController.index == 2 ) {
                this.toBeUsedPage = 1;
				this.page = this.toBeUsedPage;
            } else if ( _tabController.index == 3 ) {
                this.toBeEvaluatedPage = 1;
				this.page = this.toBeEvaluatedPage;
            } else if ( _tabController.index == 4 ) {
                this.refundPage = 1;
				this.page = this.refundPage;
            } else {
				 this.finishedPage = 1;
				this.page = this.finishedPage;
			}
        });
        var controller;
        if ( _tabController.index == 0 ) {
            controller = this.allController;
        } else if( _tabController.index == 1 ) {
            controller = this.paymentController;
        } else if( _tabController.index == 2 ) {
            controller = this.toBeUsedController;
        } else if ( _tabController.index == 3 ) {
            controller = this.toBeEvaluatedController;
        } else if ( _tabController.index == 4 ) {
            controller = this.refundController;
        } else {
			controller = this.finishedController;
		}
        final Map res = await _getData(isInit: true);
        controller.refreshCompleted();
      }
	
	final HttpUtil http = HttpUtil();
	@override
	void didChangeDependencies() {
	  super.didChangeDependencies();
	  _userModel = Provider.of<User>(context);

	  _getData(isInit: true);
	}

	_getData ({bool isInit = false}) async {

		if (
            isInit
            && ((this._tabController.index == 0 && this.allLoading == false)
            || (this._tabController.index == 1 && this.paymentLoading == false)
			|| (this._tabController.index == 2 && this.toBeUsedLoading == false)
			|| (this._tabController.index == 3 && this.toBeEvaluatedLoading == false)
			|| (this._tabController.index == 4 && this.refundLoading == false)
			|| (this._tabController.index == 5 && this.finishedLoading == false)
			)
        ) {
            return null;
        }
		Map response = await this.http.get('/api/v1/order/data', data: {
			"pageNO": this.page,
			"pageSize": 10,
			"status": _tabController.index == 5? 9 : _tabController.index,
			"userId": this._userModel.userId
		});

		if (response['code'] == 200) {
			OrderDataModel res = OrderDataModel.fromJson(response);
			if (isInit) {
                setState(() {
                    switch (_tabController.index) {
                      case 0 : {
                        allList = res.data.list;
                        allLoading = false;
                        this.loading = allLoading;
                      } break;
                      case 1 : {
                        paymentList = res.data.list;
                        paymentLoading = false;
                        this.loading = paymentLoading;
                      } break;
                      case 2 : {
                        toBeUsedList = res.data.list;
                        toBeUsedLoading = false;
                        this.loading = toBeUsedLoading;
                      } break;
                      case 3 : {
                        toBeEvaluatedList = res.data.list;
                        toBeEvaluatedLoading = false;
                        this.loading = toBeEvaluatedLoading;
                      } break;
                      case 4 : {
                        refundList = res.data.list;
                        refundLoading = false;
                        this.loading = refundLoading;
                      } break;
                      case 5 : {
                        finishedList = res.data.list;
                        finishedLoading = false;
                        this.loading = finishedLoading;
                      } break;
                    }
                });
            } else {
                setState(() {
                     if (_tabController.index == 0) {
                        allList.addAll(res.data.list);
                    } else if (_tabController.index == 1) {
						paymentList.addAll(res.data.list);
					}else if (_tabController.index == 2){
                        toBeUsedList.addAll(res.data.list);
                    } else if (_tabController.index == 3) {
						toBeEvaluatedList.addAll(res.data.list);
					} else if (_tabController.index == 4) {
						refundList.addAll(res.data.list);
					} else {
						finishedList.addAll(res.data.list);
					}
                });
            }
		}
		return response;
	}
    Widget _itemWidget ({var data}) {
		String status;
		switch (data.status) {
			case '1':  status = '去付款'; break;
			case '2':  status = '去使用'; break;
			case '3':  status = '去评价'; break;
			case '9':  status = '去评价'; break;
		}
        	return GestureDetector(
				onTap: (){
					print(data.status);
					if(data.status == '9'){
						print('object');
						Navigator.pushNamed(context, '/cancellationOrder', arguments: {
							'orderSn': data.orderSn
						});
					}
				},
				child:Container(
					margin: EdgeInsets.only(
						top: ScreenAdaper.height(20)
					),
					padding: EdgeInsets.all(ScreenAdaper.width(30)),
					color: Colors.white,
					child: Column(
                	children: <Widget>[
                    Row(
                        children: <Widget>[
                            Icon(
                                IconData(0xe659, fontFamily: "iconfont"),
                                color: Colors.red,
                                size: ScreenAdaper.fontSize(30),
                            ),
                            SizedBox(width: ScreenAdaper.width(20)),
                            Text(data.name, style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(30)
                            )),
                            Expanded(
                                flex: 1,
                                child: Text(data.statusName,  style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                ), textAlign: TextAlign.end),
                            )
                        ]
                    ),
                    SizedBox(height: ScreenAdaper.height(30)),
                    Row(
                        children: <Widget>[
                            Container(
                                width: ScreenAdaper.width(120),
                                height: ScreenAdaper.width(120),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    child: Image.network(
										data.logo,
                                        fit: BoxFit.cover,
                                    )
                                ),
                            ),
                            SizedBox(
                                width: ScreenAdaper.width(20),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text("下单时间：${data.createTime}", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    )),
                                    SizedBox(height: ScreenAdaper.height(5)),
                                    Text("总价：¥${data.amount}", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    ))
                                ]
                            )
                        ]
                    ),
                    status!=null?Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: ScreenAdaper.width(160),
                            height: ScreenAdaper.width(60),
                            child: OutlineButton(
                                borderSide: BorderSide(
                                    color: Color(0XFF999999),
                                    width: ScreenAdaper.width(1)
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                                ),
                                highlightedBorderColor: Color(0XFF999999),
                                onPressed: () {
                                    Navigator.pushNamed(context, "/acknowledgement");
                                },
                                child:Text(status, style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                )),
                            )
                        )
                    ):Text('')
                ]
            	),
				),
        	);
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("我的订单", style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenAdaper.fontSize(32)
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
                    isScrollable: true,
                    unselectedLabelColor: ColorClass.fontColor,
                    unselectedLabelStyle: TextStyle(
                        fontSize: ScreenAdaper.fontSize(30),
                        fontWeight: FontWeight.w500
                    ),
                    labelColor: ColorClass.titleColor,
                    labelStyle: TextStyle(
                        fontSize: ScreenAdaper.fontSize(30),
                        fontWeight: FontWeight.w600
                    ),
                    tabs: this._tabList.map((val) {
                        return Tab(child: Text(
                            val['name']
                        ));
                    }).toList(),
					onTap: (int index) {
                        this._getData(isInit: true);
                    }
                ),
            ),
            body: TabBarView(
                controller: this._tabController,
                children: <Widget>[
                    SmartRefresher(
                        controller: allController,
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
                        child: this.loading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.allList.length <= 0 ? NullContent('暂无数据'):
                             ListView.builder(
                                itemCount: this.allList.length,
                                itemBuilder: (BuildContext context, int index) {
                                    var data = this.allList[index];
                                    return this._itemWidget(data:data);
                                }
                            )
                    ),
                    SmartRefresher(
                        controller: paymentController,
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
                        child: this.loading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.paymentList.length <= 0 ? NullContent('暂无数据'):
                             ListView.builder(
                                itemCount: this.paymentList.length,
                                itemBuilder: (BuildContext context, int index) {
                                    var data = this.paymentList[index];
                                    return this._itemWidget(data:data);
                                }
                            )
                    ),
					SmartRefresher(
                        controller: toBeUsedController,
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
                        child: this.loading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.toBeUsedList.length <= 0 ? NullContent('暂无数据'):
                             ListView.builder(
                                itemCount: this.toBeUsedList.length,
                                itemBuilder: (BuildContext context, int index) {
                                    var data = this.toBeUsedList[index];
                                    return this._itemWidget(data:data);
                                }
                            )
                    ),
					SmartRefresher(
                        controller: toBeEvaluatedController,
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
                        child: this.loading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.toBeEvaluatedList.length <= 0 ? NullContent('暂无数据'):
                             ListView.builder(
                                itemCount: this.toBeEvaluatedList.length,
                                itemBuilder: (BuildContext context, int index) {
                                    var data = this.toBeEvaluatedList[index];
                                    return this._itemWidget(data:data);
                                }
                            )
                    ),
					SmartRefresher(
                        controller: refundController,
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
                        child: this.loading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.refundList.length <= 0 ? NullContent('暂无数据'):
                             ListView.builder(
                                itemCount: this.refundList.length,
                                itemBuilder: (BuildContext context, int index) {
                                    var data = this.refundList[index];
                                    return this._itemWidget(data:data);
                                }
                            )
                    ),
					SmartRefresher(
                        controller: finishedController,
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
                        child: this.loading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.finishedList.length <= 0 ? NullContent('暂无数据'):
                             ListView.builder(
                                itemCount: this.finishedList.length,
                                itemBuilder: (BuildContext context, int index) {
                                    var data = this.finishedList[index];
                                    return this._itemWidget(data:data);
                                }
                            )
                    )
                ]
            )
        );
    }
}
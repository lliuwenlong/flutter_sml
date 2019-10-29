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
        {"id": 6, "name": "已完成"},
        {"id": 2, "name": "待付款"},
        {"id": 3, "name": "待使用"},
        {"id": 4, "name": "待评价"},
        {"id": 5, "name": "退款"},
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
    Map<String, int> orderType = {
        "0": 0,
        "1": 9,
        "2": 1,
        "3": 2,
        "4": 3,
        "5": 4
    };
    Map<String, Icon> typeIcon = {
        "tree": Icon(
            IconData(0xe661, fontFamily: "iconfont"),
            color: Color(0xff22b0a1),
            size: ScreenAdaper.fontSize(30),
        ),
        "house": Icon(
            IconData(0xe662, fontFamily: "iconfont"),
            color: Color(0xffc1a786),
            size: ScreenAdaper.fontSize(30),
        ),
        "havefun": Icon(
            IconData(0xe665, fontFamily: "iconfont"),
            color: Color(0xffe99470),
            size: ScreenAdaper.fontSize(30),
        ),
        "food": Icon(//餐饮
            IconData(0xe664, fontFamily: "iconfont"),
            color: Color(0xfff6cf70),
            size: ScreenAdaper.fontSize(30),
        ),
        "shopping": Icon(//购物
            IconData(0xe660, fontFamily: "iconfont"),
            color: Color(0xffd4746c),
            size: ScreenAdaper.fontSize(30),
        ),
        "nearplay": Icon(//周边游
            IconData(0xe663, fontFamily: "iconfont"),
            color: Color(0xff91c2a2),
            size: ScreenAdaper.fontSize(30),
        ),
        "valuepro": Icon(//周边游
            IconData(0xe66c, fontFamily: "iconfont"),
            color: Color(0xFF7dc26b),
            size: ScreenAdaper.fontSize(30),
        )
    };

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
        if (response["data"]['list'].length == 0) {
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
            || (this._tabController.index == 2 && this.paymentLoading == false)
			|| (this._tabController.index == 3 && this.toBeUsedLoading == false)
			|| (this._tabController.index == 4 && this.toBeEvaluatedLoading == false)
			|| (this._tabController.index == 5 && this.refundLoading == false)
			|| (this._tabController.index == 6 && this.finishedLoading == false)
			)
        ) {
            return null;
        }
         
		Map response = await this.http.get('/api/v1/order/data', data: {
			"pageNO": this.page,
			"pageSize": 10,
			"status": orderType[_tabController.index.toString()],
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
					refundList = res.data.list;
					refundLoading = false;
					this.loading = refundLoading;
				} break;
                case 2 : {
					finishedList = res.data.list;
					finishedLoading = false;
					this.loading = finishedLoading;
				} break;
				case 3 : {
					paymentList = res.data.list;
					paymentLoading = false;
					this.loading = paymentLoading;
				} break;
				case 4 : {
					toBeUsedList = res.data.list;
					toBeUsedLoading = false;
					this.loading = toBeUsedLoading;
				} break;
				case 5 : {
					toBeEvaluatedList = res.data.list;
					toBeEvaluatedLoading = false;
					this.loading = toBeEvaluatedLoading;
				} break;
				
				}
			});
      	} else {
			setState(() {
				if (_tabController.index == 0) {
					allList.addAll(res.data.list);
				} else if (_tabController.index == 2) {
					paymentList.addAll(res.data.list);
				}else if (_tabController.index == 3){
					toBeUsedList.addAll(res.data.list);
				} else if (_tabController.index == 4) {
					toBeEvaluatedList.addAll(res.data.list);
				} else if (_tabController.index == 5) {
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
      
      return GestureDetector(
				onTap: (){
          if(data.status == '1'){//去付款
            if (data.type == 'house') {
               Navigator.pushNamed(context, '/acknowledgement',arguments: {
                'orderSn':data.orderSn,
                'type':data.type,
                'firmId':data.firmId
              });
            }else{
             
                Navigator.pushNamed(context, '/payment',arguments: {
                  'amount':data.amount,
                  'orderSn':data.orderSn,
                  'firmId':data.firmId
                });
            }
             
          }else{
              Navigator.pushNamed(context, '/cancellationOrder',arguments: {//取消订单
                  'orderSn':data.orderSn,
                  'status':data.status,
                  'type':data.type

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
                            typeIcon[data.type] != null ? typeIcon[data.type] : Text(''),
                            SizedBox(width: ScreenAdaper.width(20)),
                            Text(data.name!=null?data.name:'', style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(30)
                            )),
                            Expanded(
                                flex: 1,
                                child: Text(data.statusName!=null?data.statusName:'',  style: TextStyle(
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
										data.logo!=null?data.logo:'',
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
                                    Text("下单时间：${data.createTime!=null?data.createTime:''}", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    )),
                                    SizedBox(height: ScreenAdaper.height(5)),
                                    Text("总价：${data.amount!=null?data.amount:''}", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    ))
                                ]
                            )
                        ]
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: 
                        data.status!='4'&&data.status!='5'&&data.status!='6'&&data.status!='9'?Container(
                            width: ScreenAdaper.width(180),
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
                                  if(data.type=='house'&&data.status=='1'){//去付款
                                      Navigator.pushNamed(context, "/acknowledgement",arguments: {
                                       'orderSn':data.orderSn,
                                       'type':data.type,
                                       'firmId':data.firmId
                                     });
                                  }else if (data.type=='havefun'&&data.status=='1'){
                                      Navigator.pushNamed(context, '/payment',arguments: {
                                        'amount':data.amount,
                                        'orderSn':data.orderSn,
                                        'type':data.type,
                                        'firmId':data.firmId
                                      });
                                  }else if ((data.type=='house'||data.type=='havefun')&&data.status == '2'){//取消订单
                                      Navigator.pushNamed(context, "/cancellationOrder",arguments: {
                                        'orderSn':data.orderSn,
                                        'type':data.type,
                                        'status':data.status
                                      });
                                  }else if (data.type =='tree' && data.status == '8') {
                                      Navigator.pushNamed(context, "/cancellationOrder",arguments: {
                                        'orderSn':data.orderSn,
                                        'type':data.type,
                                        'status':data.status
                                      });
                                  }else if (data.status == '3') {//去评价
                                        Navigator.pushNamed(context, "/releaseEvaluate", arguments: {
                                            "firmId": data.firmId,
                                            "name": data.name,
                                            "logo": data.logo
                                        });
                                  }
                                },
                                child:
                                (data.type=='house'||data.type=='havefun')&&data.status == '1'?
                                Text('去付款', style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                )):
                                ((data.type=='house'||data.type=='havefun')&&data.status == '2')||(data.type=='tree'&&data.status=='8')?
                                 Text('取消订单', style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                )):
                                data.status == '3'?
                                 Text('去评价', style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                )):
                                Text(''),
                            )
                        ):Text('')
                    )
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
					          onTap: (int index){
                      setState(() {
                        this._tabController.index = index;
                      });
                      this._getData(isInit: true);
                    },
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
                    )
                ]
            )
        );
    }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Label.dart';
import '../../common/Color.dart';
import '../../model/store/user/User.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model//api/my/ProductData.dart';
import '../../components/NullContent.dart';
import 'package:url_launcher/url_launcher.dart';

class Product extends StatefulWidget {
  final Map arguments;
    Product({Key key,this.arguments}) : super(key: key);

    _ProductState createState() => _ProductState(arguments:this.arguments);
}

class _ProductState extends State<Product> with SingleTickerProviderStateMixin{
  final Map arguments;
  User _userModel;
  final HttpUtil http = HttpUtil();
  TabController _tabController;
  RefreshController _transferRefreshController = new RefreshController(initialRefresh: false);
  RefreshController _subscrieRefreshController = new RefreshController(initialRefresh: false);
  bool isTransferLoading = true;
  bool isSubscrieLoading = true;
  int transferPage = 1;
  int subscriePage = 1;
  List transferList = [];
  List subscrieList = [];
  _ProductState({this.arguments});
  
   void initState () {
        super.initState();
        _tabController = new TabController(
            vsync: this,
            length: 2,
        );
    }
void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        setState(() {
          this._tabController.index = arguments!=null&&arguments['index']==1?arguments['index']:0;
        });
        this._getData(isInit: true);
    }
  _getData ({bool isInit = false}) async {
    if (isInit&& 
        ((this._tabController.index == 0 && this.isSubscrieLoading == false)
        || (this._tabController.index == 1 && this.isTransferLoading == false))
    ) {
        return null;
    }  
   
    final Map<String, dynamic> response = await this.http.post("/api/v1/user/wood", data: {
        "pageNO": this._tabController.index == 0 ? subscriePage : transferPage,
        "pageSize": 10,
        "userId": this._userModel.userId,
        "type": this._tabController.index == 0 ? 1 : 0
    });
    if (response["code"] == 200) {
            final res = new ProductDataModel.fromJson(response);
            if (isInit) {
                setState(() {
                    if (_tabController.index == 0) {
                        subscrieList = res.data.list;
                        isSubscrieLoading = false;
                    } else {
                        transferList = res.data.list;
                        isTransferLoading = false;
                    }
                    
                });
            } else {
                setState(() {
                    if (_tabController.index == 0) {
                        subscrieList.addAll(res.data.list);
                    } else {
                        transferList.addAll(res.data.list);
                    }
                });
            }
        }
        return response;
    }


void _onLoading() async{
        setState(() {
            if (_tabController.index == 0) {
                this.subscriePage++;
            } else {
                this.transferPage++;
            }
        });
        var controller = _tabController.index == 0
            ? this._subscrieRefreshController
            : this._transferRefreshController;
        var response = await _getData();
        if (response["data"]["list"].length == 0) {
            controller.loadNoData();
        } else {
            controller.loadComplete();
        }
    }
void _onRefresh() async{
        setState(() {
            if (_tabController.index == 0) {
                this.subscriePage = 1;
            } else {
                this.transferPage = 1;
            }
        });
        var controller = _tabController.index == 0
            ? this._subscrieRefreshController
            : this._transferRefreshController;
        final Map res = await _getData(isInit: true);
        controller.refreshCompleted();
        if (controller.footerStatus == LoadStatus.noMore) {
            controller.loadComplete();
        }
    }
 _launchMap() async {
        if (Platform.isAndroid) {
            final url = 'androidamap://myLocation?sourceApplication=softname';
            if (await canLaunch(url)) {
                await launch(url);
            } else {
                throw 'Could not launch $url';
            }
        } else {
            final url = '//myLocation?sourceApplication=applicationName';
            if (await canLaunch(url)) {
                await launch(url);
            } else {
                throw 'Could not launch $url';
            }
        }
        
    }
    
   
    Widget _item ({bool isTransfer = true, var data}) {
        return GestureDetector(
          onTap: (){
            if(this._tabController.index == 1 || !isTransfer){
              return;
            }
            Navigator.pushNamed(context, '/productDetail',arguments: {
              "woodSn": data.woodSn,
              'woodId': data.woodId
            });
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
                Container(
                    width: ScreenAdaper.width(335),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                        color: Colors.white
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Stack(
                                children: <Widget>[
                                    AspectRatio(
                                        aspectRatio: 336 / 420,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(ScreenAdaper.width(10)),
                                                topRight: Radius.circular(ScreenAdaper.width(10))
                                            ),
                                            child: Image.network(
                                                data.image,
                                                fit: BoxFit.cover,
                                            ),
                                        ),
                                    ),
                                    Positioned(
                                        top: ScreenAdaper.width(20),
                                        left: ScreenAdaper.width(20),
                                        child: Label(data.name),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                            width: double.infinity,
                                            height: ScreenAdaper.height(70),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("images/bg-option.png"),
                                                    fit: BoxFit.fill
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(ScreenAdaper.width(10)),
                                                    bottomRight: Radius.circular(ScreenAdaper.width(10))
                                                )
                                            ),
                                        ),
                                    )
                                ],
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenAdaper.width(20),
                                    ScreenAdaper.width(20),
                                    ScreenAdaper.width(20),
                                    ScreenAdaper.width(30),
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Row(
                                            children: <Widget>[
                                                Container(
                                                  child: GestureDetector(
                                                    onTap: _launchMap,
                                                    child: Icon(
                                                        IconData(0xe61d, fontFamily: 'iconfont'), color: Color(0xFF22b0a1),
                                                        size: ScreenAdaper.fontSize(30),
                                                      ),
                                                  ),
                                                  width: ScreenAdaper.width(30),
                                                  height: ScreenAdaper.height(30),
                                                ),
                                                SizedBox(width: ScreenAdaper.width(20)),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                        data.baseName,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: ColorClass.fontColor,
                                                            fontSize: ScreenAdaper.fontSize(24)
                                                        )
                                                    ),
                                                )
                                            ]
                                        ),
                                        SizedBox(height: ScreenAdaper.height(15)),
                                        Text("编号：${data.woodSn}", style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        )),
                                        SizedBox(height: ScreenAdaper.height(10)),
                                        Text("有效期：${data.hasDays}天", style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ))
                                    ],
                                    
                                )
                            )
                        ]
                    )
                ),
                Positioned(
                    top: 0,
                    bottom: 0,
                    width: ScreenAdaper.width(335),
                    child: Offstage(
                        offstage: isTransfer,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.7
                                )
                            )
                        )
                    ),
                ),
                Offstage(
                    offstage: isTransfer,
                    child: Container(
                        width: ScreenAdaper.width(217),
                        height: ScreenAdaper.height(160),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/itransfer.png"),
                                fit: BoxFit.fitWidth
                            )
                        ),
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(124)
                        ),
                    ),
                )
            ]
        ),
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("我的神木", style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenAdaper.fontSize(32)
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light,
                actions: [
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/purchaseRecord");
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: ScreenAdaper.width(30)),
                            alignment: Alignment.center,
                            child: Text("购买记录", style: TextStyle(
                                color: ColorClass.fontColor,
                                fontSize: ScreenAdaper.fontSize(32)
                            ), textAlign: TextAlign.center)
                        )
                    )
                ],
                bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: ScreenAdaper.height(6),
                    indicatorColor: Color(0XFF22b0a1),
                    controller: this._tabController,
                    onTap: (int index){
                      setState(() {
                        this._tabController.index = index;
                      });
                      this._getData(isInit: true);
                    },
                    tabs: <Widget>[
                        Tab(child: Text("认购中", style: TextStyle(
                            color: Colors.black, fontSize: ScreenAdaper.fontSize(34)
                        ))),
                        Tab(child: Text("已转让", style: TextStyle(
                            color: Color(0XFF666666),
                            fontSize: ScreenAdaper.fontSize(34)
                        )))
                    ]
                ),
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20),
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20)
                ),
                child: TabBarView(
                    controller: this._tabController,
                    children: <Widget>[
                       
                        SmartRefresher(
                        controller: _subscrieRefreshController,
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
                        child: this.isSubscrieLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ):
                            this.subscrieList.length<=0?
                            NullContent('暂无数据'):
                            ListView(
                                children: <Widget>[
                                    Wrap(
                                        spacing: ScreenAdaper.width(10),
                                        runSpacing: ScreenAdaper.width(10),
                                        children: this.subscrieList.map((val){
                                            return this._item(data:val);
                                        }).toList(),
                                    )
                                ],
                            )
                    ),

                    SmartRefresher(
                        controller: _transferRefreshController,
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
                        child: this.isTransferLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : this.transferList.length<=0? NullContent('暂无数据'):
                            ListView(
                                children: <Widget>[
                                    Wrap(
                                        spacing: ScreenAdaper.width(10),
                                        runSpacing:ScreenAdaper.width(10) ,
                                        children:this.transferList.map((val){
                                            return this._item(isTransfer: false,data:val);
                                        }).toList(),
                                    )
                                ],
                            )
                            ,
                    ),
                        
                    ]
                )
            )
        );
    }
}
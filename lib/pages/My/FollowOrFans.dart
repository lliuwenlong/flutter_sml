import 'package:flutter/material.dart';
import 'package:flutter_sml/components/MyUnderlineIndicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
import '../../common/HttpUtil.dart';

import '../../model/store/user/User.dart';
import '../../model/api/friendDynamics/FriendListApiModel.dart';

class FollowOrFans extends StatefulWidget {
    final Map arguments;
    FollowOrFans({Key key, this.arguments}) : super(key: key);
    _FollowOrFansState createState() =>
    _FollowOrFansState(arguments: this.arguments);
}

class _FollowOrFansState extends State<FollowOrFans> with SingleTickerProviderStateMixin {
    final List<Map> _tabList = [
        {"id": 1, "name": "我的关注"},
        {"id": 2, "name": "我的粉丝"},
    ];

    final Map arguments;
    final HttpUtil http = HttpUtil();
    final RefreshController _userFocusController= RefreshController(initialRefresh: false);
    final RefreshController _userFansController= RefreshController(initialRefresh: false);

    int _currentIndex;
    _FollowOrFansState({this.arguments});
    TabController _tabController;
    User _userModel;
    List<FriendDataListModel> _userFansList = [];
    int _userFansPage = 1;
    bool _userFansLoading = true;

    List<FriendDataListModel> _userFocusList = [];
    int _userFocusPage = 1;
    bool _userFocusLoading = true;

    @override
    void initState() {
        super.initState();
        _currentIndex =  this.arguments.isNotEmpty ? this.arguments['index'] : 0;
        _tabController = new TabController(vsync: this, length: 2, initialIndex: _currentIndex);
        _tabController.addListener(() {
            this._getData(isInit: true);
        });
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        this._getData(isInit: true);
    }

    _subscribe (int userId, int index) async {
        Map response = await this.http.post("/api/v1/circle/subscribe", data: {
            "fanId": this._userModel.userId,
            "userId": userId
        });
        if (response["code"] != 200) {
            Fluttertoast.showToast(
                msg: response["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                textColor: Colors.white,
                backgroundColor: Colors.black87,
                fontSize: ScreenAdaper.fontSize(30)
            );
        } else {
            setState(() {
                this._userFansList[index].focus = "1";
            });
        }
    }

    
    _unsubscribe (int userId, int index) async {
        Map response = await this.http.post("/api/v1/circle/unsubscribe", data: {
            "userId": this._userModel.userId,
            "focusId": userId
        });
        if (response["code"] != 200) {
            Fluttertoast.showToast(
                msg: response["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                textColor: Colors.white,
                backgroundColor: Colors.black87,
                fontSize: ScreenAdaper.fontSize(30)
            );
        } else {
            this.setState(() {
                this._userFocusList.removeAt(index);
            });
        }
    }

    _getData ({isInit = false}) async {
        Map response;
        if (_tabController.index == 1) {
            response = await this.http.get("/api/v1/circle/user/fans", data: {
                "pageNO": this._userFansPage,
                "pageSize": 20,
                "userId": this._userModel.userId
            });
        } else {
            response = await this.http.get("/api/v1/circle/user/foucs", data: {
                "pageNO": this._userFocusPage,
                "pageSize": 20,
                "userId": this._userModel.userId
            });
        }

        if (response["code"] == 200) {
            FriendListApiModel res = new FriendListApiModel.fromJson(response);
            if (isInit) {
                setState(() {
                    if (_tabController.index == 0) {
                        this._userFocusList = res.data.list;
                        this._userFocusLoading = false;
                    } else {
                        this._userFansList = res.data.list;
                        this._userFansLoading = false;
                    }
                });
            } else {
                setState(() {
                    if (_tabController.index == 0) {
                        this._userFocusList.addAll(res.data.list);
                    } else {
                        this._userFansList.addAll(res.data.list);
                    }
                });
            }
        }
        return response;
    }

    void _onLoading() async{
        setState(() {
            if (_tabController.index == 0) {
                this._userFocusPage++;
            } else {
                this._userFansPage++;
            }
        });
        var controller = _tabController.index == 0
            ? this._userFocusController
            : this._userFansController;

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
                this._userFocusPage = 1;
            } else {
                this._userFansPage = 1;
            }
        });
        var controller = _tabController.index == 0
            ? this._userFocusController
            : this._userFansController;
        await _getData(isInit: true);
        controller.refreshCompleted();
        if (controller.footerStatus == LoadStatus.noMore) {
            controller.loadComplete();
        }
    }

    Widget _listItem(String imageUrl, String nickName, String text, int index, Function onTap, {String focus = "0"}){
        return  Container(
            padding: EdgeInsets.only(
                top: index == 0 ? ScreenAdaper.height(20) : 0,
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            height: ScreenAdaper.height(126),
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Row(
                        children: <Widget>[
                            CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: ScreenAdaper.height(43),
                                    backgroundImage: NetworkImage(imageUrl),
                                ),
                                SizedBox(width: ScreenAdaper.width(30)),
                                Text(
                                nickName,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: ScreenAdaper.fontSize(34)
                                ),
                            )
                        ],
                    ),
                    GestureDetector(
                        onTap: onTap,
                        child: Container(
                            width: ScreenAdaper.width(160),
                            height: ScreenAdaper.height(60),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff22b0a1),
                                width: ScreenAdaper.width(2)
                            ),
                            borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                            ),
                            child: Text(
                            text,
                            style: TextStyle(
                                color: Color(0xff22b0a1),
                                fontSize: ScreenAdaper.fontSize(30)
                            ),
                            ),
                        ),
                    )
                ]
            )
        );
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
            elevation: 1,
            iconTheme:IconThemeData(color: Colors.black),
            title: Container(
                height: double.infinity,
                alignment: Alignment.bottomLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: TabBar(
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorWeight: ScreenAdaper.height(6),
                                indicatorColor: Color(0XFF22b0a1),
                                controller: this._tabController,
                                unselectedLabelColor: ColorClass.fontColor,
                                unselectedLabelStyle: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(30),
                                    fontWeight: FontWeight.w500),
                                labelColor: ColorClass.titleColor,
                                labelStyle: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(34),
                                    fontWeight: FontWeight.w600),
                                tabs: this._tabList.map((val) {
                                    return Tab(child: Text(val['name']));
                                }).toList()
                            ),
                        )
                    ],
                )
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            ),
            body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                    this._userFocusLoading
                        ? Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(200)
                            ),
                            child: Loading(),
                        )
                        : this._userFocusList.isEmpty
                            ? NullContent("暂无数据")
                            : Container(
                                color: Colors.white,
                                child: SmartRefresher(
                                controller: this._userFocusController,
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
                                            FriendDataListModel data = this._userFocusList[index];
                                            return this._listItem(
                                                data.headerImage,
                                                data.nickName,
                                                '取消关注',
                                                index,
                                                () {
                                                    this._unsubscribe(data.subId, index);
                                                }
                                            );
                                        },
                                        itemCount: this._userFocusList.length,
                                    )
                                )
                            ),
                    this._userFansLoading
                        ? Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(200)
                            ),
                            child: Loading(),
                        )
                        : this._userFansList.isEmpty
                            ? NullContent("暂无数据")
                            : Container(
                                color: Colors.white,
                                child: SmartRefresher(
                                controller: this._userFansController,
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
                                        FriendDataListModel data = this._userFansList[index];
                                        return this._listItem(
                                            data.headerImage,
                                            data.nickName,
                                            data.focus =='0'?'关注':'已关注',
                                            index,
                                           	data.focus =='0'? () {
                                                this._subscribe(data.subId, index);
                                            }:() {},
                                            focus: data.focus
                                        );
                                    },
                                    itemCount: this._userFansList.length,
                                )
                            )
                        )
                ],
            )
        );
    }
}

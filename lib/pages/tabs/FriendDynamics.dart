import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sml/components/AppBarWidget.dart';
import 'package:flutter_sml/components/MyUnderlineIndicator.dart';
import 'package:flutter_sml/components/NullContent.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluwx/fluwx.dart' as fluwx;
// import 'package:fluwx/fluwx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/api/friendDynamics/CircleMsgApiModel.dart';
import '../../model/store/user/User.dart';
import 'package:provider/provider.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
import 'package:flutter/src/material/bottom_sheet.dart';
class FriendDynamicsPage extends StatefulWidget {
    FriendDynamicsPage({Key key}) : super(key: key);
    _FriendDynamicsPageState createState() => _FriendDynamicsPageState();
}

class _FriendDynamicsPageState extends State<FriendDynamicsPage> with SingleTickerProviderStateMixin {
    TabController _tabController;
    RefreshController _circleMsgController = RefreshController(initialRefresh: false);
    RefreshController _friendDynamicsController = RefreshController(initialRefresh: false);
    User _userModel;
    bool _isLoading = true;
    // 最新动态
    int _circleMsgPage = 1;
    bool _circleMsgLoading = true;
    List<Data> _circleMsgList = [];
    
    // 好友动态
    int _friendDynamicsPage = 1;
    bool _friendDynamicsLoading = true;
    List<Data> _friendDynamicsMsgList = [];

    final HttpUtil http = HttpUtil();

    BuildContext shareHandler;
    var selfContext;
    int shareNum = 0;
    int infoId;

    @override
    void initState() {
        super.initState();
        _tabController = TabController(vsync: this, length: 2);
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        if (this._isLoading) {
            this._getData(isInit: true);
            _tabController.addListener(() {
                this._getData(isInit: true);
            });
        }
    }

    _thumbsUp (int id, int isThumbup, int index) async {
        Map response = await this.http.post("/api/v1/circle/msg/$id/thumbup?type=${isThumbup == 0 ? 1 : 0}&userId=${this._userModel.userId}");
        if (response["code"] == 200) {
            if (_tabController.index == 0) {
                this._circleMsgList[index].isThumbup = isThumbup == 0 ? 1 : 0;
                if (isThumbup == 0) {
                    this._circleMsgList[index].thumbup++;
                } else {
                    this._circleMsgList[index].thumbup--;
                }
                setState(() {
                    this._circleMsgList = this._circleMsgList;
                });
            } else {
                this._friendDynamicsMsgList[index].isThumbup = isThumbup == 0 ? 1 : 0;
                if (isThumbup == 0) {
                    this._friendDynamicsMsgList[index].thumbup++;
                } else {
                    this._friendDynamicsMsgList[index].thumbup--;
                }
                setState(() {
                    this._friendDynamicsMsgList = this._friendDynamicsMsgList;
                });
            }
        } else {
            Fluttertoast.showToast(
                msg: response["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
        }
    }
   
    _setShare(int type) async {
        if (Platform.isAndroid) {
            // await fluwx.share(WeChatShareWebPageModel(
            //     transaction: "树友圈详情",
            //     webPage: "http://192.168.2.121:8081/app/#/evaluate",
            //     thumbnail: "",
            //     title: "树友圈详情",
            //     description: "树友圈详情",
            //     scene: type == 1 ? WeChatScene.SESSION : WeChatScene.TIMELINE
            // ));
        }
        Map response = await this.http.post("http://api.zhongyunkj.cn/api/v1/circle/msg/${this.infoId}/share?type=1");
        if (response["code"] == 200) {
            setState(() {
                this.shareNum = response["data"];
            });
            Navigator.pop(this.shareHandler);
        } else {
            Fluttertoast.showToast(
                msg: response["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
        }
    }
    _shareHandler () {
        showModalBottomSheet(
            context: this.selfContext,
            builder: (BuildContext context) {
                this.shareHandler = context;
                return Container(
                    height: ScreenAdaper.height(407),
                    width: double.infinity,
                    color: Colors.black54,
                    child: Container(
                        height: ScreenAdaper.height(407),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)
                            )
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenAdaper.width(30),
                                        left: ScreenAdaper.width(30)
                                    ),
                                    child: Text("分享到", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(30),
                                        color: ColorClass.titleColor
                                    ))
                                ),
                                SizedBox(height: ScreenAdaper.height(40)),
                                Expanded(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            GestureDetector(
                                                onTap: () {
                                                    this._setShare(1);
                                                },
                                                child: Column(
                                                    children: <Widget>[
                                                        Icon(
                                                            IconData(0xe667, fontFamily: "iconfont"),
                                                            size: ScreenAdaper.fontSize(100),
                                                            color: Color(0xFF22b0a1)
                                                        ),
                                                        SizedBox(height: ScreenAdaper.height(20)),
                                                        Text("微信好友", style: TextStyle(
                                                            fontSize: ScreenAdaper.fontSize(24),
                                                            color: ColorClass.fontColor
                                                        ))
                                                    ]
                                                )
                                            ),
                                            SizedBox(width: ScreenAdaper.width(167)),
                                            GestureDetector(
                                                onTap: () {
                                                    this._setShare(2);
                                                },
                                                child: Column(
                                                    children: <Widget>[
                                                        Icon(
                                                            IconData(0xe668, fontFamily: "iconfont"),
                                                            size: ScreenAdaper.fontSize(100),
                                                            color: Color(0xFF22b0a1)
                                                        ),
                                                        SizedBox(height: ScreenAdaper.height(20)),
                                                        Text("微信朋友圈", style: TextStyle(
                                                            fontSize: ScreenAdaper.fontSize(24),
                                                            color: ColorClass.fontColor
                                                        ))
                                                    ]
                                                )
                                            )                                            
                                        ]
                                    )
                                ),
                                GestureDetector(
                                    onTap: () {
                                        Navigator.pop(context);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            top: ScreenAdaper.height(33),
                                            bottom: ScreenAdaper.height(33),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: ColorClass.borderColor,
                                                    width: ScreenAdaper.width(2)
                                                )
                                            )
                                        ),
                                        width: double.infinity,
                                        child: Text("关闭", style: TextStyle(
                                            color: ColorClass.titleColor,
                                            fontSize: ScreenAdaper.fontSize(34)
                                        ))
                                    )
                                )
                                
                            ]
                        )
                    )
                );
            }
        );
    }
    _getData ({isInit = false}) async {
        Map response;
        if (_tabController.index == 0) {
            response = await this.http.get("/api/v1/circle/msg", data: {
                "pageNO": _circleMsgPage,
                "pageSize": 10
            });
        } else {
            response = await this.http.get("/api/v1/circle/frieds/msg", data: {
                "pageNO": _friendDynamicsPage,
                "pageSize": 10,
                "userId": this._userModel.userId
            });
        }
        if (response["code"] == 200) {
            CircleMsgApiModel res = new CircleMsgApiModel.fromJson(response);
            if (isInit) {
                setState(() {
                    if (_tabController.index == 0) {
                        _circleMsgList = res.data;
                        _circleMsgLoading = false;
                        _isLoading = true;
                    } else {
                        _friendDynamicsMsgList = res.data;
                        _friendDynamicsLoading = false;
                    }
                    
                });
            } else {
                setState(() {
                    if (_tabController.index == 0) {
                        _circleMsgList.addAll(res.data);
                    } else {
                        _friendDynamicsMsgList.addAll(res.data);
                    }
                });
            }
        }
        return response;
    }

    void _onLoading() async{
        setState(() {
            if (_tabController.index == 0) {
                this._circleMsgPage++;
            } else {
                this._friendDynamicsPage++;
            }
        });
        var controller = _tabController.index == 0
            ? this._circleMsgController
            : this._friendDynamicsController;
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
                this._circleMsgPage = 1;
            } else {
                this._friendDynamicsPage = 1;
            }
        });
        var controller = _tabController.index == 0
            ? this._circleMsgController
            : this._friendDynamicsController;
        final Map res = await _getData(isInit: true);
        controller.refreshCompleted();
        if (controller.footerStatus == LoadStatus.noMore) {
            controller.loadComplete();
        }
    }

    AppBar _appBar () {
        return AppBar(
            title: PreferredSize(
                child: AppBarWidget().buildAppBar("树友圈"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(88))
            ),
            elevation: 1,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            brightness: Brightness.light,
            actions: <Widget>[
                Center(
                    child: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/friendDynamicsRelease");
                        },
                        child: Text("发布", style: TextStyle(
                            fontSize: ScreenAdaper.fontSize(30),
                            color: ColorClass.fontColor
                        ))
                    )
                ),
                SizedBox(width: ScreenAdaper.width(30))
            ],
            bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: ScreenAdaper.height(6),
                unselectedLabelColor: Color(0XFF666666),
                labelColor: Color(0XFF333333),
                indicator: MyUnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: ScreenAdaper.height(6),
                        color: ColorClass.common
                    )
                ),
                indicatorColor: Color(0XFF22b0a1),
                controller: this._tabController,
                onTap: (int index) {
                    this._getData(isInit: true);
                },
                tabs: <Widget>[
                    Tab(child: Text("最新动态", style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(34)
                    ))),
                    Tab(child: Text("好友动态", style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(34)
                    )))
                ]
            )
        );
    }

    Widget _headPortrait (String name, String time, String url, int id) {
        return Row(
            children: <Widget>[
                GestureDetector(
                    onTap: () {
                        if (id == this._userModel.userId) {
                            Navigator.pushNamed(context, "/myDynamics");
                        } else {
                            Navigator.pushNamed(context, "/friendInformation", arguments: {
                                "id": id
                            });
                        }
                    },
                    child: Container(
                        width: ScreenAdaper.width(85),
                        height: ScreenAdaper.width(85),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.network(
                                url,
                                fit: BoxFit.cover,
                            ),
                        ),
                    )
                ),
                SizedBox(width: ScreenAdaper.width(20)),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(name, style: TextStyle(
                            color: ColorClass.common,
                            fontSize: ScreenAdaper.fontSize(30),
                            fontWeight: FontWeight.w500
                        )),
                        Text(time, style: TextStyle(
                            color: ColorClass.subTitleColor,
                            fontSize: ScreenAdaper.fontSize(24)
                        ))
                    ]
                )
            ]
        );
    }

    Widget iconFont (int icon, String text, {bool isBorder = false, int selectIcon}) {
        return Container(
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(30)
            ),
            decoration: BoxDecoration(
                border: isBorder ? Border(
                    left: BorderSide(color: ColorClass.borderColor, width: ScreenAdaper.width(1)),
                    right: BorderSide(color: ColorClass.borderColor, width: ScreenAdaper.width(1))
                ) : null
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Icon(
                        IconData(selectIcon != null ? selectIcon : icon, fontFamily: "iconfont"),
                        color: selectIcon != null ? ColorClass.common : ColorClass.iconColor,
                        size: ScreenAdaper.fontSize(35),
                    ),
                    SizedBox(width: ScreenAdaper.width(15)),
                    Text(text, style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(27),
                        color: selectIcon != null ? ColorClass.common : ColorClass.iconColor
                    ))
                ]
            )
        );
                    
    }

    Widget _optBar (int thumbup, int comment, int share, int id, int isThumbup, int index) {
        return Row(
            children: <Widget>[
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                            _thumbsUp(id, isThumbup, index);
                        },
                        child: this.iconFont(0xe63f, (thumbup).toString(), selectIcon: isThumbup != 0 ? 0xe63e : null)
                    )
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/friendDynamicsComment", arguments: {
                                "id": id,
                                "isThumbup": isThumbup == 0
                            });
                        },
                        child: this.iconFont(0xe640, (comment).toString(), isBorder: true)
                    ),
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          // print(id);
                        //    this._shareHandler();
                           this.infoId = id;
                            // Navigator.pushNamed(context, "/friendDynamicsComment", arguments: {
                            //     "id": id,
                            //     "isThumbup": isThumbup == 0
                            // });
                        },
                        child: this.iconFont(0xe641, (share).toString())
                    ),
                )
            ]
        );
    }

    Widget _itemWidget (double marginNum, int index, {Data data}) {
        return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(marginNum)
            ),
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    this._headPortrait(
                        data.nickName != null ? data.nickName : "",
                        data.createTime,
                        data.headerImage != null ? data.headerImage: "",
                        data.userId
                    ),
                    Container(
                        margin:EdgeInsets.only(
                            top: ScreenAdaper.width(30)
                        ),
                        child: GestureDetector(
                            onTap: () {
                                Navigator.pushNamed(context, "/friendDynamicsComment", arguments: {
                                    "id": data.messageId,
                                    "isThumbup": data.isThumbup == 0
                                });
                            },
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                    data.content,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 1.2,
                                        fontSize: ScreenAdaper.fontSize(26)
                                    ),
                                    
                                ),
                            )
                        )
                        
                    ),
                    SizedBox(height: ScreenAdaper.height(30)),
                    data.imageUrls != null &&  data.imageUrls.length > 0 ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: ScreenAdaper.width(15),
                            crossAxisSpacing: ScreenAdaper.width(15),
                            childAspectRatio: 1.0
                        ),
                        itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                child: GestureDetector(
                                    onTap: () {
                                    },
                                    child: Image.network(
                                        data.imageUrls[index],
                                        fit: BoxFit.cover,
                                    )
                                )
                                

                            );
                        },
                        itemCount: data.imageUrls.length
                    ) : SizedBox(height: 0),
                    this._optBar(data.thumbup, data.comment, data.share, data.messageId, data.isThumbup, index)
                ]
            )
        );
    }
    @override
    Widget build(BuildContext context) {
       this.selfContext = context;
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: this._appBar(),
            body: TabBarView(
                controller: this._tabController,
                children: <Widget>[
                    this._circleMsgLoading 
                        ? Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(200)
                            ),
                            child: Loading()
                        )
                        : this._circleMsgList.isEmpty
                            ? NullContent("暂无数据")
                            : SmartRefresher(
                                controller: _circleMsgController,
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
                                        Data data = this._circleMsgList[index];
                                        return this._itemWidget(index == 0 ? 0 : 20, index, data: data);
                                    },
                                    itemCount: this._circleMsgList.length
                                )
                            ),
                    this._friendDynamicsLoading
                        ? Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(200)
                            ),
                            child: Loading()
                        )
                        : this._friendDynamicsMsgList.isEmpty
                            ? NullContent("暂无数据")
                            : SmartRefresher(
                                controller: this._friendDynamicsController,
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
                                        Data data = this._friendDynamicsMsgList[index];
                                        return this._itemWidget(index == 0 ? 0 : 20, index, data: data);
                                    },
                                    itemCount: this._friendDynamicsMsgList.length
                                )
                            ),
                    
                ]
            ),
        );
    }
}
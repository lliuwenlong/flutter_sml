import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/api/friendDynamics/CircleMsgApiModel.dart';
import '../../model/store/user/User.dart';
import 'package:provider/provider.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
import '../../components/PhotoDialog.dart';
import '../../components/PictureShow.dart';

class FriendDynamicsPage extends StatefulWidget {
    FriendDynamicsPage({Key key}) : super(key: key);
    _FriendDynamicsPageState createState() => _FriendDynamicsPageState();
}

class _FriendDynamicsPageState extends State<FriendDynamicsPage> with SingleTickerProviderStateMixin {
    TabController _tabController;
    RefreshController _circleMsgController = RefreshController(initialRefresh: false);
    RefreshController _friendDynamicsController = RefreshController(initialRefresh: false);
    User _userModel;

    // 最新动态
    int _circleMsgPage = 1;
    bool _circleMsgLoading = true;
    List<Data> _circleMsgList = [];

    // 好友动态
    int _friendDynamicsPage = 1;
    bool _friendDynamicsLoading = true;
    List<Data> _friendDynamicsMsgList = [];

    final HttpUtil http = HttpUtil();
    @override
    void initState() {
        super.initState();
        _tabController = TabController(vsync: this, length: 2);
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        this._getData(isInit: true);
    }

    _thumbsUp (int id) async {
        Map response = await this.http.post("/api/v1/circle/msg/${id}/thumbup?type=0&userId=${this._userModel.userId}");
        if (response["code"] == 200) {
            this._getData();
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

    _getData ({isInit = false}) async {
        Map response = await this.http.get("/api/v1/circle/msg", data: {
            "pageNO": _circleMsgPage,
            "pageSize": 10,
            "userId": this._userModel.userId
        });
        if (response["code"] == 200) {
            CircleMsgApiModel res = new CircleMsgApiModel.fromJson(response);
            if (isInit) {
                setState(() {
                    if (_tabController.index == 0) {
                        _circleMsgList = res.data;
                        _circleMsgLoading = false;
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
    }
    AppBar _appBar () {
        return AppBar(
            title: Text("树友圈", style: TextStyle(
                color: Colors.black,
                fontSize: ScreenAdaper.fontSize(34)
            )),
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
                indicatorColor: Color(0XFF22b0a1),
                controller: this._tabController,
                onTap: (int index) {
                    this._getData(isInit: true);
                },
                tabs: <Widget>[
                    Tab(child: Text("最新动态", style: TextStyle(
                        color: Color(0XFF666666),
                        fontSize: ScreenAdaper.fontSize(34)
                    ))),
                    Tab(child: Text("好友动态", style: TextStyle(
                        color: Color(0XFF666666),
                        fontSize: ScreenAdaper.fontSize(34)
                    )))
                ]
            )
        );
    }

    Widget _headPortrait (String name, String time, String url) {
        return Row(
            children: <Widget>[
                GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(context, "/friendInformation");
                    },
                    child: Container(
                        width: ScreenAdaper.width(85),
                        height: ScreenAdaper.width(85),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.network(
                                "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
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

    Widget iconFont (int icon, String text, {bool isBorder = false}) {
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
                        IconData(icon, fontFamily: "iconfont"),
                        color: ColorClass.iconColor,
                        size: ScreenAdaper.fontSize(35),
                    ),
                    SizedBox(width: ScreenAdaper.width(15)),
                    Text(text, style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(27),
                        color: ColorClass.iconColor
                    ))
                ]
            )
        );
                    
    }
    Widget _optBar (int thumbup, int comment, int share, int id) {
        return Row(
            children: <Widget>[
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                            _thumbsUp(id);
                        },
                        child: this.iconFont(0xe63f, (thumbup).toString())
                    )
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/friendDynamicsComment", arguments: {
                                "id": id
                            });
                        },
                        child: this.iconFont(0xe640, (comment).toString(), isBorder: true)
                    ),
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/friendDynamicsComment", arguments: {
                                "id": id
                            });
                        },
                        child: this.iconFont(0xe641, (share).toString())
                    ),
                )
            ]
        );
    }

    Widget _itemWidget (double marginNum, {Data data}) {
        return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            margin: EdgeInsets.only(
                top: ScreenAdaper.height(marginNum)
            ),
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    this._headPortrait(data.nickName != null ? data.nickName : "", data.createTime, data.imageUrl),
                    Container(
                        margin:EdgeInsets.only(
                            top: ScreenAdaper.width(30)
                        ),
                        child: Text(data.content, maxLines: 3, overflow: TextOverflow.ellipsis,),
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
                            print(data.imageUrls[index]);
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
                    this._optBar(data.thumbup, data.comment, data.share, data.messageId)
                ]
            )
        );
    }
    @override
    Widget build(BuildContext context) {
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
                                return this._itemWidget(index == 0 ? 0 : 20, data: data);
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
                                return this._itemWidget(index == 0 ? 0 : 20, data: data);
                            },
                            itemCount: this._friendDynamicsMsgList.length
                        )
                    ),
                    
                ]
            ),
        );
    }
}
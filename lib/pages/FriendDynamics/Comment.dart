import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sml/model/store/user/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/friendDynamics/CircleMsgApiModel.dart';
import '../../model/api/friendDynamics/CommentModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:ui';

class FriendDynamicsComment extends StatefulWidget {
    final Map arguments;
    FriendDynamicsComment({Key key, this.arguments}) : super(key: key);
    _FriendDynamicsCommentState createState() =>
      _FriendDynamicsCommentState(isThumbup: arguments["isThumbup"]);
}

class _FriendDynamicsCommentState extends State<FriendDynamicsComment> {
    var selfContext;
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    HttpUtil http = HttpUtil();
    Data data;
    int _pageNO = 1;
    int total = 0;
    List _commentData = [];
    int thumbsUpNum = 0;
    int shareNum = 0;
    BuildContext shareHandler;
    bool isDisabled = false;
    bool isThumbup;
    _FriendDynamicsCommentState({Key key, this.isThumbup});
    TextEditingController controller =
        TextEditingController.fromValue(TextEditingValue(text: ""));
    TextEditingController controllerII =
        TextEditingController.fromValue(TextEditingValue(
        text: "",
    ));
    User _userModel;
    bool isOpenKeyboard = false;
    FocusNode _commentFocus = FocusNode();

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
    }

  @override
  initState() {
    super.initState();
    _getData();
    _getCommentData(isInit: true);
    KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
            print("!23123");
            if (!visible) {
                setState(() {
                    this.isOpenKeyboard = false;
                });
            }
        },
    );
  }

    _getCommentData({bool isInit: false}) async {
        Map<String, dynamic> response = await HttpUtil().get(
            "/api/v1/circle/msg/${widget.arguments["id"]}/comment?pageNO=${this._pageNO}&pageSize=10");
        if (response["code"] == 200) {
            CommentModel baseModel = new CommentModel.fromJson(response["data"]);
            if (isInit) {
                setState(() {
                    _commentData = baseModel.data;
                    this.total = baseModel.total;
                });
            } else {
                setState(() {
                    _commentData.addAll(baseModel.data);
                });
            }
        }
        return response;
    }

    void _onRefresh() async {
        setState(() {
            this._pageNO = 1;
        });
        final Map res = await _getCommentData(isInit: true);
        _refreshController.refreshCompleted();
        if (_refreshController.footerStatus == LoadStatus.noMore) {
                _refreshController.loadComplete();
        }
    }

void _onLoading() async {
    setState(() {
        this._pageNO++;
    });
    var response = await _getCommentData();
    if (response["data"].length == 0) {
         _refreshController.loadNoData();
    } else {
        _refreshController.loadComplete();
    }
}

void _addComent() async {
    if (this.controller.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "评论内容不可以为空",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            textColor: Colors.white,
            fontSize: ScreenAdaper.fontSize(30)
        );
        return;
    }
    Map response = await this.http.post(
        "/api/v1/circle/msg/${this.widget.arguments["id"]}/comment",
        params: {
            "userId": this._userModel.userId,
            "content": this.controller.text
        });
    this._commentFocus.unfocus();
    if (response["code"] == 200) {
        this.controller.clear();
        Fluttertoast.showToast(
            msg: "评论成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            textColor: Colors.white,
            fontSize: ScreenAdaper.fontSize(30)
        );
    }
}

_getData() async {
    final Map response =
        await this.http.get("/api/v1/circle/msg/${widget.arguments["id"]}");
    if (response["code"] == 200) {
         Data data = new Data.fromJson(response["data"]);
        setState(() {
            this.data = data;
            this.thumbsUpNum = data.thumbup;
            this.shareNum = response["data"]["shares"];
        });
    }
}

  _reportHandler() {
    showModalBottomSheet(
        context: this.selfContext,
        builder: (BuildContext context) {
            return Container(
                height: ScreenAdaper.height(281),
                width: double.infinity,
                color: Colors.black54,
                child: Container(
                    height: ScreenAdaper.height(281),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                    child: Column(children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                                Navigator.of(context).pop();
                                Navigator.pushNamed(
                                    context, "/friendDynamicsReport", arguments: {
                                "id": this.widget.arguments["id"]
                              });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(IconData(0xe642, fontFamily: "iconfont"),
                                      size: ScreenAdaper.fontSize(42)),
                                  SizedBox(width: ScreenAdaper.width(20)),
                                  Text("举报",
                                      style: TextStyle(
                                          color: ColorClass.titleColor,
                                          fontSize: ScreenAdaper.fontSize(30)))
                                ]))),
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
                                        width: ScreenAdaper.width(2)))),
                            width: double.infinity,
                            child: Text("关闭",
                                style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(34)))))
                  ])));
        });
  }

  _shareHandler() {
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
                          topRight: Radius.circular(5))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenAdaper.width(30),
                                left: ScreenAdaper.width(30)),
                            child: Text("分享到",
                                style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(30),
                                    color: ColorClass.titleColor))),
                        SizedBox(height: ScreenAdaper.height(40)),
                        Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                      this._setShare(1);
                                  },
                                  child: Column(children: <Widget>[
                                    Icon(
                                        IconData(0xe667,
                                            fontFamily: "iconfont"),
                                        size: ScreenAdaper.fontSize(100),
                                        color: Color(0xFF22b0a1)),
                                    SizedBox(height: ScreenAdaper.height(20)),
                                    Text("微信好友",
                                        style: TextStyle(
                                            fontSize: ScreenAdaper.fontSize(24),
                                            color: ColorClass.fontColor))
                                  ])),
                              SizedBox(width: ScreenAdaper.width(167)),
                              GestureDetector(
                                  onTap: () {
                                      this._setShare(2);
                                  },
                                  child: Column(children: <Widget>[
                                    Icon(
                                        IconData(0xe668,
                                            fontFamily: "iconfont"),
                                        size: ScreenAdaper.fontSize(100),
                                        color: Color(0xFF22b0a1)),
                                    SizedBox(height: ScreenAdaper.height(20)),
                                    Text("微信朋友圈",
                                        style: TextStyle(
                                            fontSize: ScreenAdaper.fontSize(24),
                                            color: ColorClass.fontColor))
                                  ]))
                            ])),
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
                                            width: ScreenAdaper.width(2)))),
                                width: double.infinity,
                                child: Text("关闭",
                                    style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(34)))))
                      ])));
        });
  }

  _thumbsUp() async {
    Map response = await this.http.post(
        "/api/v1/circle/msg/${this.widget.arguments["id"]}/thumbup?type=${!this.isThumbup ? 0 : 1}&userId=${this._userModel.userId}");
    if (response["code"] == 200) {
        setState(() {
            this.thumbsUpNum = response["data"];
            this.isThumbup = !this.isThumbup;
        });
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
            await fluwx.share(fluwx.WeChatShareWebPageModel(
                transaction: "树友圈详情",
                webPage: "http://192.168.2.121:8081/app/#/evaluate",
                thumbnail: "",
                title: "树友圈详情",
                description: "树友圈详情",
                scene: type == 1 ? fluwx.WeChatScene.SESSION : fluwx.WeChatScene.TIMELINE
            ));
        }
        
        Map response = await this.http.post("http://api.zhongyunkj.cn/api/v1/circle/msg/${this.widget.arguments["id"]}/share?type=1");
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

  Widget _headPortrait(String url) {
    return Row(children: <Widget>[
        Container(
            width: ScreenAdaper.width(85),
            height: ScreenAdaper.width(85),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Image.network(
                url,
                fit: BoxFit.cover,
            ),
            ),
        ),
      SizedBox(width: ScreenAdaper.width(20)),
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.data != null ? this.data.nickName : "",
                style: TextStyle(
                    color: ColorClass.common,
                    fontSize: ScreenAdaper.fontSize(30),
                    fontWeight: FontWeight.w500)),
            Text(this.data != null ? this.data.createTime : "",
                style: TextStyle(
                    color: ColorClass.subTitleColor,
                    fontSize: ScreenAdaper.fontSize(24)))
          ]),
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                    this._reportHandler();
                    },
                    icon: Icon(IconData(0xe666, fontFamily: "iconfont")),
                    color: ColorClass.fontColor,
                iconSize: ScreenAdaper.fontSize(37),
              )))
    ]);
  }

  Widget _itemWidget(double marginNum) {
    return Container(
        padding: EdgeInsets.all(ScreenAdaper.width(30)),
        margin: EdgeInsets.only(top: ScreenAdaper.height(marginNum)),
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                this._headPortrait(
                    this.data != null && this.data.headerImage != null
                      ? this.data.headerImage
                      : ""),
                this.data != null &&
                      this.data.content != null &&
                      this.data.content.isNotEmpty
                    ? Container(
                      margin: EdgeInsets.only(top: ScreenAdaper.width(30)),
                      child: Text(this.data.content, style: TextStyle(
                          fontSize: ScreenAdaper.fontSize(26)
                      ),),
                    )
                  : SizedBox(),
              SizedBox(height: ScreenAdaper.height(30)),
              this.data != null &&
                        data.imageUrls != null &&
                        data.imageUrls.length > 0
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: ScreenAdaper.width(15),
                            crossAxisSpacing: ScreenAdaper.width(15),
                            childAspectRatio: 1.0),
                        itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(ScreenAdaper.width(10)),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Image.network(
                                    data.imageUrls[index],
                                    fit: BoxFit.cover,
                                    )));
                        },
                        itemCount: data.imageUrls.length)
                    : SizedBox(height: 0),
            ]));
  }

  Widget _commentItem(CommentData data) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenAdaper.width(30),
        right: ScreenAdaper.width(30),
        top: ScreenAdaper.width(30),
      ),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          width: ScreenAdaper.width(85),
          height: ScreenAdaper.width(85),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Image.network(
              "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: ScreenAdaper.width(30),
        ),
        Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: ScreenAdaper.height(10)),
                  Text(data.nickName,
                      style: TextStyle(
                          color: ColorClass.fontColor,
                          fontSize: ScreenAdaper.fontSize(30),
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: ScreenAdaper.height(15)),
                  Container(
                    width: double.infinity,
                    child: Text(data.content,
                        style: TextStyle(
                          color: ColorClass.titleColor,
                          fontSize: ScreenAdaper.fontSize(28),
                        )),
                  ),
                  SizedBox(height: ScreenAdaper.height(5)),
                  Text(data.createTime,
                      style: TextStyle(
                        color: ColorClass.subTitleColor,
                        fontSize: ScreenAdaper.fontSize(24),
                      ))
                ]))
      ]),
    );
  }

  Widget _comment() {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
        padding: EdgeInsets.only(bottom: ScreenAdaper.width(30)),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: ColorClass.borderColor,
                        width: ScreenAdaper.width(2)))),
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            child: Text("全部评论（${this.total}）",
                style: TextStyle(
                    color: ColorClass.subTitleColor,
                    fontSize: ScreenAdaper.fontSize(30))),
          ),
          this._commentData.isEmpty
              ? Container(
                    color: Colors.white,
                    height: ScreenAdaper.height(200),
                    child: Center(
                    child: Text("暂无评论",
                        style: TextStyle(
                            color: ColorClass.subTitleColor,
                            fontSize: ScreenAdaper.fontSize(30))),
                  ),
                )
              : Wrap(
                    children: this._commentData.map((val) {
                        return _commentItem(val);
                    }).toList(),
                )
        ]));
  }

  Widget _readInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: ScreenAdaper.width(40)),
        Expanded(
            child: GestureDetector(
                onTap: () {
                    setState(() {
                        this.isOpenKeyboard = true;
                    });
                },
                child: Container(
                    height: ScreenAdaper.height(75),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: ScreenAdaper.width(30),
                        right: ScreenAdaper.width(30),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFf5f5f5),
                        borderRadius:
                        BorderRadius.circular(ScreenAdaper.width(10)),
                    ),
                    child: Text("快给他评价一下吧",
                        style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: ScreenAdaper.fontSize(28)))))),
        SizedBox(width: ScreenAdaper.width(40)),
        GestureDetector(
            onTap: this._thumbsUp,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Text("${this.thumbsUpNum}",
                        style: TextStyle(
                            color: this.isThumbup
                              ? ColorClass.subTitleColor
                              : ColorClass.common,
                            fontSize: ScreenAdaper.fontSize(18))),
                  SizedBox(height: ScreenAdaper.height(10)),
                  Icon(
                        IconData(this.isThumbup ? 0xe63f : 0xe63e,
                          fontFamily: "iconfont"),
                        color: this.isThumbup
                          ? ColorClass.iconColor
                          : ColorClass.common,
                        size: ScreenAdaper.fontSize(35)),
                ])),
        SizedBox(width: ScreenAdaper.width(40)),
        GestureDetector(
            onTap: () {
              this._shareHandler();
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Text("${this.shareNum}",
                        style: TextStyle(
                            color: ColorClass.subTitleColor,
                            fontSize: ScreenAdaper.fontSize(18))),
                    SizedBox(height: ScreenAdaper.height(10)),
                    Icon(IconData(0xe641, fontFamily: "iconfont"),
                        color: ColorClass.iconColor,
                        size: ScreenAdaper.fontSize(35)),
                ])),
        SizedBox(width: ScreenAdaper.width(40)),
      ],
    );
  }

Widget _editInput(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: ScreenAdaper.height(30)
        ),
        height: ScreenAdaper.height(380),
        color: Colors.white,
        child: Column(children: <Widget>[
            TextField(
                focusNode: _commentFocus,
                autofocus: true,
                maxLines: 5,
                controller: controller,
            onChanged: (String val) {
                if (val.isNotEmpty) {
                setState(() {
                    this.isDisabled = true;
                });
                } else {
                setState(() {
                    this.isDisabled = false;
                });
                }
            },
            decoration: InputDecoration(
                fillColor: Color(0xFFf5f5f5),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenAdaper.width(10)),
                    borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30),
                    ScreenAdaper.width(25),
                    ScreenAdaper.width(30),
                    ScreenAdaper.width(25)),
                hintText: "快给他评价一下吧",
                hintStyle: TextStyle(
                    color: ColorClass.subTitleColor,
                    fontSize: ScreenAdaper.fontSize(28))),
            ),
            Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                child: Container(
                    width: ScreenAdaper.width(160),
                    height: ScreenAdaper.height(75),
                    child: RaisedButton(
                    color: ColorClass.common,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ScreenAdaper.width(10)),
                        // side: BorderSide(
                        //     color: Color(0xFFc1a786)
                        // )
                    ),
                    elevation: 0,
                    disabledColor: Color(0xFF86d4ca),
                    onPressed: this.isDisabled
                        ? () {
                            this._addComent();
                            }
                        : null,
                    child: Text("发送",
                        style: TextStyle(
                            fontSize: ScreenAdaper.fontSize(32),
                            color: Colors.white)),
                    ),
                ),
            )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    this.selfContext = context;
    ScreenAdaper.init(context);
    return Stack(
        children: <Widget>[
            Scaffold(
        appBar: PreferredSize(
            child: AppBarWidget().buildAppBar("详情"),
            preferredSize: Size.fromHeight(ScreenAdaper.height(110))),
        body: Column(children: <Widget>[
            Expanded(
                flex: 1,
                child: SmartRefresher(
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
                        loadingText: "加载中"),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[
                            this._itemWidget(0),
                            this._comment()
                        ]))),
          Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(20),
                    ScreenAdaper.height(10),
                    ScreenAdaper.width(20),
                    ScreenAdaper.height(10) +
                    MediaQueryData.fromWindow(window).padding.bottom),
                width: double.infinity,
                child: !this.isOpenKeyboard
                    ? this._readInput()
                    : this._editInput(context))
        ])),
        !this.isOpenKeyboard ? Container() : Positioned(
                top: 0,
                left: 0,
                bottom: MediaQuery.of(context).viewInsets.bottom + ScreenAdaper.height(400),
                right: 0,
                child: Container(
                    height: double.infinity,
                    color: Colors.black38,
                ),
            )
        ],
    );
  }
}

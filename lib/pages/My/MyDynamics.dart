import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_sml/model/api/friendDynamics/CircleMsgApiModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/store/user/User.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/friendDynamics/InformationApiModel.dart';
import '../../components/NullContent.dart';
import 'dart:ui';

class MyDynamics extends StatefulWidget {
    final Map arguments;
    MyDynamics({Key key, this.arguments}) : super(key: key);
    _MyDynamicsState createState() => _MyDynamicsState();
}


class _MyDynamicsState extends State<MyDynamics> {
    BuildContext selfContext;
    RefreshController _friendDynamicsController = RefreshController(initialRefresh: false);
    _MyDynamicsState({Key key});
    HttpUtil http = HttpUtil();
    InformationApiModel informationApiModel;
    List _circleMsgList = [];
    int _circleMsgPage = 1;
    User _userModel;
    bool isLoading = false;
    @override
    initState () {
        super.initState();
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        if (!isLoading) {
            _userModel = Provider.of<User>(context);
            this._getData(isInit: true);
            setState(() {
                this.isLoading = true;
            });
        }
        this._getOverviewData();
    }

    _thumbsUp (int id, int isThumbup, int index) async {
        Map response = await this.http.post("/api/v1/circle/msg/${id}/thumbup?type=${isThumbup == 0 ? 1 : 0}&userId=${this._userModel.userId}");
        if (response["code"] == 200) {
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

    _getOverviewData () async {
        Map response = await this.http.get("/api/v1/circle/overview?userId=${this._userModel.userId}");
        if (response["code"] == 200) {
            InformationApiModel info = new InformationApiModel.fromJson(response["data"]);
            setState(() {
                this.informationApiModel = info;
            });
        }
    }


    _getData ({isInit = false}) async {
        Map response = await this.http.get("/api/v1/circle/msg", data: {
            "pageNO": this._circleMsgPage,
            "pageSize": 10,
            "userId": this._userModel.userId
        });
        if (response["code"] == 200) {
            CircleMsgApiModel res = new CircleMsgApiModel.fromJson(response);
            if (isInit) {
                setState(() {
                    _circleMsgList = res.data;
                });
            } else {
                setState(() {
                    _circleMsgList.addAll(res.data);
                });
            }
        }
        return response;
    }

    void _onRefresh() async{
        setState(() {
            this._circleMsgPage = 1;
        });
        await _getData(isInit: true);
        _friendDynamicsController.refreshCompleted();
        if (_friendDynamicsController.footerStatus == LoadStatus.noMore) {
            _friendDynamicsController.loadComplete();
        }
    }

    void _onLoading() async{
        setState(() {
            this._circleMsgPage++;
        });
        var response = await _getData();
        if (response["data"].length == 0) {
            _friendDynamicsController.loadNoData();
        } else {
            _friendDynamicsController.loadComplete();
        }
    }

    void _deleteShowDialog (int index, int messageId) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('删除动态'),
                    content:Text('确定删除该动态吗，删除之后无法恢复！', style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(30),
                        color: ColorClass.titleColor,
                        height: 1.3
                    )),
                    contentPadding: EdgeInsets.all(ScreenAdaper.width(30)),
                    titlePadding: EdgeInsets.fromLTRB(
                        ScreenAdaper.width(30),
                        ScreenAdaper.width(30),
                        ScreenAdaper.width(30),
                        0
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text('取消', style: TextStyle(
                                fontSize: ScreenAdaper.fontSize(30),
                                color: ColorClass.titleColor
                            )),
                            onPressed: (){
                                Navigator.of(context).pop();
                            },
                        ),
                        FlatButton(
                            child: Text('确定', style: TextStyle(
                                fontSize: ScreenAdaper.fontSize(30),
                                color: ColorClass.titleColor
                            )),
                            onPressed: (){
                                this._deleteItem(index, messageId);
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    elevation: 20,
                    semanticLabel:'哈哈哈哈',
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenAdaper.width(10)))
                );
            }
        );
    }

    void _deleteItem (int index, int id) async {
        Map responst = await this.http.post("/api/v1/circle/${_userModel.userId}/msg/${id}");
        print(id); 
        if (responst["code"] == 200) {
            setState(() {
                this._circleMsgList.removeAt(index);
                this.informationApiModel.messages--;
            });
            Fluttertoast.showToast(
                msg: "删除成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
        }
    }
    
    Widget _buildTopBar () {
        double top = MediaQueryData.fromWindow(window).padding.top;
        return Container(
            height: ScreenAdaper.height(370) + top,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/dongtai.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Container(
                margin: EdgeInsets.only(top: top),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            height: ScreenAdaper.height(88),
                            padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
                            child: GestureDetector(
                                onTap: () {
                                    Navigator.pop(this.selfContext);
                                },
                                child: Icon(
                                    Icons.arrow_back_ios,
                                    size: ScreenAdaper.fontSize(40, allowFontScaling: true),
                                    color: Colors.white,
                                )
                            )
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
                            width: double.infinity,
                            child: Row(
                                children: <Widget>[
                                    Container(
                                        width: ScreenAdaper.width(160),
                                        child: Stack(
                                            children: <Widget>[
                                                Positioned(
                                                    child: Container(
                                                        width: ScreenAdaper.width(140),
                                                        height: ScreenAdaper.width(140),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(150),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    this.informationApiModel != null && this.informationApiModel.headerImage != null
                                                                        ? this.informationApiModel.headerImage
                                                                        : ""
                                                                    ),
                                                                fit: BoxFit.cover
                                                            )
                                                        )
                                                    ),
                                                ),
                                                Positioned(
                                                    bottom: ScreenAdaper.height(12),
                                                    right: ScreenAdaper.width(0),
                                                    child: Container(
                                                        width: ScreenAdaper.width(40),
                                                        height: ScreenAdaper.width(40),
                                                        child: Image.asset(
                                                            "images/jia-v.png",
                                                            fit: BoxFit.cover
                                                        )
                                                    )
                                                )
                                            ],
                                        )
                                    ),
                                    SizedBox(width: ScreenAdaper.width(20)),
                                    Text(this.informationApiModel != null && this.informationApiModel.nickName != null
                                        ? this.informationApiModel.nickName.toString()
                                        : "", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(40),
                                        color: Colors.white
                                    ))
                                ]
                            )
                        ),
                        SizedBox(
                            height: ScreenAdaper.height(40),
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                        onTap: () {
                                            Navigator.pushNamed(context, "/followOrFans", arguments: {
                                                "index": 0
                                            });
                                        },
                                        child: Column(
                                            children: <Widget>[
                                                Text(this.informationApiModel != null && this.informationApiModel.focus != null
                                                    ? this.informationApiModel.focus.toString()
                                                    : "0",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: ScreenAdaper.fontSize(34),
                                                    fontWeight: FontWeight.w500
                                                )),
                                                Text("关注", style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                ))
                                            ],
                                        )
                                    ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                        onTap: () {
                                            Navigator.pushNamed(context, "/followOrFans", arguments: {
                                                "index": 1
                                            });
                                        },
                                        child: Column(
                                            children: <Widget>[
                                                Text(this.informationApiModel != null && this.informationApiModel.fans != null
                                                    ? this.informationApiModel.fans.toString()
                                                    : "0",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: ScreenAdaper.fontSize(34),
                                                        fontWeight: FontWeight.w500
                                                )),
                                                Text("粉丝", style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                ))
                                            ],
                                        )
                                    ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        children: <Widget>[
                                            Text(this.informationApiModel != null && this.informationApiModel.messages != null
                                                ? this.informationApiModel.messages.toString()
                                                : "0", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(34),
                                                fontWeight: FontWeight.w500
                                            )),
                                            Text("动态", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenAdaper.fontSize(24)
                                            ))
                                        ]
                                    )
                                )
                            ]
                        )
                    ],
                ),
            ),
        );
    }

    Widget _headPortrait (String name, String time, String url, int index, int messageId) {
        return Row(
            children: <Widget>[
                GestureDetector(
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
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.white,
                        width: ScreenAdaper.width(30),
                        child: IconButton(
                            icon: Icon(IconData(0xe633, fontFamily: 'iconfont')),
                            iconSize: ScreenAdaper.fontSize(22),
                            color: Color(0xffaaaaaa),
                            onPressed: () {
                                this._deleteShowDialog(index, messageId);
                            },
                        ),
                    )
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
                            Navigator.pushNamed(context, "/friendDynamicsComment", arguments: {
                                "id": id,
                                "isThumbup": isThumbup == 0
                            });
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
                        index,
                        data.messageId
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
                                child: Text(
                                    data.content,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(26)
                                    ),
                                )
                            ),
                        ),
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
                    this._optBar(data.thumbup, data.comment, data.share, data.messageId, data.isThumbup, index)
                ]
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        this.selfContext = context;
        return Scaffold(
            body: Column(
                children: <Widget>[
                    this._buildTopBar(),
                    Expanded(
                        // flex: 1,
                        child: this._circleMsgList.isEmpty
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
                                child: ListView(
                                    children: <Widget>[
                                        Container(
                                            color: Colors.white,
                                            height: ScreenAdaper.height(110),
                                            padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                "我的动态（${this.informationApiModel != null && this.informationApiModel.messages != null
                                                ? this.informationApiModel.messages.toString()
                                                : "0"}）",
                                                style: TextStyle(
                                                    color: Color(0xff999999),
                                                    fontSize: ScreenAdaper.fontSize(30)
                                                ),
                                            ),
                                        ),
                                        Wrap(
                                            children: this._circleMsgList.map((data) {
                                                int index = this._circleMsgList.indexOf(data);
                                                return this._itemWidget(
                                                    index== 0 ? 0 : 20,
                                                    index,
                                                    data: data
                                                );
                                            }).toList(),
                                        )
                                    ],
                                )
                            )
                    )
                ],
            ),
        );
    }
}
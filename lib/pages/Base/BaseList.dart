import 'package:flutter/material.dart';
import 'package:flutter_sml/common/HttpUtil.dart';
import 'package:flutter_sml/components/Loading.dart';
import '../../services/ScreenAdaper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/api/base/BaseListModel.dart';
import 'package:transparent_image/transparent_image.dart';

class BaseList extends StatefulWidget {
    final Map arguments;
    BaseList({Key key, this.arguments}) : super(key: key);
    _BaseListState createState() => _BaseListState(arguments);
}

class _BaseListState extends State<BaseList> {
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    int _page = 1;
    List<Data> baseList = [];
    bool isLoading = false;
    int id;
    _BaseListState (arguments) {
        this.id = arguments["id"];
    }
    void initState() {
        super.initState();
        setState(() {
            isLoading = true;
        });
        this._getData();
    }

    _getData ({bool isInit = false}) async {
        Map<String, dynamic> response = await HttpUtil().get(
            "/api/v1/wood/${this.id}/data",
            data: {
                "pageNO": this._page,
                "pageSize": 10
            }
        );        
        if (response["code"] == 200) {
            final BaseListModel baseModel = new BaseListModel.fromJson(response);
            if (isInit) {
                setState(() {
                    baseList = baseModel.data;
                });
            } else {
                setState(() {
                    baseList.addAll(baseModel.data);
                    if (isLoading) {
                        isLoading = false;
                    } 
                });
            }
        }
        return response;
    }

    Widget _itemWidget (String name, String image) {
        return Container(
            width: ScreenAdaper.width(335),
            // height: ScreenAdaper.height(400),
            padding: EdgeInsets.only(
                top: ScreenAdaper.width(30)
            ),
            alignment: Alignment.center,
            child: Stack(
                children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                        child: FadeInImage.assetNetwork(
                            placeholder: "images/zhuangtailan.png",
                            placeholderScale: 1.0,
                            image: 'http://pic1.sc.chinaz.com/Files/pic/pic9/201907/zzpic19227_s.jpg',
                            fit: BoxFit.cover
                        ),
                    ),
                    Positioned(
                        top: ScreenAdaper.width(20),
                        left: ScreenAdaper.width(20),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(36),
                                ScreenAdaper.height(15),
                                ScreenAdaper.width(36),
                                ScreenAdaper.height(15)
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            child: Text(name, style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true)
                            )),
                        )
                    )
                ]
            ),
        );
    }

    void _onRefresh() async{
        setState(() {
            this._page = 1;
        });
        await _getData(isInit: true);
        _refreshController.refreshCompleted();
    }

    void _onLoading() async{
        setState(() {
            this._page++;
        });
        var response = await _getData();
        if (response["data"].length) {
            _refreshController.loadNoData();
        } else {
            _refreshController.loadComplete();
        }
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("神木列表", style: TextStyle(
                    color: Colors.black,
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light
            ),
            body: isLoading ? Loading() : Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30),
                    0,
                    ScreenAdaper.width(30),
                    ScreenAdaper.width(30)
                ),
                child: SmartRefresher(
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
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: Wrap(
                        spacing: ScreenAdaper.width(15),
                        children: this.baseList.map((Data val) {
                            return this._itemWidget(val.name, val.image);
                        }).toList()
                    )
                )
            )
        );
    }
}
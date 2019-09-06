import 'package:flutter/material.dart';
import 'package:flutter_sml/components/Loading.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/base/BaseModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class Base extends StatefulWidget {
    Base({Key key}) : super(key: key);
    _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
    int _page = 1;
    List<Data> baseList = [];
    bool isLoading = false;
    RefreshController _refreshController = RefreshController(initialRefresh: false);

    void initState() {
        super.initState();
        setState(() {
            isLoading = true;
        });
        this._getData();
    }

    _getData ({bool isInit = false}) async {
        Map<String, dynamic> response = await HttpUtil().get("/api/v1/woodsbase/data?pageNO=${this._page}&pageSize=10");
        if (response["code"] == 200) {
            final BaseModel baseModel = new BaseModel.fromJson(response);
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

    Widget _cardItem(String name, int id) {
        return Container(
            margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                0,
                ScreenAdaper.width(30),
                0
            ),
            child: Card(
                elevation: 0,
                child: Column(
                    children: <Widget>[
                        AspectRatio(
                            aspectRatio: 690 / 276,
                            child: GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(context, "/baseDetails");
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        topLeft: Radius.circular(4)
                                    ),
                                    child: Image.network(
                                        "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                        fit: BoxFit.cover,
                                    )
                                )
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(20),
                                ScreenAdaper.height(30),
                                ScreenAdaper.width(20),
                                ScreenAdaper.height(30)
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Row(
                                        children: <Widget>[
                                            Icon(
                                                IconData(0xe61d, fontFamily: "iconfont"),
                                                size: ScreenAdaper.fontSize(30, allowFontScaling: true),
                                                color: Color(0xFF22b0a1)
                                            ),
                                            SizedBox(width: ScreenAdaper.width(20)),
                                            Text(name, style: TextStyle(
                                                color: Color(0xFF666666),
                                                fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                                            ))
                                        ],
                                    ),
                                    Container(
                                        child: RaisedButton(
                                            onPressed: () {
                                                Navigator.pushNamed(context, '/baseList', arguments: {"id": id});
                                            },
                                            color: Color(0xFF22b0a1),
                                            splashColor: Color.fromRGBO(0, 0, 0, 0),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(6))
                                            ),
                                            child: Text("查看神木", style: TextStyle(
                                                color: Color(0xFFffffff)
                                            )),
                                        )
                                    )
                                ]
                            ),
                        )
                    ]
                )
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("神木基地", style: TextStyle(
                    color: Colors.black,
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light
            ),
            body: isLoading ? Loading() : SmartRefresher(
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
                child: ListView.builder(
                    itemCount: baseList.length,
                    itemBuilder: (BuildContext context, int index) {
                        return _cardItem(this.baseList[index].baseName, this.baseList[index].baseId);
                    },
                )
            )
        );
    }
}
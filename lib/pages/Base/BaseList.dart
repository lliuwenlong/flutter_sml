import 'package:flutter/material.dart';
import 'package:flutter_sml/common/HttpUtil.dart';
import 'package:flutter_sml/components/Loading.dart';
import '../../services/ScreenAdaper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/api/base/BaseListModel.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
import '../../components/AppBarWidget.dart';
class BaseList extends StatefulWidget {
    final Map arguments;
    BaseList({Key key, this.arguments}) : super(key: key);
    _BaseListState createState() => _BaseListState(arguments: this.arguments);
}

class _BaseListState extends State<BaseList> {
    final arguments;
    RefreshController _refreshController =
    RefreshController(initialRefresh: false);
    int _page = 1;
    List<Data> baseList = [];
    bool isLoading = true;
    int id;
    _BaseListState({this.arguments});

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        this.id = arguments['id'];
        _getData(isInit: true);
    }

    _getData({bool isInit = false}) async {
        Map<String, dynamic> response = await HttpUtil().get(
            "/api/v1/wood/${this.id}/data",
            data: {"pageNO": this._page, "pageSize": 10});
        if (response["code"] == 200) {
        final BaseListModel baseModel = new BaseListModel.fromJson(response);
        if (isInit) {
            setState(() {
                baseList = baseModel.data;
                this.isLoading = false;
            });
        } else {
            setState(() {
                baseList.addAll(baseModel.data);
                });
            }
        }
        return response;
    }

    Widget _itemWidget(int woodId, String name, String image) {
        return Container(
            width: ScreenAdaper.width(335),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenAdaper.width(10)),
                )
            ),
            // height: ScreenAdaper.height(400),
            padding: EdgeInsets.only(top: ScreenAdaper.width(20)),
            alignment: Alignment.center,
            child: GestureDetector(
                onTap: () {
                Navigator.pushNamed(context, '/shenmuDetails',
                    arguments: {'id': woodId, 'baseid': arguments['id'], "type": "base"});
                },
                child: Stack(children: <Widget>[
                    AspectRatio(
                        aspectRatio: 335 / 400,
                        child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenAdaper.width(10)),
                        ),
                        child: Image.network(
                            image,
                            fit: BoxFit.cover,
                        ),
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
                                ScreenAdaper.height(15)),
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            child: Text(name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true))
                                ),
                        )
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
                ]),
            ),
        );
    }

    void _onRefresh() async {
        setState(() {
            this._page = 1;
        });
        await _getData(isInit: true);
        _refreshController.refreshCompleted();
    }

    void _onLoading() async {
        setState(() {
            this._page++;
        });
        var response = await _getData();
        if (response["data"].length == 0) {
            _refreshController.loadNoData();
        } else {
            _refreshController.loadComplete();
        }
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar('神木列表'),
            body: Padding(
                padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0,
                    ScreenAdaper.width(30), ScreenAdaper.width(30)),
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
                        loadingText: "加载中"),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: this.isLoading
                        ? Container(
                            margin: EdgeInsets.only(top: ScreenAdaper.height(200)),
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.center,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                    Container(
                                        width: ScreenAdaper.width(104),
                                        height: ScreenAdaper.width(144),
                                        child: Image.asset(
                                        "images/loading.gif",
                                        fit: BoxFit.cover,
                                        ),
                                    ),
                                    SizedBox(height: ScreenAdaper.height(50)),
                                    Text("正在努力加载中，请稍后...",
                                        style: TextStyle(
                                            fontSize: ScreenAdaper.fontSize(28),
                                            color: Color(0xFF666666)))
                                    ])))
                        : this.baseList.length <= 0
                            ? NullContent('暂无数据')
                            : Wrap(
                                spacing: ScreenAdaper.width(15),
                                children: this.baseList.map((Data val) {
                                return this
                                    ._itemWidget(val.woodId, val.name, val.image);
                                }).toList()))));
    }
}

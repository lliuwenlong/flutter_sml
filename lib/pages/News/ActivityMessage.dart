import 'package:flutter/material.dart';
import 'package:flutter_sml/services/ScreenAdaper.dart';
import 'ListItem.dart';
import '../../components/AppBarWidget.dart';
import '../../model/store/user/User.dart';
import 'package:provider/provider.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/news/NoticeApiModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivityMessage extends StatefulWidget {
    final Map arguments;
    ActivityMessage({Key key,this.arguments}) : super(key: key);
    _ActivityMessageState createState() => _ActivityMessageState(arguments:this.arguments);
}

class _ActivityMessageState extends State<ActivityMessage> {
    final Map arguments;
    _ActivityMessageState({this.arguments});
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    User userModel;
    bool _isLoading = true;
    HttpUtil http = HttpUtil();
    int _pageNO = 1;
    List<NoticeDataApiModel> noticeList = [];
    @override
    void initState() {
        super.initState();
        this._getData(isInit: true);
    }

    _getData({isInit: false}) async {
        Map response = await http.get("/api/v1/notice/data/notice", data: {
            "pageSize": 20,
            "pageNO": this._pageNO,
            "type": "notice",
        });
        if (response["code"] == 200) {
            final NoticeApiModel articleModel = new NoticeApiModel.fromJson(response["data"]);
            if (isInit) {
                setState(() {
                    noticeList = articleModel.data;
                    this._isLoading = false;
                });
                return response;
            } else {
                setState(() {
                    noticeList.addAll(articleModel.data);
                });
                return response;
            }
        }
        return response;
    }

    void _onLoading() async{
        setState(() {
            this._pageNO++;
        });
        var response = await _getData();
        if (response["data"].length == 0) {
            _refreshController.loadNoData();
        } else {
            _refreshController.loadComplete();
        }
    }

    void _onRefresh() async{
        setState(() {
            this._pageNO = 1;
        });
        final Map res = await _getData(isInit: true);
        _refreshController.refreshCompleted();
        if (_refreshController.footerStatus == LoadStatus.noMore) {
            _refreshController.loadComplete();
        }
    }


    @override
    Widget build(BuildContext context) {
            ScreenAdaper.init(context);
            return Scaffold(
            appBar: AppBarWidget().buildAppBar('${arguments["appTabName"]}'),
            body: !_isLoading
                    ? this.noticeList.isEmpty
                        ? NullContent("暂无数据")
                        : SafeArea(
                            top: false,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xfff7f7f7)
                                ),
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
                                        loadingText: "加载中"
                                    ),
                                    onRefresh: _onRefresh,
                                    onLoading: _onLoading,
                                    child: ListView.builder(
                                        padding: EdgeInsets.fromLTRB(15, 16, 15, 0),
                                        itemCount: this.noticeList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                            return ListItem(
                                                this.noticeList[index].noticeTitle,
                                                this.noticeList[index].createTime,
                                                "/newsDetail", 
                                                "${arguments['appTabName']}",
                                                subtitle: this.noticeList[index].noticeDesc,
                                                data: this.noticeList[index]
                                            );
                                        },
                                    )
                                ),
                            ),
                        )
                    : Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(200)
                        ),
                        child: Loading()
                    )
            );
        }
}
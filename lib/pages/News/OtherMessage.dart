import 'package:flutter/material.dart';
import 'package:flutter_sml/services/ScreenAdaper.dart';
import 'ListItem.dart';
import '../../components/AppBarWidget.dart';
import '../../model/store/user/User.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/news/MsgDataApiModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../../model/store/user/User.dart'; 
class OtherMessage extends StatefulWidget {
    final Map arguments;
    
    OtherMessage({Key key,this.arguments}) : super(key: key);
    _OtherMessageState createState() => _OtherMessageState(arguments:this.arguments);
}

class _OtherMessageState extends State<OtherMessage> {
    final Map arguments;
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    User userModel;
    bool _isLoading = true;
    HttpUtil http = HttpUtil();
    int _pageNO = 1;
    List<MsgDataApiDataList> noticeList = [];
    _OtherMessageState({this.arguments});
    User _userModel;
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        this._getData(isInit: true);
    }

    _getData({isInit: false}) async {
        Map response = await http.get("/api/v1/sys/msg/data/", data: {
            "pageSize": 20,
            "pageNO": this._pageNO,
            "userId": this._userModel.userId
        });
        if (response["code"] == 200) {
            final MsgDataApiModel articleModel = new MsgDataApiModel.fromJson(response);
            if (isInit) {
                setState(() {
                    noticeList = articleModel.data.list;
                    this._isLoading = false;
                });
                return response;
            } else {
                setState(() {
                    noticeList.addAll(articleModel.data.list);
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
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar('${arguments['appTabName']}'),
                preferredSize:  Size.fromHeight(ScreenAdaper.height(110)),
            ),
            body: SafeArea(
                top: false,
                child: !_isLoading
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
                                            this.noticeList[index].content, 
                                            this.noticeList[index].createTime, 
                                            "/newsDetail", 
                                            "${arguments['appTabName']}",
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
            ),
        );
    }
}
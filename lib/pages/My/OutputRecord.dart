import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../components/RecordItem.dart';
import '../../common/HttpUtil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/LoadingSm.dart';
import '../../model/api/my/OutputRecordData.dart';
import '../../services/ScreenAdaper.dart';

class OutputRecord extends StatefulWidget {
  final Map arguments;
  OutputRecord({Key key,this.arguments}) : super(key: key);

  _OutputRecordState createState() => _OutputRecordState(arguments:this.arguments);
}

class _OutputRecordState extends State<OutputRecord> {
  final Map arguments;
  _OutputRecordState({this.arguments});
  final HttpUtil http = HttpUtil();
  List outPutList = [];
  int outPutPage = 1;
  bool isOutPutLoading = true;
  RefreshController _outPutRefreshController = new RefreshController(initialRefresh: false);
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._getData(isInit: true);
  }

  _getData({bool isInit = false}) async {
    if (isInit && isOutPutLoading == false) {
      return null;
    }

    final Map<String, dynamic> response = await this.http.get(
        "/api/v1/user/wood/transfer",
        data: {"pageNO": outPutPage, "pageSize": 10, "woodSn": 1});
      Map<String, dynamic> resItem = {
        "reciever": "string",
        "sender": "string",
        "transferTime": "2019-10-01 12:10:00"
      };

    Map<String, dynamic> resData = {
      "code": 200,
      "data": {
        "currPage": 10,
        "list": [
          resItem,
          resItem,
          resItem,
          resItem,
          resItem,
          resItem,
          resItem,
          resItem,
          resItem,
          resItem,
        ],
        "pageSize": 0,
        "totalCount": 0,
        "totalPage": 0
      },
      "msg": "string"
    };
    if (response["code"] == 200) {
      final res = new OutputRecordDataModel.fromJson(resData);
      if (isInit) {
        setState(() {
          outPutList = res.data.list;
          isOutPutLoading = false;
        });
      } else {
        setState(() {
          outPutList.addAll(res.data.list);
        });
      }
    }
    return response;
  }

  void _onLoading() async {
    setState(() {
      this.outPutPage++;
    });
    var controller = this._outPutRefreshController;
    var response = await _getData();
    if (response["data"].length == 0) {
      controller.loadNoData();
    } else {
      controller.loadComplete();
    }
  }

  void _onRefresh() async {
    setState(() {
      this.outPutPage = 1;
    });
    var controller = this._outPutRefreshController;
    final Map res = await _getData(isInit: true);
    controller.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget().buildAppBar('产值记录'),
        body: SafeArea(
          // bottom: true,
          child:  SmartRefresher(
              controller: _outPutRefreshController,
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
                  child:this.isOutPutLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ): ListView.builder(
                    itemCount: this.outPutList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = this.outPutList[index];
                      return RecordItem('${data.content}','${data.createTime}');
                    },
                  ),
            ),
          ),
        );
  }
}

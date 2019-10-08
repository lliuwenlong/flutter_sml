import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../components/RecordItem.dart';
import '../../common/HttpUtil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/LoadingSm.dart';
import '../../model/api/my/TransferRecordData.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/NullContent.dart';
class TransferRecord extends StatefulWidget {
  final Map arguments;
  TransferRecord({Key key,this.arguments}) : super(key: key);

  _TransferRecordState createState() => _TransferRecordState(arguments:this.arguments);
}

class _TransferRecordState extends State<TransferRecord> {
  final Map arguments;
  _TransferRecordState({this.arguments});
  final HttpUtil http = HttpUtil();
  List transferList = [];
  int transferPage = 1;
  bool isTransferLoading = true;
  RefreshController _transferRefreshController = new RefreshController(initialRefresh: false);
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._getData(isInit: true);
  }

  _getData({bool isInit = false}) async {
    if (isInit && isTransferLoading == false) {
      return null;
    }

    final Map<String, dynamic> response = await this.http.get(
        "/api/v1/user/wood/transfer",
        data: {
          "pageNO": transferPage, 
          "pageSize": 10, 
          "woodSn": arguments['woodSn']
        });
    if (response["code"] == 200) {
      final res = new TransferRecordDataModel.fromJson(response);
      if (isInit) {
        setState(() {
          transferList = res.data.list;
          isTransferLoading = false;
        });
      } else {
        setState(() {
          transferList.addAll(res.data.list);
        });
      }
    }
    return response;
  }

  void _onLoading() async {
    setState(() {
      this.transferPage++;
    });
    var controller = this._transferRefreshController;
    var response = await _getData();
    if (response["data"].length == 0) {
      controller.loadNoData();
    } else {
      controller.loadComplete();
    }
  }

  void _onRefresh() async {
    setState(() {
      this.transferPage = 1;
    });
    var controller = this._transferRefreshController;
    final Map res = await _getData(isInit: true);
    controller.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget().buildAppBar('转让记录'),
        body: SafeArea(
          // bottom: true,
          child:  SmartRefresher(
              controller: _transferRefreshController,
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
                  child:this.isTransferLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ): this.transferList.length <= 0 ? NullContent('暂无数据'):
							ListView.builder(
                    itemCount: this.transferList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = this.transferList[index];
                      return RecordItem('${data.reciever}',
                          '红豆杉持有人由 ${data.sender} 更改为 ${data.reciever}',
                          date: '${data.transferTime}');
                    },
                  ),
            ),
          ),
        );
  }
}

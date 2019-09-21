import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/AppBarWidget.dart';
import '../../components/RecordItem.dart';
import '../../common/HttpUtil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/LoadingSm.dart';
import '../../model/api/my/PurchaseRecordData.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/NullContent.dart';
import '../../model/store/user/User.dart';
class PurchaseRecord extends StatefulWidget {
  final Map arguments;
  PurchaseRecord({Key key,this.arguments}) : super(key: key);

  _PurchaseRecordState createState() => _PurchaseRecordState(arguments:this.arguments);
}

class _PurchaseRecordState extends State<PurchaseRecord> {
  final Map arguments;
  _PurchaseRecordState({this.arguments});
  final HttpUtil http = HttpUtil();
  List purchaseList = [];
  int purchasePage = 1;
  bool isPurchaseLoading = true;
  User _userModel;
  RefreshController _purchaseController = new RefreshController(initialRefresh: false);
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<User>(context);
    this._getData(isInit: true);
  }

  _getData({bool isInit = false}) async {
    if (isInit && isPurchaseLoading == false) {
      return null;
    }

    final Map<String, dynamic> response = await this.http.get(
        "/api/v1/record/wood/",
        data: {
            "pageNO": purchasePage, 
            "pageSize": 10, 
            "userId":this._userModel.userId
        });
    if (response["code"] == 200) {
      final res = new PurchaseRecordDataModel.fromJson(response);
      if (isInit) {
        setState(() {
          purchaseList = res.data.list;
          isPurchaseLoading = false;
        });
      } else {
        setState(() {
          purchaseList.addAll(res.data.list);
        });
      }
    }
    return response;
  }

  void _onLoading() async {
    setState(() {
      this.purchasePage++;
    });
    var controller = this._purchaseController;
    var response = await _getData();
    if (response["data"].length == 0) {
      controller.loadNoData();
    } else {
      controller.loadComplete();
    }
  }

  void _onRefresh() async {
    setState(() {
      this.purchasePage = 1;
    });
    var controller = this._purchaseController;
    final Map res = await _getData(isInit: true);
    controller.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget().buildAppBar('购买记录'),
        body: SafeArea(
          // bottom: true,
          child:  SmartRefresher(
              controller: _purchaseController,
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
					child:this.isPurchaseLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ): this.purchaseList.length <= 0 ? NullContent('暂无数据'):
							ListView.builder(
                    itemCount: this.purchaseList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = this.purchaseList[index];
                      return RecordItem('${data.content}','${data.createTime}');
                    },
                  ),
            ),
          ),
        );
  }
}

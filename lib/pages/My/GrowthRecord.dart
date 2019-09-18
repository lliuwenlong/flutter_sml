import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/RecordItem.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
import '../../model/api/my/GrowthRecordData.dart';
class GrowthRecord extends StatefulWidget {
  final Map arguments;
  GrowthRecord({Key key,this.arguments}) : super(key: key);

  _GrowthRecordState createState() => _GrowthRecordState(arguments:this.arguments);
}

class _GrowthRecordState extends State<GrowthRecord> {
  final Map arguments;
  List growthList = [];
  final HttpUtil http = HttpUtil();
  int growthPage = 1;
  bool isGrowthLoading = true;
  RefreshController _growthRefreshController = new RefreshController(initialRefresh: false);
  _GrowthRecordState({this.arguments});
void didChangeDependencies() {
    super.didChangeDependencies();
    this._getData(isInit: true);
  }

  _getData({bool isInit = false}) async {
    if (isInit && isGrowthLoading == false) {
      return null;
    }

    final Map<String, dynamic> response = await this.http.get(
        "/api/v1/user/wood/grow",
        data: {"pageNO": growthPage, "pageSize": 10, "woodSn": 1});
      Map<String, dynamic> resItem = {
        "content": "string",
        "createTime": "2019-10-01 12:10:00"
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
      final res = new GrowthRecordDataModel.fromJson(resData);
      if (isInit) {
        setState(() {
          growthList = res.data.list;
          isGrowthLoading = false;
        });
      } else {
        setState(() {
          growthList.addAll(res.data.list);
        });
      }
    }
    return response;
  }

  void _onLoading() async {
    setState(() {
      this.growthPage++;
    });
    print(this.growthPage);
    var controller = this._growthRefreshController;
    var response = await _getData();
    if (response["data"].length == 0) {
      controller.loadNoData();
    } else {
      controller.loadComplete();
    }
  }

  void _onRefresh() async {
    setState(() {
      this.growthPage = 1;
    });
    var controller = this._growthRefreshController;
    final Map res = await _getData(isInit: true);
    controller.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('成长记录'),
      body: SafeArea(
        child: Container(
          child: SmartRefresher(
            
            controller: _growthRefreshController,
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
                  child:this.isGrowthLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ): ListView.builder(
                    itemCount: this.growthList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = this.growthList[index];
                      return RecordItem('${data.content}','${data.createTime}');
                    },
                  ),
            )
          ),
        ),
      
    );
  }
}
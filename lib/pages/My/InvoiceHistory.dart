import 'package:flutter/material.dart';
import 'package:flutter_sml/pages/My/MyDynamics.dart';
import 'package:provider/provider.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/store/user/User.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/my/InvoiceHistoryData.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';

class InvoiceHistory extends StatefulWidget {
  InvoiceHistory({Key key}) : super(key: key);

  _InvoiceHistoryState createState() => _InvoiceHistoryState();
}

class _InvoiceHistoryState extends State<InvoiceHistory> {
  final HttpUtil http = HttpUtil();
  User _userModel;
  int _invoicePage = 1;
  List invoiceList = [];
  bool isInvoiceLoading = true;
  RefreshController _invoiceController =
      new RefreshController(initialRefresh: false);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<User>(context);

    this._getData(isInit: true);
  }

  _getData({isInit: false}) async {
    if (isInit && this.isInvoiceLoading == false) {
      return null;
    }

    final Map<String, dynamic> response = await this.http.get('/receipt/1/data',
        data: {"pageNO": this._invoicePage, "pageSize": 10, "userId": this._userModel.userId});

    if (response['code'] == 200) {
      InvoiceHistoryDataModel res =
          new InvoiceHistoryDataModel.fromJson(response);
      if (isInit) {
        setState(() {
          this.invoiceList = res.data.list;
          this.isInvoiceLoading = false;
        });
      } else {
        setState(() {
          this.invoiceList.addAll(res.data.list);
        });
      }
    }

    return response;
  }

  void _onLoading() async {
    setState(() {
      this._invoicePage++;
    });
    var controller = this._invoiceController;
    var response = await _getData();
    if (response["data"].length == 0) {
      controller.loadNoData();
    } else {
      controller.loadComplete();
    }
  }

  void _onRefresh() async {
    setState(() {
      this._invoicePage = 1;
    });
    var controller = this._invoiceController;
    final Map res = await _getData(isInit: true);
    controller.refreshCompleted();
  }

  Widget _itemRow(var data, {bool isBorder = true}) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
        child: Container(
            padding: EdgeInsets.only(
                top: ScreenAdaper.width(30), bottom: ScreenAdaper.width(30)),
            decoration: BoxDecoration(
                border: Border(
                    bottom: isBorder
                        ? BorderSide(color: ColorClass.borderColor, width: 1)
                        : BorderSide.none)),
            child: Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(data.createTime,
                        style: TextStyle(
                            color: ColorClass.fontColor,
                            fontSize: ScreenAdaper.fontSize(24))),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(data.status,
                                style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24))),
                            SizedBox(width: ScreenAdaper.width(10)),
                            Icon(IconData(0xe61e, fontFamily: "iconfont"),
                                color: ColorClass.iconColor,
                                size: ScreenAdaper.fontSize(24))
                          ],
                        ))
                  ]),
              SizedBox(height: ScreenAdaper.height(18)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(data.content,
                        style: TextStyle(
                            fontSize: ScreenAdaper.fontSize(28),
                            color: ColorClass.titleColor)),
                    Text("¥ ${data.amount}",
                        style: TextStyle(
                            fontSize: ScreenAdaper.fontSize(24),
                            color: ColorClass.fontRed))
                  ])
            ])));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
        appBar: AppBarWidget().buildAppBar("开票历史"),
        body: Container(
          child: SmartRefresher(
              controller: _invoiceController,
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
              child: this.isInvoiceLoading
                  ? Container(
                      margin: EdgeInsets.only(top: ScreenAdaper.height(200)),
                      child: Loading(),
                    )
                  : this.invoiceList.length <= 0
                      ? NullContent('暂无数据')
                      : ListView.builder(
                          itemCount: this.invoiceList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = this.invoiceList[index];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/invoiceHistoryDetails",
                                      arguments: {"receiptId": data.receiptId});
                                },
                                child:
                                    this._itemRow(data, isBorder: index != 1));
                          })),
        ));
  }
}

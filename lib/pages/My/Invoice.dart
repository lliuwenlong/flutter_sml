import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/api/my/InvoiceData.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
import '../../model/store/invoice/InvoiceInfo.dart';
class Invoice extends StatefulWidget {
  Invoice({Key key}) : super(key: key);

  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final HttpUtil http = HttpUtil();
  bool _isInvoiceLoading = true;
  int _invoicePage = 1;
  String _orderSn;
  User _userModel;
  InvoiceInfo _invoiceModel;
  List invoiceList = [];
  RefreshController _invoiceController = new RefreshController(initialRefresh: false);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<User>(context);
    _invoiceModel = Provider.of<InvoiceInfo>(context);
    this._getData(isInit: true);
  }
  _getData({ isInit = false}) async {
    if(isInit&&this._isInvoiceLoading==false){
        return null;
    }
    Map response = await this.http.get('/receipt/0/data',data: {
      "pageNO": this._invoicePage,
      "pageSize": 10,
      "userId": this._userModel.userId
    });
    if(response['code'] == 200){
        InvoiceDataModel  res = new InvoiceDataModel.fromJson(response);
        if(isInit){
            setState(() {
              this.invoiceList = res.data.list;
              this._isInvoiceLoading = false;
            });
        }else{
            setState(() {
                this.invoiceList.addAll(res.data.list);
            });
        }
    }
    return response;
  }

  void _onLoading() async{
        setState(() {
            _invoicePage++;
        });
        var controller = this._invoiceController;
        var response = await _getData();
        if (response["data"].length == 0) {
            controller.loadNoData();
        } else {
            controller.loadComplete();
        }
    }

  void _onRefresh() async{
        setState(() {
            this._invoicePage = 1;
        });
        var controller = this._invoiceController;
        final Map res = await _getData(isInit: true);
        controller.refreshCompleted();
    }

  Widget _item (var data,{bool isBorder = true}) {
        return GestureDetector(
          onTap: (){
            setState(() {
                this._orderSn = data.orderSn;
                this._invoiceModel.initInvoiceInfo(
                  orderSn:data.orderSn,
                  amount: data.amount
                );
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0
            ),
            color: Colors.white,
            child: Container(
                padding: EdgeInsets.fromLTRB(
                    0, ScreenAdaper.width(30), 0, ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: isBorder ? BorderSide(
                            color: ColorClass.borderColor,
                            width: ScreenAdaper.height(1)
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    children: <Widget>[
                            Container(
                                
                                  child:_orderSn==data.orderSn? CircleAvatar(
                                    backgroundColor: Color(0xffd4746c),
                                    radius: ScreenAdaper.width(20),
                                    child: Icon(
                                      IconData(0xe643, fontFamily: 'iconfont'),
                                      size: ScreenAdaper.fontSize(20),
                                      color: Color(0xffffffff),
                                    ),
                                  )
                                : CircleAvatar(
                                  backgroundColor:Colors.white,
                                    radius: ScreenAdaper.width(20),
                                    child: Container(
                                        width: ScreenAdaper.width(40),
                                        height: ScreenAdaper.height(40),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff7f7f7),
                                            border: Border.all(
                                                color: Color(0xff999999),
                                                width: ScreenAdaper.width(1)
                                              ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                
                            ),
                            SizedBox(width: ScreenAdaper.width(20)),
                            Expanded(
                                flex: 1,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(data.name, style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                        )),
                                        Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    Text("下单时间：${data.createTime}", style: TextStyle(
                                                        color: ColorClass.fontColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )),
                                                    Text("¥${data.amount}", style: TextStyle(
                                                        color: ColorClass.fontRed,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    ))
                                                ]
                                        )
                                    ]
                                )
                            )
                            
                    ]
                )
            )
        ),
        );
    }
  @override
  Widget build(BuildContext context) {
     ScreenAdaper.init(context);
        return Scaffold(
            appBar: PreferredSize(
              child: AppBar(
                title: Text("我的发票", style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenAdaper.fontSize(34)
                )),
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light,
                actions: [
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/invoiceHistory");
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: ScreenAdaper.width(30)),
                            alignment: Alignment.center,
                            child: Text("开票历史", style: TextStyle(
                                color: ColorClass.fontColor,
                                fontSize: ScreenAdaper.fontSize(30)
                            ), textAlign: TextAlign.center)
                        )
                    )
                ]
            ),
            preferredSize: Size.fromHeight(ScreenAdaper.height(88))
            ),
            body:SmartRefresher(
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
              child: this._isInvoiceLoading?
                  Container(
                      margin: EdgeInsets.only(top: ScreenAdaper.height(200)),
                      child: Loading(),
                    )
                  : this.invoiceList.length <= 0
                      ? NullContent('暂无数据'): ListView(
                children: <Widget>[
                   ...this.invoiceList.map((val){
                      return this._item(val);
                   }),
                    Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(50)
                        ),
                        height: ScreenAdaper.height(88),
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)
                        ),
                        child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                            ),
                            onPressed: () {
                                if(_orderSn==null||_orderSn==''){
                                    Fluttertoast.showToast(
                                      msg: '请选择一项',
                                      toastLength: Toast.LENGTH_SHORT,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.black87,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIos:1,
                                      fontSize: ScreenAdaper.fontSize(30)
                                    );
                                    return;
                                }
                                Navigator.pushNamed(context, "/invoiceInformation");
                            },
                            child: Text("下一步", style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdaper.fontSize(40)
                            )),
                            color: ColorClass.common,
                        ),
                    )
                ]
            ),
            )
        );
    
  }
}
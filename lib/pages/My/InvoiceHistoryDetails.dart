import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
class InvoiceHistoryDetails extends StatefulWidget {
  final arguments;
  InvoiceHistoryDetails({Key key,this.arguments}) : super(key: key);

  _InvoiceHistoryDetailsState createState() => _InvoiceHistoryDetailsState(arguments:this.arguments);
}

class _InvoiceHistoryDetailsState extends State<InvoiceHistoryDetails> {
  final arguments;
  _InvoiceHistoryDetailsState({this.arguments});
  final HttpUtil http = HttpUtil();
  var invoiceData;
  bool _isInvoiceLoading = true;
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _getData();
}
_getData() async {
  Map  response = await this.http.get('/receipt/1/his/${arguments['receiptId']}');
  	if(response['code'] == 200){
		setState(() {
			this.invoiceData = response['data'];
			this._isInvoiceLoading = false;
		});
  	}else{
		Fluttertoast.showToast(
		msg: response['msg'],
		toastLength: Toast.LENGTH_SHORT,
		timeInSecForIos:1,
		fontSize:ScreenAdaper.fontSize(30),
		gravity:ToastGravity.CENTER,
		backgroundColor:Colors.black87,
		textColor:Colors.white,
		);
  }
} 
   Widget _itemRow (String name, String content, Color contentColor) {
        return Row(
            children: <Widget>[
                Container(
                    width: ScreenAdaper.width(195),
                    child: Text(name, style: TextStyle(
                        color: ColorClass.titleColor,
                        fontSize: ScreenAdaper.fontSize(24)
                    )),
                ),
                Text(content      , style: TextStyle(
                    color: contentColor,
                    fontSize: ScreenAdaper.fontSize(24)
                ))
            ],
        );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBarWidget().buildAppBar("开票详情"),
            body:this._isInvoiceLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ) : Column(
                children: <Widget>[
                    Container(
                        height: ScreenAdaper.height(350),
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)
                        ),
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                Container(
                                    child: Text("发票详情", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(28),
                                        fontWeight: FontWeight.w500
                                    )),
                                ),
                                this._itemRow("发票抬头", invoiceData['header'], ColorClass.fontColor),
                                this._itemRow("税号", invoiceData['code'], ColorClass.fontColor),
                                this._itemRow("发票内容",invoiceData['content'], ColorClass.fontColor),
                                this._itemRow("发票金额", "¥${invoiceData['amount']}", ColorClass.fontRed),
                                this._itemRow("申请时间", invoiceData['applyTime'], ColorClass.fontColor),
                            ],
                        ),
                    ),
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, '/invoiceSee',arguments: {
                              "rid":arguments['receiptId']
                            });
                        },
                        child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: ScreenAdaper.width(30),
                                right: ScreenAdaper.width(30)
                            ),
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(20)
                            ),
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: ScreenAdaper.width(30),
                                    bottom: ScreenAdaper.width(30)
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Text("${invoiceData['num']}张发票，含${invoiceData['orderNum']}个订单", style: TextStyle(
                                            color: ColorClass.titleColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        )),
                                        Row(
                                            children: <Widget>[
                                                Text("查看", style: TextStyle(
                                                    color: ColorClass.fontColor,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                )),
                                                SizedBox(width: ScreenAdaper.width(20)),
                                                Icon(
                                                    IconData(0xe61e, fontFamily: "iconfont"),
                                                    color: ColorClass.iconColor,
                                                    size: ScreenAdaper.fontSize(24),
                                                )
                                            ]
                                        )
                                    ]
                                )
                            ),
                        ),
                    )
                ]
            )
        );
  }
}




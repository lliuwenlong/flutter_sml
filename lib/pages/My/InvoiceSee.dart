import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
class InvoiceSee extends StatefulWidget {
  final arguments;
  InvoiceSee({Key key,this.arguments}) : super(key: key);

  _InvoiceSeeState createState() => _InvoiceSeeState(arguments:arguments);
}

class _InvoiceSeeState extends State<InvoiceSee> {
  final arguments;
  _InvoiceSeeState({this.arguments});
  final HttpUtil http = HttpUtil();
  List dataList = [];
  bool isLoading = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._getData();
  }
  	_getData () async {
		Map response = await this.http.get('/receipt/1/his/${arguments['rid']}/orders');
		if(response['code'] == 200){
			setState(() {
			  this.dataList = response['data'];
			  this.isLoading = false;
			});
		}
  	}
  Widget _itemRow (var data,{bool isBorder = true}) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            child: Container(
                padding: EdgeInsets.only(
                    top: ScreenAdaper.width(30),
                    bottom: ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: isBorder
                            ? BorderSide(color: ColorClass.borderColor, width: 1)
                            : BorderSide.none
                    )
                ),
                child:isLoading ? 
					Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(200)
                        ),
                        child: Loading(),
                    ) : Column(
                    children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                Text(data['createTime'], style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                ))
                            ]
                        ),
                        SizedBox(height: ScreenAdaper.height(18)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text(data['name'], style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(28),
                                    color: ColorClass.titleColor
                                )),
                                Text("¥${data['amount']}", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(24),
                                    color: ColorClass.fontRed
                                ))
                            ]
                        )
                    ]
                )
            )
        );
    }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("查看"),
            body: ListView.builder(
				itemCount: this.dataList.length,
				itemBuilder: (BuildContext context,int index){
					var data = this.dataList[index];
					return this._itemRow(data,isBorder: index==this.dataList.length-1?false:true);
				},
			)
        );
  }
}
import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class InvoiceDetails extends StatelessWidget {
  final arguments;
  const InvoiceDetails({Key key,this.arguments}) : super(key: key);


    Widget _rowItem (String name, String subName, {bool isBorder = true}) {
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
                        bottom: isBorder ? BorderSide(
                            color: ColorClass.borderColor,
                            width: ScreenAdaper.width(1)
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Text(name, style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(28)
                        )),
                        Text(subName, style: TextStyle(
                            color: ColorClass.fontColor,
                            fontSize: ScreenAdaper.fontSize(24)
                        ))
                    ]
                )
            )
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("发票详情"),
            body: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(80)
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                                Text(arguments['amount'], style: TextStyle(
                                    color: ColorClass.fontRed,
                                    fontSize: ScreenAdaper.fontSize(40),
                                    fontWeight: FontWeight.w500
                                )),
                                Text("元", style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                ))
                            ]
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(10)
                        ),
                        child: Text("发票总金额", style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(24)
                        ))
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(30),
                            left: ScreenAdaper.width(30)
                        ),
                        child: Text("发票总数1张", style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(28)
                        ))
                    ),
                    SizedBox(height: ScreenAdaper.height(30)),
                    this._rowItem("发票内容", '购树服务费'),
                    this._rowItem("开票方", '贵州绿建实业有限公司'),
                    this._rowItem("发票总额", "${arguments['amount']}元", isBorder: false)
                ]
            )
        );
    }
}
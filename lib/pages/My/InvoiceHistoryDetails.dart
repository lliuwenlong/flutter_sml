import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class InvoiceHistoryDetails extends StatelessWidget {
    const InvoiceHistoryDetails({Key key}) : super(key: key);

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
            body: Column(
                children: <Widget>[
                    Container(
                        height: ScreenAdaper.height(350),
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)
                        ),
                        child: Column(
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
                                this._itemRow("发票抬头", "发票抬头", ColorClass.fontColor),
                                this._itemRow("税号", "6845145578121221MM", ColorClass.fontColor),
                                this._itemRow("发票内容", "购树服务费", ColorClass.fontColor),
                                this._itemRow("发票金额", "¥1000.00", ColorClass.fontRed),
                                this._itemRow("申请时间", "2019-05-06  12:25", ColorClass.fontColor),
                            ],
                        ),
                    ),
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, '/invoiceSee');
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
                                        Text("1张发票，含一个订单", style: TextStyle(
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
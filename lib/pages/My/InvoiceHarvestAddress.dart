import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class InvoiceHarvestAddress extends StatelessWidget {
    InvoiceHarvestAddress({Key key}) : super(key: key);

    Widget _rowItem(String name, String hintText, {int maxLines = 1, bool isBorder = true}) {
        return Container(
            alignment: Alignment.topLeft,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                0,
                ScreenAdaper.width(30),
                0
            ),
            child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(30),
                    0,
                    ScreenAdaper.width(30)
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(177),
                            child: Text(name, style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(28)
                            ))
                        ),
                        Expanded(
                            flex: 1,
                            child: TextField(
                                maxLines: maxLines,
                                decoration: InputDecoration(
                                    hintText: hintText,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 1),
                                    hintStyle: TextStyle(
                                        color: ColorClass.iconColor,
                                        fontSize: ScreenAdaper.fontSize(24),
                                    ),
                                    border: InputBorder.none,
                                ),
                            )
                        )
                    ]
                )
            )
        );
    }

    Widget _rowItemII(String name, String hintText) {
        return Container(
            alignment: Alignment.topLeft,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                0,
                ScreenAdaper.width(30),
                0
            ),
            child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(30),
                    0,
                    ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: ColorClass.borderColor,
                            width: ScreenAdaper.width(1)
                        )
                    )
                ),
                child: Row(
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(177),
                            child: Text(name, style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(28)
                            ))
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    Text(hintText, style: TextStyle(
                                        color: ColorClass.iconColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    )),
                                    Icon(IconData(
                                        0xe61e,
                                        fontFamily: "iconfont"
                                    ), size: ScreenAdaper.fontSize(24), color: ColorClass.iconColor)
                                ]
                            )
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
            appBar: AppBarWidget().buildAppBar("发票收货地址"),
            body: Column(
                children: <Widget>[
                    this._rowItem("收货人", "请输入收货人姓名"),
                    this._rowItem("电话", "收货人的电话，方便联系"),
                    this._rowItemII("地址", "请选择地址"),
                    this._rowItem("详细地址", "请输入街道、门牌号等详细信息", maxLines: 3, isBorder: false),
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
                            },
                            child: Text("提交", style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdaper.fontSize(40)
                            )),
                            color: ColorClass.common,
                        ),
                    )
                ]
            )
        );
    }
}
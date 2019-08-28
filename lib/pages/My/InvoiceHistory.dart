import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class InvoiceHistory extends StatelessWidget {
    const InvoiceHistory({Key key}) : super(key: key);
    Widget _itemRow ({bool isBorder = true}) {
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
                child: Column(
                    children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("2019-08-05  12:05", style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                )),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                            Text("已开发票", style: TextStyle(
                                                color: ColorClass.fontColor,
                                                fontSize: ScreenAdaper.fontSize(24)
                                            )),
                                            SizedBox(width: ScreenAdaper.width(10)),
                                            Icon(IconData(
                                                0xe61e,
                                                fontFamily: "iconfont"
                                            ), color: ColorClass.iconColor, size: ScreenAdaper.fontSize(24))
                                        ],
                                    )
                                )
                            ]
                        ),
                        SizedBox(height: ScreenAdaper.height(18)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("购买一颗生态园林的金丝楠木", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(28),
                                    color: ColorClass.titleColor
                                )),
                                Text("¥1000.00", style: TextStyle(
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
            appBar: AppBarWidget().buildAppBar("开票历史"),
            body: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/invoiceHistoryDetails");
                        },
                        child: this._itemRow(isBorder: index != 1)
                    );
                },
                itemCount: 2,
            ),
        );
    }
}
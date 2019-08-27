import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class Invoice extends StatelessWidget {
  const Invoice({Key key}) : super(key: key);

    Widget _item ({bool isBorder = true}) {
        return Container(
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
                            width: 1
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    children: <Widget>[
                            Container(
                                width: ScreenAdaper.width(40),
                                height: ScreenAdaper.width(40),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0XFF999999),
                                        width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(150),
                                    color: Color(0xFFf7f7f7)
                                ),
                            ),
                            SizedBox(width: ScreenAdaper.width(20)),
                            Expanded(
                                flex: 1,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text("购买一颗生态园林的金丝楠木", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                        )),
                                        Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    Text("下单时间：2019-08-05  12:05", style: TextStyle(
                                                        color: ColorClass.fontColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )),
                                                    Text("¥188.00", style: TextStyle(
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
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("我的发票"),
            body: ListView(
                children: <Widget>[
                    this._item(),
                    this._item(),
                    this._item(isBorder: false),
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
            )
        );
    }
}
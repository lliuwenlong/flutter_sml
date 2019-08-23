import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
class ContactCustomerService extends StatelessWidget {
    ContactCustomerService({Key key}) : super(key: key);
    Widget _business (String name, String subTitle, {bool isBorder = true, Color subColor}) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            child: Container(
                padding: EdgeInsets.only(
                    top: ScreenAdaper.height(30),
                    bottom: ScreenAdaper.height(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: isBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: ScreenAdaper.width(1)
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Text(name, style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(28)
                        )),
                        SizedBox(width: ScreenAdaper.width(100)),
                        Expanded(
                            flex: 1,
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(subTitle, style: TextStyle(
                                    color: subColor == null ? ColorClass.fontColor : subColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                ), textAlign: TextAlign.end),
                            ),
                        )

                    ],
                )
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("联系客服"),
            body: Column(
                children: <Widget>[
                    this._business("客服热线", "400-000-0000", subColor: ColorClass.common),
                    this._business("官网地址", "www.shenmulin.com"),
                    this._business("公司地址", "贵州省黔西南布依族苗族自治州兴义市", isBorder: false)
                ]
            ),
        );
    }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_sml/common/Color.dart';
import 'package:flutter_sml/common/Config.dart';
import 'package:flutter_sml/components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
class ServiceHtml extends StatelessWidget {
    int id;
    int type;
    ServiceHtml(this.id, this.type);
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar(this.type == 4 ? "神木娱乐" : "服务详情"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(110))
            ),
            bottomSheet: this.type == 4 ? Container(
                width: double.infinity,
                height: ScreenAdaper.height(110) + MediaQueryData.fromWindow(window).padding.bottom,
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 1)
                    ]
                ),
                child: Row(
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(270),
                            height: ScreenAdaper.height(110),
                            alignment: Alignment.center,
                            child: Text.rich(TextSpan(
                                children: [
                                    TextSpan(text: "¥", style: TextStyle(
                                        color: ColorClass.fontRed,
                                        fontSize: ScreenAdaper.fontSize(26)
                                    )),
                                    TextSpan(text: "189", style: TextStyle(
                                        color: ColorClass.fontRed,
                                        fontSize: ScreenAdaper.fontSize(44)
                                    )),
                                ]
                            )),
                        ),
                        Expanded(
                            child: Container(
                                height: ScreenAdaper.height(110),
                                child: RaisedButton(
                                    elevation: 0,
                                    color: ColorClass.common,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero
                                    ),
                                    onPressed: () {},
                                    child: Text("购买", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenAdaper.fontSize(40)
                                    )),
                                ),
                            ),
                        )
                    ]
                ),
            ) : null,
            body: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)
                ),
                child: InAppWebView(
                    initialUrl: "${Config.WEB_URL}/app/#/serviceHtml?id=${id}",
                ),
            )
        );
    }
}
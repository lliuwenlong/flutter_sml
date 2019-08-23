import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
class Authentication extends StatelessWidget {
    Authentication({Key key}) : super(key: key);

    Widget _inputText (String labelName, String hintText) {
        return Container(
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            height: ScreenAdaper.height(86),
            color: Colors.white,
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: ColorClass.borderColor,
                            width: 1
                        )
                    )
                ),
                child: Row(
                    children: <Widget>[
                        Text(labelName, style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(28)
                        )),
                        Expanded(
                            flex: 1,
                            child: TextField(
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: hintText,
                                    hintStyle: TextStyle(
                                        color: Color(0XFFaaaaaa),
                                        fontSize: ScreenAdaper.fontSize(24)
                                    )
                                )
                            )
                        )
                    ]
                )
            )
        );
    }

    Widget _uploadImage (String labelName, {bool isBordor = true}) {
        return Container(
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            height: ScreenAdaper.height(86),
            color: Colors.white,
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: isBordor ? BorderSide(
                            color: ColorClass.borderColor,
                            width: 1
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Text(labelName, style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(28)
                        )),
                        Icon(IconData(
                            0Xe63d,
                            fontFamily: "iconfont"
                        ), color: ColorClass.iconColor, size: ScreenAdaper.fontSize(34))
                    ]
                )
            )
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("实名认证"),
            body: Container(
                child: Column(
                    children: <Widget>[
                        this._inputText("真实姓名", "请输入姓名"),
                        this._inputText("身份证号", "请输入身份证号"),
                        this._uploadImage("身份证正面"),
                        this._uploadImage("身份证反面", isBordor: false),
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
                                onPressed: () {},
                                child: Text("提交", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdaper.fontSize(40)
                                )),
                                color: ColorClass.common,
                            ),
                        )
                    ]
                )
            )
        );
    }
}
import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Input.dart';

class RetrieveAccount extends StatelessWidget {
    RetrieveAccount({Key key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            child: Scaffold(
                appBar: AppBar(
                    title: Text("忘记密码", style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenAdaper.fontSize(34)
                    )),
                    iconTheme: IconThemeData(color: Colors.black),
                    centerTitle: true,
                    elevation: 0,
                    brightness: Brightness.light,
                    backgroundColor: Colors.white
                ),
                resizeToAvoidBottomPadding: false,
                body: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "images/register.png",
                            ),
                            fit: BoxFit.cover,
                        )
                    ),
                    child: SafeArea(
                        child: Column(
                            children: <Widget>[
                                Container(  
                                    margin: EdgeInsets.only(
                                        top: ScreenAdaper.height(80)
                                    ),
                                    width: ScreenAdaper.width(246),
                                    height: ScreenAdaper.height(302),
                                    child: Image.asset(
                                        "images/logo.png",
                                        fit: BoxFit.contain,
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenAdaper.width(85),
                                        ScreenAdaper.height(78),
                                        ScreenAdaper.width(85),
                                        0
                                    ),
                                    child: Column(
                                        children: <Widget>[
                                            Input(
                                                "请输入手机号",
                                                isShowSuffixIcon: true
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(
                                                        width: 1,
                                                        color: Color(0XFFd9d9d9)
                                                    ))
                                                ),
                                                child: Row(
                                                    children: <Widget>[
                                                        Expanded(
                                                            flex: 1,
                                                            child: Input(
                                                                "请输入验证码",
                                                                isShowSuffixIcon: true,
                                                                showBorder: false
                                                            )
                                                        ),
                                                        Container(
                                                            width: ScreenAdaper.width(171),
                                                            height: ScreenAdaper.width(50),
                                                            alignment: Alignment.centerRight,
                                                            decoration: BoxDecoration(
                                                                border: Border(left: BorderSide(
                                                                    width: 1,
                                                                    color: Color(0XFFd9d9d9)
                                                                ))
                                                            ),
                                                            child: Text("获取验证码", style: TextStyle(
                                                                color: ColorClass.common,
                                                                fontSize: ScreenAdaper.fontSize(30)
                                                            )),
                                                        )
                                                    ],
                                                )
                                            ),
                                            Input(
                                                "请输入密码",
                                                isPwd: true,
                                                isShowSuffixIcon: true
                                            ),
                                            Input(
                                                "请再次确认新密码",
                                                isPwd: true,
                                                isShowSuffixIcon: true
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenAdaper.height(20)
                                                ),
                                                width: double.infinity,
                                                height: ScreenAdaper.height(88),
                                                decoration: BoxDecoration(
                                                            border: Border(bottom: BorderSide(
                                                                width: 1,
                                                                color: Color(0XFFd9d9d9)
                                                            ))
                                                        ),
                                                child: RaisedButton(
                                                    disabledColor: Color(0XFF86d4ca),
                                                    onPressed: null,
                                                    child: Text("确定", style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: ScreenAdaper.fontSize(40)
                                                    )),
                                                    splashColor: Color.fromARGB(0, 0, 0, 0),
                                                    color: ColorClass.common,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    elevation: 0,
                                                )
                                            )
                                        ]
                                    )
                                )
                            ]
                        ),
                    ),
                ),
            ),
        );
    }
}
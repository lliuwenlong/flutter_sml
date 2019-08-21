import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Input.dart';

class LoginPage extends StatelessWidget {
    const LoginPage({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            child: Scaffold(
                resizeToAvoidBottomPadding: false,
                body: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "images/loginbg.png",
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
                                        0,
                                        ScreenAdaper.width(85),
                                        0
                                    ),
                                    child: Column(
                                        children: <Widget>[
                                            Input("请输入手机号", isShowSuffixIcon: true),
                                            Input("请输入密码", isPwd: true, isShowSuffixIcon: true),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenAdaper.height(20)
                                                ),
                                                width: double.infinity,
                                                height: ScreenAdaper.height(88),
                                                child: RaisedButton(
                                                    onPressed: () {},
                                                    child: Text("登录", style: TextStyle(
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
                                            ),
                                            SizedBox(height: ScreenAdaper.height(50)),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    GestureDetector(
                                                        onTap: () => {
                                                            Navigator.pushNamed(context, "/retrieveAccount")
                                                        },
                                                        child: Text("忘记密码？", style: TextStyle(
                                                            color: ColorClass.common,
                                                            fontSize: ScreenAdaper.fontSize(24)
                                                        )),
                                                    ),
                                                    Row(
                                                        children: <Widget>[
                                                            Text("还没有账号，",  style: TextStyle(
                                                                color: ColorClass.fontColor,
                                                                fontSize: ScreenAdaper.fontSize(24)
                                                            )),
                                                            GestureDetector(
                                                                onTap: () => {
                                                                    Navigator.pushNamed(context, "/register")
                                                                },
                                                                child: Text("点击注册", style: TextStyle(
                                                                    color: ColorClass.common,
                                                                    fontSize: ScreenAdaper.fontSize(24)
                                                                )),
                                                            ),
                                                            
                                                        ]
                                                    )
                                                ]
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
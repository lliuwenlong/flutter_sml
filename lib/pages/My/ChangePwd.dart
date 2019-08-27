import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Input.dart';
import '../../components/AppBarWidget.dart';
class ChangePwd extends StatefulWidget {
  ChangePwd({Key key}) : super(key: key);

  _ChangePwdState createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('修改密码'),
      body: Container(
          color: Colors.white,
          // padding: EdgeInsets.only(left:ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
          child: ListView(
            children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: ScreenAdaper.width(110),right: ScreenAdaper.width(110),top: ScreenAdaper.height(40),bottom: ScreenAdaper.height(40)),
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  alignment:Alignment.center,
                  child: Text(
                    '为了您的账户安全，本次操作需要短信确认验证码将发送至139****8802',
                    style: TextStyle(
                      fontSize:ScreenAdaper.fontSize(28, allowFontScaling: true),
                      color: Color(0XFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Color(0XFFd9d9d9),
                          width: 1
                      )),
                    ),
                    child:  Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Input('请输入验证码',showBorder:false),
                        ),
                        RaisedButton(
                          child: Text(
                            '获取验证码',
                            style: TextStyle(
                              color: Color(0XFF22b0a1),
                              fontSize: ScreenAdaper.fontSize(24)
                            )
                          ),
                          color: Colors.white,
                          elevation:0,
                          onPressed: (){
                           
                          },
                        )
                      ],
                    )
                  )
                ),
                  Container(
                  padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Color(0XFFd9d9d9),
                          width: 1
                      )),
                    ),
                    child:  Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Input('请输入登录密码',showBorder:false,isPwd: true)
                        )
                      ],
                    )
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenAdaper.height(40)),
                  height: ScreenAdaper.height(88),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: RaisedButton(
                    child: Text(
                      '保存',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdaper.fontSize(40)
                      )
                    ),
                    disabledColor: Color(0XFF86d4ca),
                    splashColor: Color.fromARGB(0, 0, 0, 0),
                    highlightColor: Color(0xff009a8a),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    color: Color(0XFF22b0a1),
                    onPressed: (){
                      
                    },
                  ),
                )
            ],
          ),
        ),
    );
  }
}
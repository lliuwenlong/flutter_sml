import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sml/common/Color.dart';
import 'package:flutter_sml/common/HttpUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Input.dart';
import '../../components/AppBarWidget.dart';
class RetrieveAccount extends StatefulWidget {
    RetrieveAccount({Key key}) : super(key: key);
    _RetrieveAccountState createState() => _RetrieveAccountState();
}


class _RetrieveAccountState extends State<RetrieveAccount> {
    GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordIIController = TextEditingController();
    TextEditingController _verificationCodeController = TextEditingController();
    Timer _countdownTimer;
    String _codeCountdownStr = '获取验证码';
    int _countdownNum = 59;
    String code;
    bool isPassword = true;

    _RetrieveAccountState({Key key});

    @override
    void dispose() {
        _countdownTimer?.cancel();
        _countdownTimer = null;
        super.dispose();
    }

    Future _submitHandler () async {
        setState(() {
            this.isPassword = true;
        });
        
        if (_formKey.currentState.validate()) {
            final String phone = this._phoneController.text;
            final String password = this._passwordController.text;
            Map response = await HttpUtil().post("/api/v11/mpwd", params: {
                "password": password,
                "phone": phone,
                "vcode": this._verificationCodeController.text
            });
            if (response["code"] == 200 ) {
                await Fluttertoast.showToast(
                    msg: "修改成功",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    timeInSecForIos: 1,
                    textColor: Colors.white,
                    fontSize: ScreenAdaper.fontSize(30)
                ).then((m) => Navigator.pop(context));
            } else {
                Fluttertoast.showToast(
                    msg: response["msg"],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIos: 1,
                    textColor: Colors.white,
                    fontSize: ScreenAdaper.fontSize(30)
                );
            }
        }
    }

    // 获取验证码 
    Future _getCode () async {
        setState(() {
            this.isPassword = false;
        });
        if (!_formKey.currentState.validate()) {
            return null;
        }
        Map response =  await HttpUtil().get("/api/v11/vcode", data: {
            "phone": this._phoneController.text
        });
        setState(() {
            this.code = response["data"];
            // this._verificationCodeController.text = response["data"];
        });
    }

    String _phoneValidate (val) {
        RegExp exp = RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
        if(val == null || val == "") {
            return "手机号不可以为空";
        } else if (!exp.hasMatch(val)) {
            return "手机号不正确";
        }
        return null;
    }

    String _passwordValidate (val) {
        if (!isPassword) {
            return null;
        }
        if(val == null || val == "") {
            return "密码不可以为空";
        } else if (val.length < 6 || val.length > 16) {
            return "大于6个字符，小于16个字符";
        }
        return null;
    }

    String _passwordIIValidate (val) {
        if (!isPassword) {
            return null;
        }
        if (val != _passwordIIController.text) {
            return "两次密码不一致";
        }
        return null;
    }
    
    String _verificationCodeValidate (val) {
        if(val == null || val == "") {
            return "验证码不可以为空";
        }
        return null;
    }

    // 倒计时
    void reGetCountdown() {
        setState(() {
            this.isPassword = false;
        });
        if (!_formKey.currentState.validate()) {
            return null;
        }
        setState(() {
            if (_countdownTimer != null) {
                return;
            }
            this._getCode();
            // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
            _codeCountdownStr = '${_countdownNum--}';
            _countdownTimer =
            new Timer.periodic(new Duration(seconds: 1), (timer) {
                setState(() {
                    if (_countdownNum > 0) {
                        _codeCountdownStr = '${_countdownNum--}';
                    } else {
                        _codeCountdownStr = '获取验证码';
                        _countdownNum = 59;
                        _countdownTimer.cancel();
                        _countdownTimer = null;
                    }
                });
            });
        });
    }

    bool isDisabled() {
        return _passwordController.text.isNotEmpty
            && _phoneController.text.isNotEmpty
            && _verificationCodeController.text.isNotEmpty
            && _passwordIIController.text.isNotEmpty;
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            child: Scaffold(
                appBar: AppBarWidget().buildAppBar('忘记密码'),
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
                                            Form(
                                                key: _formKey,
                                                child: Column(
                                                    children: <Widget>[
                                                        Input(
                                                            "请输入手机号",
                                                            isShowSuffixIcon: true,
                                                            controller: this._phoneController,
                                                            validate: this._phoneValidate,
                                                            type: TextInputType.phone,
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
                                                                            showBorder: false,
                                                                            controller: this._verificationCodeController,
                                                                            type: TextInputType.number,
                                                                        )
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap: () {
                                                                            this.reGetCountdown();
                                                                        },
                                                                        child: Container(
                                                                            width: ScreenAdaper.width(171),
                                                                            height: ScreenAdaper.width(50),
                                                                            alignment: _countdownTimer != null ? Alignment.center : Alignment.centerRight,
                                                                            decoration: BoxDecoration(
                                                                                border: Border(left: BorderSide(
                                                                                    width: 1,
                                                                                    color: Color(0XFFd9d9d9)
                                                                                ))
                                                                            ),
                                                                            child: Text(this._codeCountdownStr, style: TextStyle(
                                                                                color: ColorClass.common,
                                                                                fontSize: ScreenAdaper.fontSize(30)
                                                                            )),
                                                                        )
                                                                    )
                                                                ],
                                                            )
                                                        ),
                                                        Input(
                                                            "请输入密码",
                                                            isPwd: true,
                                                            isShowSuffixIcon: true,
                                                            controller: this._passwordController,
                                                            validate: this._passwordValidate,
                                                        ),
                                                        Input(
                                                            "请再次确认新密码",
                                                            isPwd: true,
                                                            isShowSuffixIcon: true,
                                                            controller: this._passwordIIController,
                                                            validate: this._passwordIIValidate,
                                                        ),
                                                    ],
                                                ),
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
                                                    onPressed: _submitHandler,
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
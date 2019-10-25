import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Input.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';

class ChangePwd extends StatefulWidget {
  ChangePwd({Key key}) : super(key: key);

  _ChangePwdState createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  	final HttpUtil http = HttpUtil();
	User _userModel;
	String _code;
	Timer _countdownTimer;
	String _codeCountdownStr = '获取验证码';
    int _countdownNum = 59;
  TextEditingController _codeController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  //获取验证码
  _getCode() async {
    Map response = await this
        .http
        .get('/api/v11/vcode', data: {"phone": this._userModel.phone});

    if (response['code'] == 200) {
      this._code = response['data'];
      Fluttertoast.showToast(
          msg: '验证码发送成功，请注意查收',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.black87,
          fontSize: ScreenAdaper.fontSize(30));
    }
  }

  String _passwordValidate(val) {
    if (val == null || val == "") {
      return "密码不可以为空";
    } else if (val.length < 6 || val.length > 16) {
      return "大于6个字符，小于16个字符";
    }
    return null;
  }

  _changePwd() async {
    if (this._codeController.text != this._code) {
      	Fluttertoast.showToast(
          msg: '验证码错误',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.black87,
          fontSize: ScreenAdaper.fontSize(30));
      	return;
    }
    if (this._pwdController.text == null || this._pwdController.text == "") {
      	Fluttertoast.showToast(
			msg: '密码不能为空',
			toastLength: Toast.LENGTH_SHORT,
			gravity: ToastGravity.CENTER,
			timeInSecForIos: 1,
			textColor: Colors.white,
			backgroundColor: Colors.black87,
			fontSize: ScreenAdaper.fontSize(30));
      	return;
    }
    if (this._pwdController.text.length < 6 ||
        this._pwdController.text.length > 16) {
      Fluttertoast.showToast(
          msg: '大于6个字符，小于16个字符',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.black87,
          fontSize: ScreenAdaper.fontSize(30));
      return;
    }

    Map res = await this.http.post('/api/v11/mpwd', params: {
      "password": this._pwdController.text,
      "phone": this._userModel.phone,
      "vcode": this._codeController.text
    });
    if (res['code'] == 200) {
      Fluttertoast.showToast(
          msg: '修改成功',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.black87,
          fontSize: ScreenAdaper.fontSize(30));
      Navigator.pop(context);
    }
  }

	// 倒计时
    void reGetCountdown() {
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<User>(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('修改密码'),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: ScreenAdaper.width(110),
                  right: ScreenAdaper.width(110),
                  top: ScreenAdaper.height(40),
                  bottom: ScreenAdaper.height(40)),
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                '为了您的账户安全，本次操作需要短信确认验证码将发送至${this._userModel.phone.substring(0, 3)}****${this._userModel.phone.substring(7, 11)}',
                style: TextStyle(
                  fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true),
                  color: Color(0XFF333333),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0XFFd9d9d9), width: 1)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Input(
                            '请输入验证码',
                            showBorder: false,
                            controller: _codeController,
                          ),
                        ),
                        RaisedButton(
                          	child: Text(_codeCountdownStr,
                              	style: TextStyle(
									color: Color(0XFF22b0a1),
									fontSize: ScreenAdaper.fontSize(24))),
							color: Colors.white,
							elevation: 0,
							onPressed: () {
								this.reGetCountdown();
							},
                        )
                      ],
                    ))),
            Container(
                padding: EdgeInsets.only(
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                    decoration: BoxDecoration(
                      	border: Border(
                         	bottom: BorderSide(color: Color(0XFFd9d9d9), width: 1)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Input(
                              '请输入登录密码',
                              showBorder: false,
                              isPwd: true,
                              controller: _pwdController,
                              validate: _passwordValidate,
                            ))
                      ],
                    ))),
            Container(
				margin: EdgeInsets.only(top: ScreenAdaper.height(40)),
				height: ScreenAdaper.height(88),
				padding: EdgeInsets.only(
					left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
				decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: RaisedButton(
              child: Text('保存',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenAdaper.fontSize(40))),
					disabledColor: Color(0XFF86d4ca),
					splashColor: Color.fromARGB(0, 0, 0, 0),
					highlightColor: Color(0xff009a8a),
					elevation: 0,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.all(Radius.circular(5))),
					color: Color(0XFF22b0a1),
					onPressed: () {
						this._changePwd();
					},
              	),
            )
          ],
        ),
      ),
    );
  }
}

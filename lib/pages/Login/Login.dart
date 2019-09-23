import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sml/common/Color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Input.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/user/UserModel.dart';
import '../../model/store/user/User.dart';

class LoginPage extends StatefulWidget {
    LoginPage({Key key}) : super(key: key);
    _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    User userModel; 
    void didChangeDependencies() {
        super.didChangeDependencies();
        userModel = Provider.of<User>(context);
    }
    void _submit () async {
        if (_formKey.currentState.validate()) {
            Map response = await HttpUtil().post("/api/v11/vlogin", params: {
                "password": _passwordController.text,
                "phone": _phoneController.text
            });
            if (response["code"] == 200 ) {
                UserModel userModel = new UserModel.fromJson(response);
                Data data = userModel.data;
                this.userModel.initUser(
                    userId: data.userId,
                    userName: data.userName,
                    phone: data.phone,
                    password: data.password,
                    headerImage:data.headerImage,
                    nickName: data.nickName,
                    createTime: data.createTime
                    
                );
                Navigator.pushReplacementNamed(context, "/");
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
        if(val == null || val == "") {
            return "密码不可以为空";
        } else if (val.length < 6 || val.length > 16) {
            return "大于6个字符，小于16个字符";
        }
        return null;
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
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
                                            Form(
                                                key: _formKey,
                                                child: Column(
                                                    children: <Widget>[
                                                        Input(
                                                            "请输入手机号",
                                                            isShowSuffixIcon: true,
                                                            controller: _phoneController,
                                                            validate: _phoneValidate,
                                                            type: TextInputType.phone,
                                                        ),
                                                        Input(
                                                            "请输入密码",
                                                            isPwd: true,
                                                            isShowSuffixIcon: true,
                                                            controller: _passwordController,
                                                            validate: _passwordValidate
                                                        )
                                                    ]
                                                )
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenAdaper.height(20)
                                                ),
                                                width: double.infinity,
                                                height: ScreenAdaper.height(88),
                                                child: RaisedButton(
                                                    onPressed: () {
                                                        _submit();
                                                    },
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

class CounterModel {
}
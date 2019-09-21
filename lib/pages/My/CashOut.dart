import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../model/store/user/User.dart';
import 'package:provider/provider.dart';
import '../../common/HttpUtil.dart';
class CashOut extends StatefulWidget {
  CashOut({Key key}) : super(key: key);
  _CashOutState createState() => _CashOutState();
}

class _CashOutState extends State<CashOut> {
  String _inputText = '';
  User _userModel;
  String _moneyNum;
  final HttpUtil http = HttpUtil();
  @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        this._getData();
    }

  _getData () async {
        Map response = await this.http.get("/api/v1/user/account", data: {
            "userId": this._userModel.userId
        });
       print(response["data"]);
       if (response["code"] == 200) {
            setState(() {
              this._moneyNum = response["data"];
            });
        } else {
            Fluttertoast.showToast(
                msg: response["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
        }
    }

    _cashOut(String amount) async {
      
      if(double.parse(amount)>0 && double.parse(this._moneyNum) >= double.parse(amount)){
        Map response = await this.http.post('/api/v1/user/account/case',data:{
          'amount':amount,
          'userId':this._userModel.userId
        });
        print(response);
        if(response['code']==200){
          this._getData();
        }else{
            Fluttertoast.showToast(
                msg: response["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
        }
      }else{
         Fluttertoast.showToast(
                msg: '余额不足',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
      }
      
    }

   
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('提现'),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: ScreenAdaper.height(120),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/weixin.png'),
                  SizedBox(width: ScreenAdaper.width(20)),
                  Text(
                    '提现到微信',
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: ScreenAdaper.fontSize(30)),
                  )
                ],
              ),
            ),
            Container(
              // height: ScreenAdaper.height(400),
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
              child: Column(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
                      child: Text(
                        '提现金额',
                        style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: ScreenAdaper.fontSize(28),
                        ),
                        textAlign: TextAlign.left,
                      )),
                  SizedBox(height: ScreenAdaper.height(70)),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xffd9d9d9),
                                width: ScreenAdaper.width(1)))),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '¥',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: ScreenAdaper.fontSize(60)),
                        ),
                        SizedBox(
                          width: ScreenAdaper.width(10),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            // autofocus:true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                              // LengthLimitingTextInputFormatter(6)
                            ],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: ScreenAdaper.fontSize(40)),
                            onChanged: (str) {
                              setState(() {
                                _inputText = str;
                                // widget.fieldCallBack(_inputText);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(28), 0, ScreenAdaper.height(30)),
                    child: Text(
                      '账户当前余额：¥ $_moneyNum',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: ScreenAdaper.fontSize(24)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(52)),
              padding: EdgeInsets.only(
                  left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
              width: double.infinity,
              height: ScreenAdaper.height(88),
              child: RaisedButton(
                child: Text(
                  '提现',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenAdaper.fontSize(40)),
                ),
                disabledColor: Color(0XFF86d4ca), //禁用时的颜色
                splashColor: Color.fromARGB(0, 0, 0, 0), //水波纹
                highlightColor: Color(0xff009a8a),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                color: Color(0XFF22b0a1), //默认颜色
                onPressed: () {
                  this._cashOut(this._inputText);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenAdaper.width(78),
                  ScreenAdaper.height(30), ScreenAdaper.width(78), 0),
              alignment: Alignment.center,
              child: Text(
                '温馨提示：申请提现后我们将直接划入您绑定的微信账户内，提现预计24小时之内到账。',
                style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: ScreenAdaper.fontSize(24),
                    height: 1.2),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

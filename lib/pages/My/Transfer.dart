import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sml/common/HttpUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../model/store/user/User.dart';
class Transfer extends StatefulWidget {
  final Map arguments;
  Transfer({Key key,this.arguments}) : super(key: key);

  _TransferState createState() => _TransferState(arguments:this.arguments);
}

class _TransferState extends State<Transfer> {
  final Map arguments;
  _TransferState({this.arguments});
  @override
  void initState() {
    super.initState();
  }
   String _inputText='';
   User userModel;
   String text='';
   final HttpUtil http = HttpUtil();
  void didChangeDependencies() {
        super.didChangeDependencies();
        userModel = Provider.of<User>(context);
    }
String _phoneValidate (val) {
        RegExp exp = RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
        if(val == null || val == "") {
            return "手机号不可以为空";
        } else if (!exp.hasMatch(val)) {
            return "手机号不正确";
        }
        return 'true';
    }

_submitData () async {
      
        Map response = await this.http.post("/api/v1/wood/transfer", data: {
            "phone": this._inputText,
            "userId": this.userModel.userId,
            "woodSn":arguments['woodSn']
        });
        if (response["code"] == 200) {
            Fluttertoast.showToast(
                msg: '转让成功',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                backgroundColor: Colors.black87,
                fontSize: ScreenAdaper.fontSize(30)
            );

            this._inputText ='';
             Navigator.pushReplacementNamed(context, '/product',arguments: {
                       'index':1
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
  @override
  Widget build(BuildContext context) {
    TextEditingController input = new TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: TextSelection.fromPosition(
              TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length
              )
            )
        )
    );
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('转让'),
      body: SafeArea(
        top: false,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: ScreenAdaper.height(100),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffd5d5d5),
                      width: ScreenAdaper.width(2)
                    )
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '被转让人',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontFamily: "SourceHanSansCN-Regular",
	                      fontSize: ScreenAdaper.fontSize(28),
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdaper.width(300),
                    ),
                    Expanded(
                      flex: 1,
                      child:  TextField(
                          decoration: InputDecoration(
                            hintText: '请输入被转让人手机号',
                            hintStyle: TextStyle(
                              color: Color(0xffaaaaaa),
                              fontSize: ScreenAdaper.fontSize(24)
                            ),
                            border: InputBorder.none
                          ),
                          controller: input,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(11),
                              WhitelistingTextInputFormatter.digitsOnly
                          ],
                          onChanged: (str){
                            setState(() {
                              _inputText = str;
                            });
                          },
                    ),
                    )
                  ],
                ),
              ),
             text.isEmpty||text=='true'?Text(''): Container(
                margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: ScreenAdaper.fontSize(30),
                    color: Color(0xfffb4135),
                  ),
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
                  '确认转让',
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
                  setState(() {
                    this.text = this._phoneValidate(this._inputText);
                  });
                  if(this.text=='true'){
                    this._submitData();
                  }
                 
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenAdaper.width(78),
                  ScreenAdaper.height(30), ScreenAdaper.width(78), 0),
              alignment: Alignment.center,
              child: Text(
                '温馨提示：转让之后，神木将不再属于你，请仔细核对被转让人手机号，以免造成损失。',
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
      ),
    );
  }
}
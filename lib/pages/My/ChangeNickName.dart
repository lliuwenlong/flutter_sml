import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../model/store/user/User.dart';
import '../../common/HttpUtil.dart';
class ChangeNickName extends StatefulWidget {
  final Map arguments;
  ChangeNickName({Key key, this.arguments}) : super(key: key);
  _ChangeNickNameState createState() => _ChangeNickNameState(arguments: this.arguments);
}

class _ChangeNickNameState extends State<ChangeNickName> {
  final Map arguments;
  final HttpUtil http = HttpUtil();
  User _userModel;
  _ChangeNickNameState({this.arguments});

  String _inputText = "";
  bool _hasdeleteIcon = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<User>(context);
  }
  @override
  void initState() {
    super.initState();
    this._inputText = '${this.arguments["nickName"]}';
    this._hasdeleteIcon = (this._inputText.isNotEmpty);
  }

  _ChangeNickName (String nickName) async {
    Map response = await this.http.post('/api/v11/user/rename', data: {
      "nickName": nickName,
      "userId": this._userModel.userId
    });

    if(response['code'] == 200){
        Fluttertoast.showToast(
            msg: '修改成功',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            textColor: Colors.white,
            backgroundColor: Colors.black87,
            fontSize: ScreenAdaper.fontSize(30)
        );
        this._userModel.initUser(
            userId: this._userModel.userId,
            userName: this._userModel.userName,
            phone: this._userModel.phone,
            password: this._userModel.password,
            headerImage:this._userModel.headerImage,
            nickName: nickName,
            createTime: this._userModel.createTime
        );
        Navigator.pushReplacementNamed(context, '/userInfo');
    }else{
      Fluttertoast.showToast(
            msg: response['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            textColor: Colors.white,
            backgroundColor: Colors.black87,
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
      appBar: AppBarWidget().buildAppBar('修改昵称'),
      body: Container(
        padding: EdgeInsets.only(
            left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xffd9d9d9),
                          width: ScreenAdaper.width(1)
                      )
                  ),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: InputBorder.none,
                  suffixIcon: _hasdeleteIcon
                      ? new Container(
                          width: 20.0,
                          height: 20.0,
                          child: new IconButton(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(0.0),
                            iconSize: 18.0,
                            icon: Icon(
                              IconData(0xe620, fontFamily: 'iconfont'),
                              color: Color(0xffd9d9d9),
                            ),
                            onPressed: () {
                              setState(() {
                                _inputText = "";
                                _hasdeleteIcon = (_inputText.isNotEmpty);
                                // widget.fieldCallBack(_inputText);
                              });
                            },
                          ),
                        )
                      : new Text(""),
                ),
                onChanged: (str) {
                  setState(() {
                    _inputText = str;
                    _hasdeleteIcon = (_inputText.isNotEmpty);
                    // widget.fieldCallBack(_inputText);
                  });
                },
              ),
            ),
            SizedBox(height: ScreenAdaper.height(52),),
            Container(
              width: double.infinity,
              height: ScreenAdaper.height(88),
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
                      this._ChangeNickName(this._inputText);
                    },
                  ),
            )
          ],
        ),
      ),
    );
  }
}

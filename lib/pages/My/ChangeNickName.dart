import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';

class ChangeNickName extends StatefulWidget {
  final Map arguments;
  ChangeNickName({Key key, this.arguments}) : super(key: key);
  _ChangeNickNameState createState() => _ChangeNickNameState(arguments: this.arguments);
}

class _ChangeNickNameState extends State<ChangeNickName> {
  final Map arguments;
  _ChangeNickNameState({this.arguments});

  String _inputText = "";
  bool _hasdeleteIcon = false;

  @override
  void initState() {
    super.initState();
    this._inputText = '${this.arguments["nickName"]}';
    this._hasdeleteIcon = (this._inputText.isNotEmpty);
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
                      Navigator.pushReplacementNamed(context, '/userInfo',arguments: {
                        'modifiedNickName':this._inputText
                      });
                    },
                  ),
            )
          ],
        ),
      ),
    );
  }
}

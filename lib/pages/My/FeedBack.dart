import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class FeedBack extends StatefulWidget {
  FeedBack({Key key}) : super(key: key);
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  static String _inputText ='';
  TextEditingController input = TextEditingController.fromValue(
      TextEditingValue(
        text: _inputText,
      )
  );
  @override
  void initState() { 
    super.initState();
  }
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('意见反馈'),
      body:Container(
          padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenAdaper.width(690),
                margin: EdgeInsets.only(left: ScreenAdaper.width(30)),
                child:  TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: '请输入您对我们的意见...',
                  hintStyle: TextStyle(
                    color: Color(0xffaaaaaa),
                    fontSize: ScreenAdaper.fontSize(24)
                  ),
                  filled: true,
                  fillColor: Color(0xfff5f5f5),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(1000)
                ],
                controller: input,
              )),
              SizedBox(height: 26),
              Container(
                width: ScreenAdaper.width(690),
                height: ScreenAdaper.height(88),
                padding: EdgeInsets.only(left: ScreenAdaper.width(30)),
                child: RaisedButton(
                  child: Text(
                    '提交',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenAdaper.fontSize(40)
                    ),
                  ),
                    disabledColor: Color(0XFF86d4ca),//禁用时的颜色
                    splashColor: Color.fromARGB(0, 0, 0, 0),//水波纹
                    highlightColor:Color(0xff009a8a),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    color: Color(0XFF22b0a1),//默认颜色
                    onPressed: (){
                      print(input.text);
                      Navigator.pop(context);
                    },
                ),
              )
            ],
          ),
        ),
    );
  }
}
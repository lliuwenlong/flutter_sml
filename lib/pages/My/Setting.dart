import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../model/store/user/User.dart';
enum Action {
    Ok,
    Cancel
}
class Setting extends StatefulWidget {
    Setting({Key key}) : super(key: key);
    _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
    Widget _listItem (String name,String routerName,{isBorder=true,int color=0XFF333333}){
        return GestureDetector(
            onTap: (){
                Navigator.pushNamed(context, routerName);
            },
            child: Container(
                height: ScreenAdaper.height(88),
                padding:EdgeInsets.only(left: ScreenAdaper.width(30),right:ScreenAdaper.width(30)),
                decoration: BoxDecoration(
                    color: Colors.white,
                ),
                child: Container(
                    decoration: BoxDecoration(
                        border: isBorder ? Border(bottom: BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: 1
                        )) : null
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Text(name, style: TextStyle(
                                color: Color(color),
                                fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                            )),
                            Expanded(
                                flex: 1,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                        Icon(
                                        IconData(0xe61e, fontFamily: 'iconfont'), 
                                        size: ScreenAdaper.fontSize(24, allowFontScaling: true),
                                        color: Color(0xffaaaaaa)
                                        )
                                    ]
                                ),
                            )
                        ]
                    ),
                )
            )
        );
  }
    String  _choice ='';
    Future _openAlertDialog() async {
      final action = await showDialog(
        context: context,
        barrierDismissible: false,//// user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '退出',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: ScreenAdaper.fontSize(38)
              ),
              ),
            content: Text(
              '退出登录后将无法浏览部分信息，重新登录后即可查看!',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: ScreenAdaper.fontSize(30)
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '取消',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize:ScreenAdaper.fontSize(30)
                  )
                  ),
                onPressed: () {
                  Navigator.pop(context, Action.Cancel);
                },
              ),
              FlatButton(
                child: Text(
                  '确定',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize:ScreenAdaper.fontSize(30)
                  )
                ),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (router) => false);
                },
              ),
            ],
          );
        },
      );

      switch (action) {
        case Action.Ok:
          setState(() {
            this._choice = 'Ok';
          });
          break;
        case Action.Cancel:
          setState(() {
            this._choice = 'Cancel';
          });
          break;
        default:
      }
    }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('设置'),
      body: Container(
          child:Column(
            children: <Widget>[
              this._listItem('修改密码', '/changePwd',isBorder: true),
              this._listItem('意见反馈', '/feedBack',isBorder: true),
              this._listItem('关于我们', '/about',isBorder: false),
              Container(
                margin: EdgeInsets.only(bottom: ScreenAdaper.height(10)),
              ),
              MaterialButton(
                color: Colors.white,
                elevation: 0,
                minWidth: double.infinity,
                height: ScreenAdaper.height(88),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Text('退出登录', style: TextStyle(
                            color: Color(0XFF22b0a1),
                            fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                        )),
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                    Icon(
                                      IconData(0xe61e, fontFamily: 'iconfont'), 
                                      size: ScreenAdaper.fontSize(24, allowFontScaling: true),
                                      color: Color(0XFF22b0a1)
                                    )
                                ]
                            ),
                        )
                    ]
              ),
                onPressed:_openAlertDialog,
              )
            ],
        )),
    );
  }
}
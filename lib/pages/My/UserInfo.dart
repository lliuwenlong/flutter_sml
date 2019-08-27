import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';

class UserInfo extends StatefulWidget {
  final Map arguments;
  UserInfo({Key key,this.arguments}) : super(key: key);

  _UserInfoState createState() => _UserInfoState(arguments:this.arguments);
}

class _UserInfoState extends State<UserInfo> {
  String _nickName = '张三';
  final Map arguments;
  _UserInfoState({this.arguments});
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('个人信息'),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenAdaper.height(148),
              padding: EdgeInsets.only(
                  left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('我的头像'),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                          radius: ScreenAdaper.height(43),
                          backgroundImage: NetworkImage(
                              'https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws')),
                      SizedBox(
                        width: ScreenAdaper.width(20),
                      ),
                      Icon(IconData(0xe61e, fontFamily: 'iconfont'),
                          size: ScreenAdaper.fontSize(24,
                              allowFontScaling: true)),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/changeNickName',
                    arguments: {"nickName": '$_nickName'});
              },
              child: Container(
                height: ScreenAdaper.height(86),
                margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                padding: EdgeInsets.only(
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('昵称'),
                    Row(
                      children: <Widget>[
                        Text(
                          '$_nickName',
                          style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: ScreenAdaper.fontSize(24)),
                        ),
                        SizedBox(
                          width: ScreenAdaper.width(20),
                        ),
                        Icon(IconData(0xe61e, fontFamily: 'iconfont'),
                            size: ScreenAdaper.fontSize(24,
                                allowFontScaling: true)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class BusinessQualification extends StatefulWidget {
  final arguments;
  BusinessQualification({Key key,this.arguments}) : super(key: key);

  _BusinessQualificationState createState() => _BusinessQualificationState(arguments:arguments);
}

class _BusinessQualificationState extends State<BusinessQualification> {
  final arguments;
  _BusinessQualificationState({this.arguments});

  Widget _item () {
    return  Container(
              width: ScreenAdaper.width(335),
              height: ScreenAdaper.height(335),
              color: Colors.white,
              child: Container(
                child: 
                Image.network(
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569668417982&di=970f2a9f69a45ac6995b54dad7a27ebf&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20190824%2Feaa3cd45c861464bb456778fb5fa0b8b.jpeg',
                ),
              ),
            );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('商家资质'),
      body: SafeArea(
        bottom: true,
        child: Container(
          margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
          padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
          child: ListView(
            children: <Widget>[
                Wrap(
                  spacing:ScreenAdaper.width(20),
                  runSpacing: ScreenAdaper.height(20),
                  children: <Widget>[
                    _item(),
                    _item(),
                    _item(),
                  ],
                )
            ],
          ),
        ),
      )
    );
  }
}
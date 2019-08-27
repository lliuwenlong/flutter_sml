import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import 'ListItem.dart';
import '../../components/AppBarWidget.dart';
class OtherMessage extends StatefulWidget {
 final Map arguments;
  OtherMessage({Key key,this.arguments}) : super(key: key);
  _OtherMessageState createState() => _OtherMessageState(arguments:this.arguments);
}

class _OtherMessageState extends State<OtherMessage> {
 final Map arguments;
  _OtherMessageState({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('${arguments['appTabName']}'),
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 16, 15, 0),
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7)
          ),
          child: Column(
            children: <Widget>[
              ListItem(
                "您购买的增值服务有了新的产值！", 
                "昨天  11:30", 
                "/newsDetail", 
                "${arguments['appTabName']}",
              ),
              ListItem(
                "您种植的百合花已经开花！", 
                "昨天  11:30", 
                "/newsDetail", 
                "${arguments['appTabName']}",
              )
            ],
          ),
        ),
      ),
    );
  }
}
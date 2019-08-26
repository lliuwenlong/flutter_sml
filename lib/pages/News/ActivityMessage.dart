import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import 'ListItem.dart';
import '../../components/AppBarWidget.dart';
class ActivityMessage extends StatefulWidget {
 final Map arguments;
  ActivityMessage({Key key,this.arguments}) : super(key: key);
  _ActivityMessageState createState() => _ActivityMessageState(arguments:this.arguments);
}

class _ActivityMessageState extends State<ActivityMessage> {
 final Map arguments;
  _ActivityMessageState({this.arguments});
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('${arguments["appTabName"]}'),
      body: Container(
          padding: EdgeInsets.fromLTRB(15, 16, 15, 0),
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7)
          ),
          child: Column(
            children: <Widget>[
              ListItem(
                "神木驿站推出了新的活动！", 
                "昨天  11:30", 
                "/newsDetail", 
                "${arguments['appTabName']}",
                subtitle: "神木林平台入驻需求具体需求内容，神木林国家储备林，是农林一体化产品，成为神木会员将拥有的九大好处神木林平台入驻需求具体需求内容，神木林国家储备林，是农林一体化产品，成为神木会员将拥有的九大好处",
              )
            ],
          ),
        ),
      
    );
  }
}
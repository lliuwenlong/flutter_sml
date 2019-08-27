import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import 'ListItem.dart';
import '../../components/AppBarWidget.dart';
class SystemMessage extends StatefulWidget {
 final Map arguments;
  SystemMessage({Key key,this.arguments}) : super(key: key);
  _SystemMessageState createState() => _SystemMessageState(arguments:this.arguments);
}

class _SystemMessageState extends State<SystemMessage> {
 final Map arguments;
  _SystemMessageState({this.arguments});
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
                "想要加盟入驻我们平台吗？来一起看看我们的加盟需求吧！", 
                "昨天  11:30", 
                "/newsDetail", 
                "${arguments['appTabName']}",
                subtitle: "神木林平台入驻需求具体需求内容，神木林国家储备林，是农林一体化产品，成为神木会员将拥有的九大好处...",
              ),
              ListItem(
                "神木林APP正式上线通知！", 
                "昨天  11:30", 
                "/newsDetail", 
                "${arguments['appTabName']}",
                subtitle: "神木林平台入驻需求具体需求内容，神木林国家储备林，是农林一体化产品，成为神木会员将拥有的九大好处...",
              )
            ],
          ),
        ),
      ),
    );
  }
}
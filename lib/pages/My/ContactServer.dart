import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class ContactServer extends StatefulWidget {
  ContactServer({Key key}) : super(key: key);

  _ContactServerState createState() => _ContactServerState();
}

class _ContactServerState extends State<ContactServer> {

Widget _ListItem (String name,String tips,{isBorder=true,int color=0XFF666666}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white
    ),
    height: ScreenAdaper.height(88),
    padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
    child: Container(
      decoration: BoxDecoration(
        border: isBorder ? Border(bottom: BorderSide(
          color: Color(0XFFd9d9d9),
          width: 1
        )) : null
      ),
      child: Row(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: ScreenAdaper.fontSize(28)
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  tips,
              style:TextStyle(
                color:Color(color),
                fontSize: ScreenAdaper.fontSize(24)
              )
                )
              ],
            ),
          )
        ],
    )

    ),
  );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar:AppBarWidget().buildAppBar('联系客服'),
         body: Container(
           child: Column(
             children: <Widget>[
               this._ListItem('客服热线', '400-000-0000',color: 0xff22b0a1),
               this._ListItem('官网地址', 'www.shenmulin.com'),
               this._ListItem('公司地址', '贵州省黔西南布依族苗族自治州兴义市',isBorder: false)
             ],
           ),
         ),
       );
  }
}
import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';

class NewsDetail extends StatefulWidget {
 final  Map arguments;
  NewsDetail({Key key,this.arguments}) : super(key: key);
  _NewsDetailState createState() => _NewsDetailState(arguments:this.arguments);
}

class _NewsDetailState extends State<NewsDetail> {
 final  Map arguments;
  _NewsDetailState({this.arguments});
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
       child: Scaffold(
         appBar: AppBarWidget().buildAppBar('${arguments["appTabName"]}'),
         body: Container(
           padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), ScreenAdaper.height(20), ScreenAdaper.width(30), 0),
           decoration: BoxDecoration(
             color: Colors.white
           ),
           child: Column(
             children: <Widget>[
               Container(
                  width: double.infinity,
                  child: Text(
                   '神木林APP正式上线通知！',
                   style: TextStyle(
                     color: Color(0xff333333),
                     fontFamily: 'SourceHanSansCN-Medium',
                     fontSize: ScreenAdaper.fontSize(40),
                     fontWeight: FontWeight.w500
                   ),
                  ),
               ),
               SizedBox(height: ScreenAdaper.height(12)),
               Container(
                 width: double.infinity,
                 child: Text(
                   '发布时间：2019年8月1日',
                   style: TextStyle(
                     color: Color(0xff999999),
                     fontFamily: 'SourceHanSansCN-Regular',
                     fontSize: ScreenAdaper.fontSize(22),
                   ),
                 ),
               ),
                SizedBox(height: ScreenAdaper.height(18)),
                Container(
                 width: double.infinity,
                 child: Text(
                   '神木林APP正式上线啦！酒店周边有多条公交覆盖,购物、用餐、休闲、娱乐、极为方便.酒店配套服务设施齐全,畅快的淋浴、简约的现代家具，让您时刻享受家的感觉！',
                   style: TextStyle(
                     color: Color(0xff666666),
                     fontFamily: 'SourceHanSansCN-Regular',
                     fontSize: ScreenAdaper.fontSize(26),
                     height:1.2,
                   ),
                 ),
                 
               ),
               SizedBox(height: ScreenAdaper.height(20),),
               Container(
                 width: double.infinity,
                 child: Image.asset('images/message.png')
               ),
               Container(
                 width: double.infinity,
                 child: Text(
                   '酒店周边有多条公交覆盖,购物、用餐、休闲、娱乐、极为方便.酒店配套服务设施齐全,畅快的淋浴、简约的现代家具，让您时刻享受家的感觉！',
                   style: TextStyle(
                     color: Color(0xff666666),
                     fontFamily: 'SourceHanSansCN-Regular',
                     fontSize: ScreenAdaper.fontSize(26),
                     height:1.2,
                   ),
                 ),
               )
             ],
           ),
         ),
       ),
    );
  }
}
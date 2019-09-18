
import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';

class RecordItem extends StatelessWidget {
  final String name;
  final String text;
  final String date;
  RecordItem(this.name,this.text,{Key key,this.date=''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), ScreenAdaper.height(30), ScreenAdaper.width(30), ScreenAdaper.height(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontFamily: "SourceHanSansCN-Regular",
	                fontSize: ScreenAdaper.fontSize(28),
                  color: Color(0xff666666)
                ),
              ),
              date.isNotEmpty?Text(
                date,
                style: TextStyle(
                  fontFamily: "SourceHanSansCN-Regular",
	                fontSize: ScreenAdaper.fontSize(24),
                  color: Color(0xff999999)
                ),
              ):Text('')
            ],
          ),
          SizedBox(height: ScreenAdaper.height(18)),
          Text(
            text,
            style: TextStyle(
                  fontFamily: "SourceHanSansCN-Regular",
	                fontSize: ScreenAdaper.fontSize(24),
                  color: Color(0xff666666)
                ),
          )
        ],
      )
    );
  }
}
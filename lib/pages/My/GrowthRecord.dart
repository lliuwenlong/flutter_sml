import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/RecordItem.dart';
class GrowthRecord extends StatelessWidget {
    const GrowthRecord({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
		ScreenAdaper.init(context);
		return Scaffold(
			appBar: AppBarWidget().buildAppBar("成长记录"),
			body: Container(
        padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
        child: ListView(
          children: <Widget>[
            RecordItem('发芽', '2019-08-20'),
            RecordItem('成功种植', '2019-08-05'),
          ],
        ),
      )
		);
    }
}
import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/RecordItem.dart';
class OutputRecord extends StatelessWidget {
    const OutputRecord({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
		ScreenAdaper.init(context);
		return Scaffold(
			appBar: AppBarWidget().buildAppBar("产值记录"),
			body: Container(
        padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
        child: ListView(
          children: <Widget>[
            RecordItem('产值100束百合花', '2019-08-20'),
            RecordItem('产值10束百合花', '2019-08-05'),
          ],
        ),
      )
		);
    }
}
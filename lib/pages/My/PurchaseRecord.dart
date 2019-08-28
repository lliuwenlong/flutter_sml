import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/RecordItem.dart';
class PurchaseRecord extends StatelessWidget {
    const PurchaseRecord({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
		ScreenAdaper.init(context);
		return Scaffold(
			appBar: AppBarWidget().buildAppBar("购买记录"),
			body: Container(
        padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
        child: ListView(
          children: <Widget>[
            RecordItem('购买了一颗生态园林的金丝楠木', '2019-08-20'),
            RecordItem('购买了神木驿站的一颗红豆杉', '2019-08-05'),
          ],
        ),
      )
		);
    }
}
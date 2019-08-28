import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/RecordItem.dart';
class TransferRecord extends StatelessWidget {
    const TransferRecord({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
		ScreenAdaper.init(context);
		return Scaffold(
			appBar: AppBarWidget().buildAppBar("转让记录"),
			body: Container(
        padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
        child: ListView(
          children: <Widget>[
            RecordItem('张三', '红豆杉持有人由 李四 更改为 张三',date:'2019-08-20  12:20:15'),
            RecordItem('李四', '将红豆杉转让至 张三',date:'2019-07-18  12:20:15'),
            RecordItem('李四', '李四 购买红豆杉',date:'2019-02-20  08:20:15'),
          ],
        ),
      )
		);
    }
}
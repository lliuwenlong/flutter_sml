import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
class PurchaseRecord extends StatelessWidget {
    const PurchaseRecord({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
		ScreenAdaper.init(context);
		return Scaffold(
			appBar: AppBarWidget().buildAppBar("转让记录"),
			body: ListView.builder(
				itemBuilder: (BuildContext ccontext, int index) {
					return Container(
						color: Colors.white,
						padding: EdgeInsets.fromLTRB(
							ScreenAdaper.width(30),
							ScreenAdaper.height(40),
							ScreenAdaper.width(30),
							ScreenAdaper.height(40)
						),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: <Widget>[
										Text("张三", style: TextStyle(
											color: ColorClass.fontColor,
											fontSize: ScreenAdaper.fontSize(28)
										)),
										Text("2019-08-20  12:20:15", style: TextStyle(
											color: ColorClass.subTitleColor,
											fontSize: ScreenAdaper.fontSize(24)
										))
									]
								),
								SizedBox(height: ScreenAdaper.height(20)),
								Text("红豆杉持有人由 李四 更改为 张三", style: TextStyle(
									color: ColorClass.fontColor,
									fontSize: ScreenAdaper.fontSize(24)
								))
							],
						)
					);
				},
				itemCount: 10,
			)
		);
    }
}
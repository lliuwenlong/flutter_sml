import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../../services/ScreenAdaper.dart';
import '../../../components/AppBarWidget.dart';
import '../../../common/Color.dart';
import '../../../components/FotterButton.dart';

class CancellationOrder extends StatelessWidget {
    final Map arguments;
    List<Map> orderStatus = [
        {"name": "订单状态", "value": "进行中"}
    ];

    List<Map> info = [
        {"name": "神木名称", "value": "金丝楠"},
        {"name": "所属基地", "value": "生态公园基地"},
        {"name": "购买数量", "value": "2"}
    ];

    List<Map> orderInfo = [
        {"name": "订单号", "value": "9875421588666"},
        {"name": "下单时间", "value": "2019-08-05  12:05"},
        {"name": "付款时间", "value": "2019-08-05  16:25"},
        {"name": "支付金额", "value": "¥1000.00"},
    ];

    CancellationOrder({Key key, this.arguments}) : super(key: key);
    
    List<Widget> _getList (List<Map> list, {MainAxisAlignment align = MainAxisAlignment.start}) {
        return list.map((val) {
            return Container(
                margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
                child: Row(
                    mainAxisAlignment: align,
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(193),
                            child: Text(val["name"], style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(28)
                            ))
                        ),
                        Text(val["value"], style: TextStyle(
                            color: ColorClass.fontColor,
                            fontSize: ScreenAdaper.fontSize(28)
                        ))
                    ]
                ),
            );
        }).toList();
    }

    Widget _item (String title, List<Map> list, {MainAxisAlignment align = MainAxisAlignment.start}) {
        List<Widget> widgetTitle = [
            Text(title, style: TextStyle(
                color: ColorClass.titleColor,
                fontSize: ScreenAdaper.fontSize(32),
                fontWeight: FontWeight.w500
            ))
        ];
        widgetTitle.addAll(this._getList(list, align: align));
        return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgetTitle
            )
        );
    }

    onTapHandler ({context}) async {
        const Map<String, String> provincesData = {
            "1": "我不想买了",
            "2": "选择错误，重新购买",
            "3": "其他原因"
        };
        const Map<String, dynamic> citiesData = {
            "1": {
                "11": {}
            },
            "2": {
                "22": {}
            },
            "3": {
                "33": {}
            }
        };
        Result result = await CityPickers.showCityPicker(
            context: context,
            height: ScreenAdaper.height(435),
            showType: ShowType.p,
            provincesData: provincesData,
            citiesData: citiesData,
            cancelWidget: Text("取消1")
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("我的订单"),
            bottomSheet: FotterButton("取消订单", onTapHandler: () {
                this.onTapHandler(context: context);
            }),
            body: ListView(
                children: <Widget>[
                    this._item("订单状态", this.orderStatus, align: MainAxisAlignment.spaceBetween),
                    SizedBox(height: ScreenAdaper.height(20)),
                    this._item("订单状态", this.info),
                    SizedBox(height: ScreenAdaper.height(20)),
                    this._item("订单状态", this.orderInfo)
                ]
            )
        );
    }
}
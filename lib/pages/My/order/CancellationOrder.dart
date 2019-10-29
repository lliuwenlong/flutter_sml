import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../../services/ScreenAdaper.dart';
import '../../../components/AppBarWidget.dart';
import '../../../common/Color.dart';
import '../../../components/FotterButton.dart';
import '../../../common/HttpUtil.dart';
import '../../../components/LoadingSm.dart';

class CancellationOrder extends StatefulWidget {
  final arguments;
  CancellationOrder({Key key, this.arguments}) : super(key: key);

  _CancellationOrderState createState() =>
      _CancellationOrderState(arguments: this.arguments);
}

class _CancellationOrderState extends State<CancellationOrder> {
  final Map arguments;
  _CancellationOrderState({this.arguments});

  List<Widget> _getList(List<Map> list,
      {MainAxisAlignment align = MainAxisAlignment.start}) {
    return list.map((val) {
      return Container(
        margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
        child: Row(mainAxisAlignment: align, children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  width: ScreenAdaper.width(193),
                  child:  Text(val["name"],
                      style: TextStyle(
                          color: ColorClass.titleColor,
                          fontSize: ScreenAdaper.fontSize(28)))
                          ),
              val["num"] != null || val["num"] != ''
                  ? Text(val["num"],
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: ScreenAdaper.fontSize(40)))
                  : Text(''),
            ],
          ),
          Text(val["value"],
              style: TextStyle(
                  color: ColorClass.fontColor,
                  fontSize: ScreenAdaper.fontSize(28)))
        ]),
      );
    }).toList();
  }

  Widget _item(String title, List<Map> list,
      {MainAxisAlignment align = MainAxisAlignment.start}) {
    List<Widget> widgetTitle = [
      Text(title,
          style: TextStyle(
              color: ColorClass.titleColor,
              fontSize: ScreenAdaper.fontSize(32),
              fontWeight: FontWeight.w500))
    ];
    widgetTitle.addAll(this._getList(list, align: align));
    return Container(
        padding: EdgeInsets.all(ScreenAdaper.width(30)),
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgetTitle));
  }
  
  onTapHandler({context}) async {
    
    const Map<String, String> provincesData = {
      "1": "我不想买了",
      "2": "选择错误，重新购买",
      "3": "时间冲突用不了",
      "4":"其他原因"
    };
    const Map<String, dynamic> citiesData = {
      "1": {"11": {}},
      "2": {"22": {}},
      "3": {"33": {}}
    };
    Result result = await CityPickers.showCityPicker(
        context: context,
        height: ScreenAdaper.height(435),
        showType: ShowType.p,
        provincesData: provincesData,
        citiesData: citiesData,
        cancelWidget: Text("取消")
    );

    print(result.provinceName);
  }

  final HttpUtil http = HttpUtil();
  var data;
  bool _isLoading = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(arguments['orderSn']);
    this._getData();
  }

  _getData() async {
    Map response = await this.http.get('/api/v1/order/one', data: {'orderSn': arguments['orderSn']});
    print(response);
    if (response['code'] == 200) {
      setState(() {
        this.data = response['data'];
        this._isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return this._isLoading
        ? Scaffold(
            appBar: AppBarWidget().buildAppBar("我的订单"),
            body: Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(200)),
              child: Loading(),
            ),
          )
        : Scaffold(
            appBar: AppBarWidget().buildAppBar("我的订单"),
            bottomSheet: ((arguments['type'] == 'house' ||
                        arguments['type'] == 'havefun') &&
                    arguments['status'] == '2')||(arguments['type']=='tree'&&arguments['status']=='8')
                ? FotterButton("取消订单", onTapHandler: () {
                    this.onTapHandler(context: context);
                })
                : SizedBox(height: 0,),
            body: ListView(children: <Widget>[
            arguments['type']== 'tree' || arguments['type']== 'house'||arguments['type']== 'havefun'||arguments['type']== 'food'?	this._item(
                  arguments['type'] == 'house'
                      ? '入住凭证'
                      : arguments['type'] == 'havefun' ? '核销信息' : "订单状态",
                  [
                    {
                      'name': arguments['type'] == 'house'
                          ? '凭证号码'
                          : arguments['type'] == 'havefun' ? '核销号码' : "订单状态",
                      'num': data['proofSn'] != null ? data['proofSn'] : '',
                      'value': data['statusTitle']
                    }
                  ],
                  align: MainAxisAlignment.spaceBetween):SizedBox(height: 0,),
              arguments['type'] == 'tree' || arguments['type'] == 'house'
                  ? SizedBox(height: ScreenAdaper.height(20))
                  : SizedBox(
                      height: 0,
                    ),
              arguments['type'] == 'tree' || arguments['type'] == 'house'
                  ? this._item(arguments['type'] == 'tree' ? "神木信息" : '预定信息', [
                      {
                        "name": arguments['type'] == 'tree' ? "神木名称" : '入住人',
                        'num': '',
                        "value": arguments['type'] == 'tree'
                            ? data['wood']['name']
                            : data['houseDetail']['realName']
                      },
                      {
                        "name": arguments['type'] == 'tree' ? "所属基地" : '联系手机',
                        'num': '',
                        "value": arguments['type'] == 'tree'
                            ? data['wood']['baseName']
                            : data['houseDetail']['phone']
                      },
                      {
                        "name": arguments['type'] == 'tree' ? "购买数量" : '入驻时间',
                        'num': '',
                        "value": arguments['type'] == 'tree'
                            ? '${data['wood']['num']}'
                            : '${data['houseDetail']['incomeTime'].substring(0, 11)}入驻 —— ${data['houseDetail']['quiteTime'].substring(0, 11)}离店'
                      }
                    ])
                  : Text(''),
              arguments['type'] == 'tree' || arguments['type'] == 'house'
                  ? SizedBox(height: ScreenAdaper.height(20))
                  : SizedBox(
                      height: 0,
                    ),
              this._item("订单信息", [
                {"name": "订单号", 'num': '', "value": data['orderSn']},
                {"name": "下单时间", 'num': '', "value": data['createTime']},
                {"name": "付款时间", 'num': '', "value": data['payTime']},
                {"name": "支付金额", 'num': '', "value": "¥ ${data['amount']}"},
              ]),

              SizedBox(height: ScreenAdaper.height(20)),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdaper.width(30)),
                child: Row(
                  children: <Widget>[
                    Text('发票',style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: ScreenAdaper.fontSize(28)
                    ),),
                    SizedBox(width: ScreenAdaper.width(148),),
                    Text('如需发票,请向商家索取',style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: ScreenAdaper.fontSize(28)
                    ),)
                  ],
                ),
              )
            ]));
  }
}

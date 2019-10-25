import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/store/shop/Shop.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/api/shop/DistsModel.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/shop/Shop.dart';
import './PurchaseAgreement.dart';
import 'dart:ui';

typedef void OnPay(String type, int number, int regionId);

class Purchase extends StatefulWidget {
    int id;
    double price;
    int baseid;
    String type;
    OnPay onPay;
    Purchase({Key key, this.id, this.price, this.baseid, this.type, this.onPay});
    _PurchaseState createState() => _PurchaseState(
        id: this.id, price: this.price,
        baseid: this.baseid, type: this.type
    );
}

class _PurchaseState extends State<Purchase>  {
    ShopModel cloneShopModel;
    BuildContext _selfContext;
    int id;
    double price;
    List<Data> list = [];
    ShopModel shopModel; 
    int baseid;
    String type;
    _PurchaseState({this.id = 0, Key key, this.price, this.baseid, this.type});
    bool isPay = false;
    String payType = "wx";
    bool isDisabled = false;
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        shopModel = Provider.of<ShopModel>(context);
    }

    @override
    initState () {
        super.initState();
        this._getData();
    }
    _getData () async {
        final response = await HttpUtil().get("/api/v1/wood/${this.type != null ? this.baseid : this.id}/dists");
        if (response["code"] == 200) {
            final DistsModel res = new DistsModel.fromJson(response);
            setState(() {
                this.list = res.data;
                if (response["data"].length > 0) {
                    this.shopModel.setForestTypes(res.data[0].districtId);
                }
            });
        }
    }

    _onPay (ShopModel shopModel) async {
        shopModel.changeIsDisabled(true);
        if (widget.onPay != null) {
            widget.onPay(this.payType, this.shopModel.shopNum, this.shopModel.forestTypes);
        }
    }
    
    Widget _choiceChip (String name, int curStatus, {int status = 0, Function onTapHandler}) {
        bool selected = curStatus == status;
        return Container(
            child: ChoiceChip(
                label: Text(name, style: TextStyle(
                    color: selected ? Color(0XFF22b0a1) : ColorClass.titleColor,
                    fontSize: ScreenAdaper.fontSize(26)
                )),
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(20),
                    ScreenAdaper.width(10),
                    ScreenAdaper.width(20),
                    ScreenAdaper.width(10)
                ),
                selectedColor: Color(0xfff2fffe),
                backgroundColor: Color(0xfff7f7f7),
                onSelected: (bool value) {
                    onTapHandler != null && onTapHandler(curStatus);
                },
                shadowColor: Color.fromRGBO(0, 0, 0, 0),
                selectedShadowColor: Color.fromRGBO(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                    side: BorderSide(color: 
                        selected ? Color(0xFF22b0a1) : Color(0xFFf7f7f7), 
                        width: ScreenAdaper.width(1)
                    ),
                ),
                selected: selected
            )
        );
    }

    Widget _header (String name) {
        return Container(
            padding: EdgeInsets.all(
                ScreenAdaper.width(30)
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: ColorClass.borderColor,
                        width: ScreenAdaper.width(1)
                    )
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Text(name, style: TextStyle(
                        color: ColorClass.fontColor,
                        fontSize: ScreenAdaper.fontSize(30)
                    )),
                    Container(
                        width: ScreenAdaper.width(50),
                        height: ScreenAdaper.width(50),
                        child: IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                                Navigator.pop(_selfContext);
                            },
                            icon: Icon(
                                Icons.close,
                                color: ColorClass.borderColor,
                                size: ScreenAdaper.fontSize(60)
                            )
                        ),
                    )
                    
                ]
            )
        );
    }

    Widget _purchaseQuantity(ShopModel shopModel) {
        return Container(
            child: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(30)
                        ),
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                        top: ScreenAdaper.height(20)
                                    ),
                                    child: Text("树林", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(28),
                                        fontWeight: FontWeight.w500
                                    )),
                                ),
                                SizedBox(width: ScreenAdaper.width(30)),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: Wrap(
                                            spacing: ScreenAdaper.width(20),
                                            children: this.list.map((val) {
                                                return _choiceChip(
                                                    val.districtName,
                                                    val.districtId,
                                                    status: shopModel.forestTypes,
                                                    onTapHandler: (int val) {
                                                        shopModel.setForestTypes(val);
                                                    }
                                                ); 
                                            }).toList(),
                                        )
                                    )
                                )
                            ]
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)
                        ),
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(20)
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("数量", style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(28),
                                    fontWeight: FontWeight.w500
                                )),
                                Container(
                                    height: ScreenAdaper.height(50),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFd9d9d9),
                                            width: 1
                                        )
                                    ),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                            GestureDetector(
                                                child: Container(
                                                    width: ScreenAdaper.height(50),
                                                    height: ScreenAdaper.height(50),
                                                    child: RaisedButton(
                                                        padding: EdgeInsets.all(0),
                                                        elevation: 0,
                                                        highlightColor: Color.fromRGBO(0, 0, 0, 0),
                                                        highlightElevation: 0,
                                                        color: Color.fromRGBO(0, 0, 0, 0),
                                                        onPressed: () {
                                                            shopModel.setShopNum(shopModel.shopNum - 1);
                                                        },
                                                        child: Icon(
                                                            IconData(0xe635, fontFamily: "iconfont"),
                                                            color: shopModel.shopNum == 1 ? Color(0xFFd9d9d9) : ColorClass.fontRed,
                                                            size: ScreenAdaper.fontSize(20),
                                                        )
                                                    )
                                                ),
                                            ),
                                            Container(
                                                height: ScreenAdaper.height(50),
                                                width: ScreenAdaper.width(80),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                            color: Color(0xFFd9d9d9),
                                                            width: 1
                                                        ),
                                                        right: BorderSide(
                                                            color: Color(0xFFd9d9d9),
                                                            width: 1
                                                        )
                                                    )
                                                ),
                                                child: Text("${shopModel.shopNum}", style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: ScreenAdaper.fontSize(30)
                                                ))
                                            ),
                                            Container(
                                                width: ScreenAdaper.height(50),
                                                height: ScreenAdaper.height(50),
                                                child: RaisedButton(
                                                    padding: EdgeInsets.all(0),
                                                    elevation: 0,
                                                    color: Color.fromRGBO(0, 0, 0, 0),
                                                    highlightColor: Color.fromRGBO(0, 0, 0, 0),
                                                    highlightElevation: 0,
                                                    onPressed: () {
                                                        shopModel.setShopNum(shopModel.shopNum + 1);
                                                    },
                                                    child: Icon(
                                                        IconData(0xe634, fontFamily: "iconfont"),
                                                        size: ScreenAdaper.fontSize(20),
                                                        color: ColorClass.fontRed
                                                    )
                                                )
                                            )
                                        ]
                                    )
                                )
                            ]
                        )
                    )
                ]
            ),
        );
    }
    Widget _rowItem (String type) {
        Map<String, Map> icon = {
            "wx": {
                "icon": 0xe622,
                "color": 0xFF00c803,
                "text": "微信支付"
            },
            "zf": {
                "icon": 0xe623,
                "color": 0xFF00a9e9,
                "text": "支付宝支付"
            }
        };
        Map obj = icon[type];
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Row(
                    children: <Widget>[
                        Icon(
                            IconData(obj["icon"], fontFamily: "iconfont"),
                            size: ScreenAdaper.fontSize(40),
                            color: Color(obj["color"]),
                        ),
                        SizedBox(width: ScreenAdaper.width(20)),
                        Text(obj["text"])
                    ]
                ),
                this.payType == type
                ? Icon(IconData(
                    0xe621,
                    fontFamily: "iconfont"
                ), size: ScreenAdaper.fontSize(40), color: Color(0xFFd4746c))
                : GestureDetector(
                    onTap: () {
                        setState(() {
                            this.payType = type;
                        });
                    },
                    child: Container(
                        width: ScreenAdaper.width(40),
                        height: ScreenAdaper.width(40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            color: Color(0xFFf7f7f7),
                            border: Border.all(
                                width: ScreenAdaper.width(2),
                                color: ColorClass.subTitleColor
                            )
                        )
                    )
                )
            ]
        );
    }

    Widget _paymentType () {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            child: Column(
                children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Text("支付金额：", style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(34)
                            )),
                            Text("¥ ${this.shopModel.shopNum * this.price}", style: TextStyle(
                                color: ColorClass.fontRed,
                                fontSize: ScreenAdaper.fontSize(34)
                            )),
                            Text("元", style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(34)
                            )),
                        ],
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdaper.height(30),
                            bottom: ScreenAdaper.height(30)
                        ),
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(10),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorClass.borderColor,
                                    width: ScreenAdaper.width(1)
                                )
                            )
                        ),
                        child: _rowItem("wx")
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdaper.height(30),
                            bottom: ScreenAdaper.height(30)
                        ),
                        child: _rowItem("zf")
                    ),
                    Container(
                        margin:  EdgeInsets.only(
                            top: ScreenAdaper.height(20),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Text("请仔细阅读", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(22),
                                    color: ColorClass.subTitleColor
                                )),
                                GestureDetector(
                                    onTap: () {
                                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                            return PurchaseAgreement();
                                        }));
                                    },
                                    child: Text("神木林购买协议", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(22),
                                        color: ColorClass.common
                                    )),
                                ),
                                Text(",支付代表您接受本协议内容", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(22),
                                    color: ColorClass.subTitleColor
                                ))
                            ]
                        ),
                    )
                ]
            )
        );
    }

    Widget _button ({Function onTap, ShopModel shopModel}) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                ScreenAdaper.height(20),
                ScreenAdaper.width(30),
                ScreenAdaper.height(20)
            ),
            child: Container(
                height: ScreenAdaper.height(88),
                child: RaisedButton(
                    elevation: 0,
                    onPressed: shopModel != null && shopModel.isDisabled ? null : () {
                        onTap != null && onTap();
                    },
                    disabledColor: Color(0xFF86d4ca),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                    ),
                    color: ColorClass.common,
                    child: Text("购买", style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdaper.fontSize(40)
                    ))
                )
            )
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        this._selfContext = context;
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQueryData.fromWindow(window).padding.bottom
            ),
            child: Container(
                width: double.infinity,
                child: Consumer<ShopModel>(
                    builder: (BuildContext context, ShopModel shopModel, child) {
                        this.cloneShopModel = shopModel;
                        return !isPay ? Wrap(
                            children: <Widget>[
                                _header("购买数量"),
                                _purchaseQuantity(shopModel),
                                _button(
                                    onTap: () {
                                        setState(() {
                                            isPay = true;
                                        });
                                    }
                                )
                            ]
                        )
                        :  Wrap(
                            children: <Widget>[
                                _header("确认支付"),
                                _paymentType(),
                                _button(shopModel: shopModel, onTap: () {
                                    _onPay(shopModel);
                                })
                            ]
                        );
                    },
                )
            )
        );
    }
}
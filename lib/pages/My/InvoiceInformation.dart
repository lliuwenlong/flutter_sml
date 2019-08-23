import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
class InvoiceInformation extends StatefulWidget {
    InvoiceInformation({Key key}) : super(key: key);
    _InvoiceInformationState createState() => _InvoiceInformationState();
}

class _InvoiceInformationState extends State<InvoiceInformation> {
    int status = 0;
    Widget _input (String hintText) {
        return TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 1),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: ColorClass.iconColor,
                    fontSize: ScreenAdaper.fontSize(24)
                )
            ),
        );
    }
    Widget _choiceChip (String name, {int status = 0}) {
        bool selected = this.status == status;
        return Container(
            child: ChoiceChip(
                label: Text(name, style: TextStyle(
                    color: selected ? Color(0XFF22b0a1) : ColorClass.titleColor
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
                    setState(() {
                        if (this.status == status) return;
                        this.status = status;
                    });
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
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBarWidget().buildAppBar("提交发票信息"),
            body: Column(
                children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(30),
                            ScreenAdaper.width(30),
                            ScreenAdaper.width(30),
                            ScreenAdaper.width(30)
                        ),
                        child: Text("发票详情", style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(28),
                            fontWeight: FontWeight.w500
                        ))
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(30),
                            0,
                            ScreenAdaper.width(30),
                            0,
                        ),
                        color: Colors.white,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                ScreenAdaper.width(30),
                                0,
                                ScreenAdaper.width(30),
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
                                children: <Widget>[
                                    Container(
                                        width: ScreenAdaper.width(177),
                                        child: Text("抬头类型", style: TextStyle(
                                            color: ColorClass.titleColor,
                                            fontSize: ScreenAdaper.fontSize(28)
                                        ))
                                    ),
                                    this._choiceChip("企业单位", status: 0),
                                    SizedBox(width: ScreenAdaper.width(30)),
                                    this._choiceChip("个人/非企业单位", status: 1)
                                ]
                            )
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(30),
                            0,
                            ScreenAdaper.width(30),
                            0,
                        ),
                        color: Colors.white,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                ScreenAdaper.width(30),
                                0,
                                ScreenAdaper.width(30),
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
                                children: <Widget>[
                                    Container(
                                        width: ScreenAdaper.width(177),
                                        child: Text("发票抬头", style: TextStyle(
                                            color: ColorClass.titleColor,
                                            fontSize: ScreenAdaper.fontSize(28)
                                        ))
                                    ),
                                    Expanded(
                                        child: Container(
                                            child: this._input("请填写发票抬头")
                                        )
                                    )
                                ]
                            )
                        )
                    ),
                    Offstage(
                        offstage: this.status == 1,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(30),
                                0,
                                ScreenAdaper.width(30),
                                0,
                            ),
                            color: Colors.white,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    ScreenAdaper.width(30),
                                    0,
                                    ScreenAdaper.width(30),
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
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(177),
                                            child: Text("税号", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            ))
                                        ),
                                        Expanded(
                                            child: Container(
                                                child: this._input("请填写纳税人识别号")
                                            )
                                        )
                                    ]
                                )
                            )
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/remarksInformation");
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(30),
                                0,
                                ScreenAdaper.width(30),
                                0,
                            ),
                            color: Colors.white,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    ScreenAdaper.width(30),
                                    0,
                                    ScreenAdaper.width(30),
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(177),
                                            child: Text("备注", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            ))
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    Text("请填写备注信息（非必填）", style: TextStyle(
                                                        color: ColorClass.iconColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )),
                                                    Icon(
                                                        IconData(0Xe61e, fontFamily: "iconfont"),
                                                        size: ScreenAdaper.fontSize(24),
                                                        color:  ColorClass.iconColor
                                                    )
                                                ]
                                            ),
                                        )
                                    ]
                                )
                            )
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/invoiceHarvestAddress");
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(20)
                            ),
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(30),
                                0,
                                ScreenAdaper.width(30),
                                0,
                            ),
                            color: Colors.white,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    ScreenAdaper.width(30),
                                    0,
                                    ScreenAdaper.width(30),
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(177),
                                            child: Text("发票收货地址", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            ))
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                    Text("发票收货地址", style: TextStyle(
                                                        color: ColorClass.iconColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )),
                                                    SizedBox(width: ScreenAdaper.width(20)),
                                                    Icon(
                                                        IconData(0Xe61e, fontFamily: "iconfont"),
                                                        size: ScreenAdaper.fontSize(24),
                                                        color:  ColorClass.iconColor
                                                    )
                                                ]
                                            ),
                                        )
                                    ]
                                )
                            )
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/invoiceDetails");
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(20)
                            ),
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(30),
                                0,
                                ScreenAdaper.width(30),
                                0,
                            ),
                            color: Colors.white,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    ScreenAdaper.width(30),
                                    0,
                                    ScreenAdaper.width(30),
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(177),
                                            child: Text("总金额", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            ))
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("¥188.00", style: TextStyle(
                                                            fontSize: ScreenAdaper.fontSize(24),
                                                            color: ColorClass.fontRed
                                                        )),
                                                    ),
                                                    Text("共1张，查看详情", style: TextStyle(
                                                        color: ColorClass.iconColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )),
                                                    SizedBox(width: ScreenAdaper.width(20)),
                                                    Icon(
                                                        IconData(0Xe61e, fontFamily: "iconfont"),
                                                        size: ScreenAdaper.fontSize(24),
                                                        color:  ColorClass.iconColor
                                                    )
                                                ]
                                            ),
                                        )
                                    ]
                                )
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(50)
                        ),
                        height: ScreenAdaper.height(88),
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)
                        ),
                        child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                            ),
                            onPressed: () {
                            },
                            child: Text("提交", style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdaper.fontSize(40)
                            )),
                            color: ColorClass.common,
                        ),
                    )
                ]
            )
        );
    }
}
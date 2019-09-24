import 'package:flutter/material.dart';
import 'package:flutter_sml/routers/routers.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
import '../../model/store/invoice/InvoiceInfo.dart';
class InvoiceInformation extends StatefulWidget {
 
    InvoiceInformation({Key key}) : super(key: key);
    _InvoiceInformationState createState() => _InvoiceInformationState();
}

class _InvoiceInformationState extends State<InvoiceInformation> {
    int status = 0;
    Widget _input (String hintText,TextEditingController controller,Function onChange) {
        return TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 1),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: ColorClass.iconColor,
                    fontSize: ScreenAdaper.fontSize(24)
                ),
            ),
            onChanged: onChange,

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
    TextEditingController _invoiceRiseController = new TextEditingController();//发票抬头
    TextEditingController _dutyParagraphController = new TextEditingController();//税号
    final HttpUtil  http  = HttpUtil();
    User _userModel;
	InvoiceInfo _invoiceModel;
    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      _userModel = Provider.of<User>(context);
	    _invoiceModel = Provider.of<InvoiceInfo>(context);

      this._invoiceRiseController.text = this._invoiceModel.receiptHeader!=null?this._invoiceModel.receiptHeader:null;
      this._dutyParagraphController.text = this._invoiceModel.receiptCode!=null?this._invoiceModel.receiptCode:null;
    }

    _submitData () async {
      	Map response = await this.http.post('/receipt/0/data',params:{
          "address":this._invoiceModel.address,
          "city": this._invoiceModel.city,
          "county": this._invoiceModel.county,
          "orderSns": [
            this._invoiceModel.orderSn
          ],
          "phone": this._invoiceModel.phone,
          "province": this._invoiceModel.province,
          "receiptCode": this._invoiceModel.receiptCode,
          "receiptHeader": this._invoiceModel.receiptHeader,
          "receiverUser": this._invoiceModel.receiverUser,
          "remark": this._invoiceModel.remarks,
          "userId": this._userModel.userId
      	});
      	print(response);
      	if(response['code'] == 200){
          	print(response);
      	}else{
			Fluttertoast.showToast(
				msg: response['msg'],
				toastLength: Toast.LENGTH_SHORT,
				textColor: Colors.white,
				backgroundColor: Colors.black87,
				fontSize: ScreenAdaper.fontSize(30),
				timeInSecForIos: 1,
				gravity: ToastGravity.CENTER
			);
      	}
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
                                            child: this._input(
                                              "请填写发票抬头",
                                              _invoiceRiseController,
                                              (val){
                                                setState(() {
                                                    this._invoiceModel.initInvoiceInfo(
                                                      province: this._invoiceModel.province,
                                                      city: this._invoiceModel.city,
                                                      county: this._invoiceModel.county,
                                                      address: this._invoiceModel.address,
                                                      phone: this._invoiceModel.phone,
                                                      receiverUser: this._invoiceModel.receiverUser,
                                                      amount: this._invoiceModel.amount,
                                                      orderSn: this._invoiceModel.orderSn,
                                                      remarks: this._invoiceModel.remarks,
                                                      receiptCode: this._invoiceModel.receiptCode,
                                                      receiptHeader: this._invoiceRiseController.text
                                                    );
                                                });
                                              },
                                            )
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
                                                child: this._input(
                                                  "请填写纳税人识别号",
                                                  _dutyParagraphController,
                                                  (val){
                                                    setState(() {
                                                        this._invoiceModel.initInvoiceInfo(
                                                          province: this._invoiceModel.province,
                                                          city: this._invoiceModel.city,
                                                          county: this._invoiceModel.county,
                                                          address: this._invoiceModel.address,
                                                          phone: this._invoiceModel.phone,
                                                          receiverUser: this._invoiceModel.receiverUser,
                                                          amount: this._invoiceModel.amount,
                                                          orderSn: this._invoiceModel.orderSn,
                                                          remarks: this._invoiceModel.remarks,
                                                          receiptCode: this._dutyParagraphController.text,
                                                          receiptHeader: this._invoiceModel.receiptHeader
                                                        );
                                                    });
                                                  },
                                                )
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
                                                  	this._invoiceModel.remarks == null? Text('请填写备注信息(非必填)', style: TextStyle(
                                                        color: ColorClass.iconColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )):Text(
                                                    this._invoiceModel.remarks,
                                                    style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: ScreenAdaper.fontSize(30)
                                                    ),
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
                                                  this._invoiceModel.province==null? Text("发票收货地址", style: TextStyle(
                                                        color: ColorClass.iconColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )):Text("${this._invoiceModel.province}${this._invoiceModel.city}${this._invoiceModel.county}${this._invoiceModel.address}", style: TextStyle(
                                                        color: ColorClass.fontColor,
                                                        fontSize: ScreenAdaper.fontSize(30)
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
                            Navigator.pushNamed(context, "/invoiceDetails",arguments: {
                              'amount':this._invoiceModel.amount
                            });
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
                                                        child: Text("¥${this._invoiceModel.amount}", style: TextStyle(
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
                              if(this._dutyParagraphController.text==null||this._dutyParagraphController.text==''||this._invoiceRiseController.text==null||this._invoiceRiseController.text==''){
                                Fluttertoast.showToast(
                                  msg: '信息填写不完整',
                                  toastLength: Toast.LENGTH_SHORT,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.black87,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  fontSize: ScreenAdaper.fontSize(30)
                                );
                                return;
                              }
                             
                              this._submitData();
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
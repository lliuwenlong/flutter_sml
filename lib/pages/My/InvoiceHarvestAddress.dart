import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../model/store/invoice/InvoiceInfo.dart';

class InvoiceHarvestAddress extends StatefulWidget {

  InvoiceHarvestAddress({Key key}) : super(key: key);

  _InvoiceHarvestAddressState createState() => _InvoiceHarvestAddressState();
}

class _InvoiceHarvestAddressState extends State<InvoiceHarvestAddress> {
    Result result;
    String addr;
    Widget _rowItem(String name, String hintText, TextEditingController controller,{int maxLines = 1, bool isBorder = true}) {
        return Container(
            alignment: Alignment.topLeft,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                0,
                ScreenAdaper.width(30),
                0
            ),
            child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(30),
                    0,
                    ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: isBorder ? BorderSide(
                            color: ColorClass.borderColor,
                            width: ScreenAdaper.width(1)
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(177),
                            child: Text(name, style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(28)
                            ))
                        ),
                        Expanded(
                            flex: 1,
                            child: TextField(
                                maxLines: maxLines,
                                keyboardAppearance: Brightness.light,
                                decoration: InputDecoration(
                                    hintText: hintText,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 1),
                                    hintStyle: TextStyle(
                                        color: ColorClass.iconColor,
                                        fontSize: ScreenAdaper.fontSize(24),
                                    ),
                                    border: InputBorder.none,
                                ),
                                controller: controller,
                            )
                        )
                    ]
                )
            )
        );
    }

    Widget _rowItemII(String name, String hintText,BuildContext context) {
        return Container(
            alignment: Alignment.topLeft,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                0,
                ScreenAdaper.width(30),
                0
            ),
            child: GestureDetector(
              onTap: () async {
                this.result = await CityPickers.showFullPageCityPicker(
                    context: context
                );
                this.addr = this.result!=null?'${this.result.provinceName} ${this.result.cityName} ${this.result.areaName}':null;
              },
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(30),
                    0,
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
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(177),
                            child: Text(name, style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(28)
                            ))
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                   addr!=null?Text(
                                    addr,
                                    style: TextStyle(
                                      color: ColorClass.fontColor,
                                      fontSize: ScreenAdaper.fontSize(30)
                                    )
                                  ): Text(hintText, style: TextStyle(
                                        color: ColorClass.iconColor,
                                        fontSize: ScreenAdaper.fontSize(24)
                                    )),
                                    Icon(IconData(
                                        0xe61e,
                                        fontFamily: "iconfont"
                                    ), size: ScreenAdaper.fontSize(24), color: ColorClass.iconColor)
                                ]
                            )
                        )
                    ]
                ),
            )
            )
        );
    }

    TextEditingController _nameController = new TextEditingController();
    TextEditingController _phoneController = new TextEditingController();
    TextEditingController _addressController = new TextEditingController();
    InvoiceInfo _invoiceModel;
    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      _invoiceModel = Provider.of<InvoiceInfo>(context);
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("发票收货地址"),
            body: Column(
                children: <Widget>[
                    this._rowItem("收货人", "请输入收货人姓名",_nameController),
                    this._rowItem("电话", "收货人的电话，方便联系",_phoneController),
                    this._rowItemII("地址", "请选择地址",context),
                    this._rowItem("详细地址", "请输入街道、门牌号等详细信息",_addressController, maxLines: 3, isBorder: false),
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
                              if(this.result == null || this._nameController.text ==null || this._nameController.text =='' || this._phoneController.text == null || this._phoneController.text == '' || this._addressController.text == null || this._addressController.text == ''){
                                  Fluttertoast.showToast(
                                    msg: '信息填写不完整',
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.white,
                                    timeInSecForIos: 1,
                                    fontSize: ScreenAdaper.fontSize(30),
                                    gravity: ToastGravity.CENTER
                                  );
                                  return;
                              }
                              RegExp exp = RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
                              if (!exp.hasMatch(this._phoneController.text)) {
                                  Fluttertoast.showToast(
                                    msg: '手机号格式错误',
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.white,
                                    timeInSecForIos: 1,
                                    fontSize: ScreenAdaper.fontSize(30),
                                    gravity: ToastGravity.CENTER
                                  );
                                  return;
                              }
                              Navigator.pushReplacementNamed(context, '/invoiceInformation');
                              this._invoiceModel.initInvoiceInfo(
                                province: this.result.provinceName,
                                city: this.result.cityName,
                                county: this.result.areaName,
                                address: this._addressController.text,
                                phone: this._phoneController.text,
                                receiverUser: this._nameController.text,
                                amount: this._invoiceModel.amount,
                                orderSn: this._invoiceModel.orderSn,
                                remarks: this._invoiceModel.remarks
                              );
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



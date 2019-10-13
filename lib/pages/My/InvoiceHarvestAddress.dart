import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../model/store/invoice/InvoiceInfo.dart';
class InvoiceHarvestAddress extends StatefulWidget {
final arguments;
  InvoiceHarvestAddress({Key key,this.arguments}) : super(key: key);

  _InvoiceHarvestAddressState createState() => _InvoiceHarvestAddressState(arguments:arguments);
}

class _InvoiceHarvestAddressState extends State<InvoiceHarvestAddress> {
	final arguments;
    Result result;
	String addr;
	_InvoiceHarvestAddressState({this.arguments});
    Widget _rowItem(String name, String hintText, TextEditingController controller,String type,{int maxLines = 1, bool isBorder = true}) {
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
								onChanged: (value){
									if (type == 'name') {
										setState(() {
										   _nameInputText = value;
										});
									}else if (type=='phone') {
										setState(() {
										  	_phoneInputText = value;
										});
									}else{
										setState(() {
										   _addressInputText = value;
										});
									}
									this._invoiceModel.initInvoiceInfo(
										province: this._province,
										city: this._city,
										county: this._country,
										address: _addressInputText,
										phone: _phoneInputText,
										receiverUser: _nameInputText,
										amount: this._invoiceModel.amount,
										orderSn: this._invoiceModel.orderSn,
										remarks: this._invoiceModel.remarks
                					);
								},
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
						context: context,
						theme: Theme.of(context).copyWith(primaryColor: Color(0xff22b0a1)),
					);
					setState(() {
						this.addr = '${this.result.provinceName} ${this.result.cityName} ${this.result.areaName}';
					});
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
                                   	Expanded(
										   child: this.addr!=null?Text(
                                   	 	this.addr,
										style: TextStyle(
											color: ColorClass.fontColor,
											fontSize: ScreenAdaper.fontSize(30)
										),
										overflow: TextOverflow.ellipsis,
										): Text(hintText, style: TextStyle(
											color: ColorClass.iconColor,
											fontSize: ScreenAdaper.fontSize(24)
										)),
									   ),
									   SizedBox(width: ScreenAdaper.width(4),),
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

    InvoiceInfo _invoiceModel;
	String _province;
	String _city;
	String _country;
	String _nameInputText;
	String _phoneInputText;
	String _addressInputText;

    @override
    void didChangeDependencies() {
		super.didChangeDependencies();
		_invoiceModel = Provider.of<InvoiceInfo>(context);
		if(this.result==null){
	  		this.addr =_invoiceModel.province!=null? '${_invoiceModel.province} ${_invoiceModel.city} ${_invoiceModel.county}':'';
			setState(() {
			  	this._province = _invoiceModel.province;
				this._city = _invoiceModel.city;
				this._country = _invoiceModel.county;
			});
		}else{
	  		this.addr = '${this.result.provinceName} ${this.result.cityName} ${this.result.areaName}';
			setState(() {
			  	this._province = this.result.provinceName;
				this._city = this.result.cityName;
				this._country = this.result.areaName;
			});
		}
    }
	@override
  void initState() {
    // TODO: implement initState
    super.initState();
	_nameInputText = this.arguments['name']!=null?this.arguments['name']:'';
	_phoneInputText = this.arguments['phone']!=null?this.arguments['phone']:'';
	_addressInputText = this.arguments['address']!=null?this.arguments['address']:'';


  }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
		TextEditingController _nameController = new TextEditingController.fromValue(
        TextEditingValue(
            text: _nameInputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _nameInputText.length))));
		TextEditingController _phoneController = new TextEditingController.fromValue(
        TextEditingValue(
            text: _phoneInputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _phoneInputText.length))));;
		TextEditingController _addressController = new TextEditingController.fromValue(
        TextEditingValue(
            text: _addressInputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _addressInputText.length))));;
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("发票收货地址"),
            body: Column(
                children: <Widget>[
                    this._rowItem("收货人", "请输入收货人姓名",_nameController,'name'),
                    this._rowItem("电话", "收货人的电话，方便联系",_phoneController,'phone'),
                    this._rowItemII("地址", "请选择地址",context),
                    this._rowItem("详细地址", "请输入街道、门牌号等详细信息",_addressController,'address', maxLines: 3, isBorder: false),
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
                              	if(this.addr == null ||_nameController.text == null || _nameController.text =='' || _phoneController.text == null || _phoneController.text == '' || _addressController.text == null || _addressController.text == ''){
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
                              	if (!exp.hasMatch(_phoneController.text)) {
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
                              	Navigator.pop(context, '/invoiceInformation');
                              	this._invoiceModel.initInvoiceInfo(
									province: this._province,
									city: this._city,
									county: this._country,
									address: _addressController.text,
									phone: _phoneController.text,
									receiverUser: _nameController.text,
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



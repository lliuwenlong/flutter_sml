import 'package:flutter/material.dart';

class InvoiceInfo  with ChangeNotifier{
    
    String _province;//省
    String _city;//市
    String _county;//区
    String _address;//详细地址
    String _phone;//手机号
    String _receiverUser;//收货人
    String _remarks;//备注
    String _orderSn;//订单号
    String _amount;//订单金额


    String get province => _province;
    String get city => _city;
    String get county => _county;
    String get address => _address;
    String get phone => _phone;
    String get receiverUser => _receiverUser;
    String get remarks => _remarks;
    String get orderSn => _orderSn;
    String get amount => _amount;

    initInvoiceInfo(
        {String province,
        String city,
        String county,
        String address,
        String phone,
        String receiverUser,
        String remarks,
        String orderSn,
        String amount,
        }) {
        this._province = province;
        this._city = city;
        this._county = county;
        this._address = address;
        this._phone = phone;
        this._receiverUser = receiverUser;
        this._remarks = remarks;
        this._orderSn = orderSn;
        this._amount = amount;
    }

}
import 'package:flutter/material.dart';

class User  with ChangeNotifier{
    int _userId;
    String _userName;
    String _phone;
    String _password;
    String _headerImage;
    String _nickName;
    String _createTime;


    int get userId => _userId;
    String get userName => _userName;
    String get phone => _phone;
    String get password => _password;
    String get headerImage => _headerImage;
    String get nickName => _nickName;
    String get createTime => _createTime;

    initUser(
        {int userId,
        String userName,
        String phone,
        String password,
        String headerImage,
        String nickName,
        String createTime}) {
        this._userId = userId;
        this._userName = userName;
        this._phone = phone;
        this._password = password;
        this._headerImage = headerImage;
        this._nickName = nickName;
        this._createTime = createTime;
    }

}
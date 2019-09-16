import 'package:flutter/material.dart';

class ShopModel with ChangeNotifier {
    int _forestTypes = 1;
    int _shopNum = 1;

    List<Map> _forestList = [
        {"id": 1, "name": "莘莘学子林"},
        {"id": 2, "name": "相思林"},
        {"id": 3, "name": "云屯自然生态林"}
    ];

    int get forestTypes => _forestTypes;
    int get shopNum => _shopNum;
    List<Map> get forestList => _forestList;

    void setForestTypes (int val) {
        this._forestTypes = val;
        notifyListeners();
    }

    void setShopNum (int num) {
        if (num < 1) {
            return null;
        }
        this._shopNum = num;
        notifyListeners();
    }

    void setForestList (List<Map> forestList) {
        this._forestList = forestList;
        notifyListeners();
    }
}
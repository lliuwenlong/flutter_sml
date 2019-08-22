import 'package:flutter/material.dart';
import '../pages/tabs/TabBars.dart';
import '../pages/Base/Base.dart';
import '../pages/Coupon/Coupon.dart';
import '../pages/Restaurant/Restaurant.dart';
import '../pages/Entertainment/Entertainment.dart';
import '../pages/Accommodation/Accommodation.dart';
import '../pages/Login/Login.dart';
import '../pages/Login/Register.dart';
import '../pages/Login/RetrieveAccount.dart';
import '../pages/Base/BaseList.dart';
import '../pages/Base/BaseDetails.dart';
import '../pages/Trip/Trip.dart';
import '../pages/Restaurant/RestaurantDetails.dart';
import '../pages/Restaurant/ReleaseEvaluate.dart';
import '../pages/My/Product.dart';
import '../pages/My/PurchaseRecord.dart';
import '../pages/My/Order.dart';

final Map routes = {
    '/': (context) => TabBars(),
    '/base': (context) => Base(),
    '/coupon': (context) => Coupon(),
    '/restaurant': (context) => Restaurant(),
    '/restaurantDetails': (context) => RestaurantDetails(),
    '/entertainment': (context) => Entertainment(),
    '/accommodation':  (context) => Accommodation(),
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/retrieveAccount': (context) => RetrieveAccount(),
    '/baseList': (context) => BaseList(),
    '/baseDetails': (context) => BaseDetails(),
    '/trip': (context) => Trip(),
    '/releaseEvaluate': (context) => ReleaseEvaluate(),
    '/product': (context) => Product(),
    '/purchaseRecord':  (context) => PurchaseRecord(),
    '/order': (context) => Order()
};

var onGenerateRoute = (RouteSettings settings) {
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
            if (settings.arguments != null) {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context,
                    arguments: settings.arguments));
            return route;
        } else {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
            return route;
        }
    }
};
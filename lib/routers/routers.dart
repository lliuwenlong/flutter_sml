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
import '../pages/My/Setting.dart';//设置
import '../pages/My/ChangePwd.dart';//修改密码
import '../pages/My/FeedBack.dart';//意见反馈
import '../pages/My/AboutUs.dart';//关于我们
import '../pages/My/Introduction.dart';//公司简介
import '../pages/News/SystemMessage.dart';//系统消息
import '../pages/News/NewsDetail.dart'; //消息详情
import '../pages/News/ActivityMessage.dart';//活动公告
import '../pages/News/OtherMessage.dart';//其他消息
import '../pages/My/Authentication.dart';
import '../pages/My/Invoice.dart';
import '../pages/My/ContactCustomerService.dart';
import '../pages/My/InvoiceInformation.dart';
import '../pages/My/RemarksInformation.dart';
import '../pages/My/InvoiceHarvestAddress.dart';
import '../pages/My/InvoiceDetails.dart';

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
    '/order': (context) => Order(),
    '/setting': (context) => Setting(),
    '/changePwd': (context) => ChangePwd(),
    '/feedBack': (context) => FeedBack(),
    '/about': (context) => AboutUs(),
    '/introduction': (context) => Introduction(),
    '/systemMessage': (context,{arguments}) => SystemMessage(arguments:arguments),
    '/newsDetail': (context,{arguments}) => NewsDetail(arguments:arguments),
    '/activityMessage': (context,{arguments}) => ActivityMessage(arguments:arguments),
    '/otherMessage': (context,{arguments}) => OtherMessage(arguments:arguments),
    '/authentication': (context) => Authentication(),
    '/invoice': (context) => Invoice(),
    '/contactCustomerService': (context) => ContactCustomerService(),
    '/invoiceInformation': (context) => InvoiceInformation(),
    '/remarksInformation': (context) => RemarksInformation(),
    '/invoiceHarvestAddress': (context) => InvoiceHarvestAddress(),
    '/invoiceDetails': (context) => InvoiceDetails()
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
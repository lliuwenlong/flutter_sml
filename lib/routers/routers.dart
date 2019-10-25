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
import '../pages/My/UserInfo.dart';//个人信息
import '../pages/My/ChangeNickName.dart';//修改昵称
import '../pages/My/MyWallet.dart';// 我的钱包
import '../pages/My/CashOut.dart';//提现
import '../pages/My/InvoiceHistory.dart';
import '../pages/My/InvoiceHistoryDetails.dart';
import '../pages/My/InvoiceSee.dart';
import '../pages/FriendDynamics/Comment.dart';
import '../pages/FriendDynamics/Report.dart';
import '../pages/FriendDynamics/Release.dart';
import '../pages/FriendDynamics/FriendInformation.dart';
import '../pages/My/AiCustomerService.dart';//AI客服
import '../pages/My/FollowOrFans.dart';//关注 粉丝
import '../pages/My/ProductDetail.dart';//神木详情
import '../pages/My/GrowthRecord.dart';//成长记录
import '../pages/My/OutputRecord.dart';//产值记录
import '../pages/My/TransferRecord.dart';//转让记录
import '../pages/My/Transfer.dart'; //转让
import '../pages/My/ValueAddedServices.dart';//增值服务
import '../pages/My/ValueDetail.dart';//增值服务 详情
import '../pages/My/order/CancellationOrder.dart'; // 我的订单
import '../pages/My/order/Acknowledgement.dart'; // 订单确认
// import '../pages/My/myDynamics/MyDynamics.dart'; // 我的
import '../pages/tabs/Shop.dart'; // 商城
import '../pages/Shop/ShenmuDetails.dart'; // 商品详情页
import '../pages/My/MyDynamics.dart';//我的动态
import '../pages/Restaurant/Payment.dart';//餐饮 付款
import '../pages/Accommodation/AccommodationDetal.dart'; // 住宿页面
import '../pages/Accommodation/PlaceOrder.dart'; // 订单确认
import '../pages/My/MyCode.dart';//我的二维码
import '../pages/Coupon/ChooseCoupon.dart';//选择优惠券
import '../pages/Restaurant/BusinessQualification.dart';//商家资质
import '../pages/Restaurant/MerchantAlbum.dart';

final Map routes = {
    '/': (context) => TabBars(),
    '/tabBars': (context) => TabBars(),
    '/base': (context) => Base(),
    '/shop': (context) => ShopPage(),
    '/coupon': (context) => Coupon(),
    '/restaurant': (context, {arguments}) => Restaurant(arguments: arguments),
    '/restaurantDetails': (context, {arguments}) => RestaurantDetails(),
    '/entertainment': (context) => Entertainment(),
    '/accommodation':  (context) => Accommodation(),
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/retrieveAccount': (context) => RetrieveAccount(),
    '/baseList': (context, {arguments}) => BaseList(arguments: arguments),
    '/baseDetails': (context,{arguments}) => BaseDetails(arguments:arguments),
    '/trip': (context) => Trip(),
    '/releaseEvaluate': (context, {arguments}) => ReleaseEvaluate(arguments: arguments),
    '/product': (context,{arguments}) => Product(arguments:arguments),
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
    '/remarksInformation': (context,{arguments}) => RemarksInformation(arguments:arguments),
    '/invoiceHarvestAddress': (context,{arguments}) => InvoiceHarvestAddress(arguments:arguments),
    '/invoiceDetails': (context,{arguments}) => InvoiceDetails(arguments:arguments),
    '/userInfo': (context,{arguments}) => UserInfo(arguments:arguments),
    '/changeNickName': (context,{arguments}) => ChangeNickName(arguments:arguments),
    '/myWallet': (context) => MyWallet(),
    '/cashOut': (context) => CashOut(),
    '/invoiceHistory': (context) => InvoiceHistory(),
    '/invoiceHistoryDetails': (context,{arguments}) => InvoiceHistoryDetails(arguments:arguments),
    '/invoiceSee': (context,{arguments}) => InvoiceSee(arguments:arguments),
    '/friendDynamicsComment': (context, {arguments}) => FriendDynamicsComment(arguments: arguments),
    '/friendDynamicsReport': (context, {arguments}) => FriendDynamicsReport(arguments: arguments),
    '/friendDynamicsRelease': (context) => FriendDynamicsRelease(),
    '/friendInformation': (context, {arguments}) => FriendInformation(arguments: arguments),
    '/aiCustomerService': (context) => AiCustomerService(),
    '/followOrFans': (context, {arguments}) => FollowOrFans(arguments: arguments),
    '/productDetail': (context, {arguments}) => ProductDetail(arguments: arguments),
    '/growthRecord': (context, {arguments}) => GrowthRecord(arguments: arguments),
    '/outputRecord': (context, {arguments}) => OutputRecord(arguments: arguments),
    '/transferRecord': (context, {arguments}) => TransferRecord(arguments: arguments),
    '/transfer': (context,{arguments}) => Transfer(arguments: arguments),
    '/valueAddedServices': (context,{arguments}) => ValueAddedServices(arguments:arguments),
    '/valueDetail': (context, {arguments}) => ValueDetail(arguments: arguments),
    '/cancellationOrder': (context, {arguments}) => CancellationOrder(arguments: arguments),
    '/acknowledgement': (context, {arguments}) => Acknowledgement(arguments: arguments),
    '/shenmuDetails': (context, {arguments}) => ShenmuDetails(arguments: arguments),
    '/valueDetail': (context,{arguments}) => ValueDetail(arguments:arguments),
    '/myDynamics': (context) => MyDynamics(),
    '/payment': (context,{arguments}) => Payment(arguments:arguments),
    '/accommodationDetal': (context) => AccommodationDetal(),
    '/placeOrder': (context, {arguments}) => PlaceOrder(arguments: arguments),
    '/myCode': (context,{arguments}) => MyCode(arguments:arguments),
    '/chooseCoupon': (context,{arguments}) => ChooseCoupon(arguments:arguments),
    '/businessQualification':(context,{arguments}) => BusinessQualification(arguments:arguments),
    '/merchantAlbum': (context,{arguments}) => MerchantAlbum(arguments:arguments)
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
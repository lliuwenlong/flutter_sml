import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_sml/components/Loading.dart';
import 'package:flutter_sml/model/api/user/UserModel.dart';
import 'package:flutter_sml/model/store/invoice/InvoiceInfo.dart';
import 'package:flutter_sml/pages/Login/Login.dart';
import 'package:flutter_sml/pages/tabs/TabBars.dart';
import 'package:flutter_sml/services/ScreenAdaper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './routers/routers.dart';
import 'model/store/shop/Shop.dart';
import 'model/store/user/User.dart';
import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import './common/HttpUtil.dart';
import './components/AppFuncBrowse.dart';
import 'package:amap_location/amap_location.dart';

void main() {
    // 强制竖屏
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
    ]);
    //高德地图
    AMapLocationClient.setApiKey("022af4564933e753fc99559734e3edfe");
    runApp(
        MultiProvider(
            providers: [
                ChangeNotifierProvider.value(value: ShopModel()),
                ChangeNotifierProvider.value(value: User()),
                ChangeNotifierProvider.value(value: InvoiceInfo()),

            ],
            child: MyApp()
        )
    );
    if (Platform.isAndroid) {
        // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}


class _MyAppState extends State<MyApp>  {
    int userId;
    bool isLoading = true;
    HttpUtil http = HttpUtil();
    User userModel;

    void initState() {
        super.initState();
        _initFluwx();
    }

    void didChangeDependencies() {
        super.didChangeDependencies();
        userModel = Provider.of<User>(context);
    }

    _initFluwx() async {
        await fluwx.register(
            appId: "wx44dec623dc2c028b",
            doOnAndroid: true,
            doOnIOS: false,
            enableMTA: false);
        var result = await fluwx.isWeChatInstalled();
        await getUserId();
    }

    getUserId () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.getInt("userId");
        if (userId != null) {
            await this.getData(userId);
            setState(() {
                this.userId = userId;
                this.isLoading = false;
            });
        } else {
            setState(() {
                this.userId = userId;
                this.isLoading = false;
            });
        }        
    }

    getData (int userId) async {
        Map response = await http.get("/api/v11/user/${userId}");
        if (response["code"] == 200) {
            UserModel userModel = new UserModel.fromJson(response);
            Data data = userModel.data;
            this.userModel.initUser(
                userId: data.userId,
                userName: data.userName,
                phone: data.phone,
                password: data.password,
                headerImage:data.headerImage,
                nickName: data.nickName,
                createTime: data.createTime
            );
        }
        
    }

    @override
    Widget build(BuildContext context) {
        // this.userId == null ? LoginPage() : TabBars(),
        // AppFuncBrowse(),
        return RefreshConfiguration(
            headerTriggerDistance: 80.0, 
            footerTriggerDistance: -80,
            maxUnderScrollExtent: 80.0,
            enableBallisticLoad: false,
            hideFooterWhenNotFull: true,
            springDescription: SpringDescription(stiffness: 170, damping: 20, mass: 1.9), 
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                // initialRoute: '/logo',
                home: isLoading
                    ? LoadingWidget()
                    : this.userId == null ? LoginPage() : TabBars(),
                onGenerateRoute: onGenerateRoute,
                showPerformanceOverlay: false,
                theme: ThemeData(
                    splashColor: Color.fromARGB(0, 0, 0, 0)
                ),
                localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                    const Locale('zh', 'CH'),
                    const Locale('en', 'US'),
                ]
            )
        );
    }
}



class LoadingWidget extends StatelessWidget {
    LoadingWidget({Key key});
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Loading(),
            ),
        );
    }
}
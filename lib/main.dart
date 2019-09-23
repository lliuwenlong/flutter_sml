import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_sml/model/store/invoice/InvoiceInfo.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './routers/routers.dart';
import 'model/store/shop/Shop.dart';
import 'model/store/user/User.dart';
import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
    // 强制竖屏
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
    ]);
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

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return RefreshConfiguration(
            headerTriggerDistance: 80.0, 
            footerTriggerDistance: -80,
            maxUnderScrollExtent: 80.0,
            enableBallisticLoad: false,
            hideFooterWhenNotFull: true,
            springDescription: SpringDescription(stiffness: 170, damping: 20, mass: 1.9), 
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/login',
                onGenerateRoute: onGenerateRoute,
                showPerformanceOverlay: false,
                theme: ThemeData(
                    splashColor: Color.fromARGB(0, 0, 0, 0)
                ),
                localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                    const Locale('zh', 'CH'),
                ],
            )
        );
    }
}


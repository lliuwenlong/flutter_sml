import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './routers/routers.dart';
import 'model/store/shop/Shop.dart';

void main() {
    // 强制竖屏
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
    ]);
    runApp(
        MultiProvider(
            providers: [
                ChangeNotifierProvider.value(value: ShopModel())
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
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: onGenerateRoute,
            showPerformanceOverlay: false,
            theme: ThemeData(
                splashColor: Color.fromARGB(0, 0, 0, 0)
            )
        );
    }
}


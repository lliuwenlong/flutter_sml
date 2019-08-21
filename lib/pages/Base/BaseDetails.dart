import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
class BaseDetails extends StatelessWidget {
    const BaseDetails({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("基地详情"),
            body: Text("基地详情全是html到时候使用数据渲染"),
        );
    }
}
import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
class Trip extends StatelessWidget {
    const Trip({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("神木出行"),
            body: Text("html等待数据渲染")
        );
    }
}
import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../common/Config.dart';
import '../../components/LoadingSm.dart';

class BaseDetails extends StatelessWidget {
    final arguments;

    const BaseDetails({Key key, this.arguments}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("基地详情"),
            body: SafeArea(
            bottom: true,
            child: arguments == null
                ? Container(
                        margin: EdgeInsets.only(top: ScreenAdaper.height(200)),
                        child: Loading(),
                    )
                : Container(
                    child: Container(
                        child: InAppWebView(
                            initialUrl:
                                "${Config.WEB_URL}/app/#/baseDetails?sid=${arguments['sid']}",
                            ),
                        ),
                    )
                )
        );
    }
}

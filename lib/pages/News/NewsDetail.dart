import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../model/api/news/NoticeApiModel.dart';
import '../../common/Config.dart';
class NewsDetail extends StatefulWidget {
    final  Map arguments;
    NewsDetail({Key key,this.arguments}) : super(key: key);
    _NewsDetailState createState() => _NewsDetailState(arguments:this.arguments);
}

class _NewsDetailState extends State<NewsDetail> {
    Map arguments;
    NoticeDataApiModel data;
    _NewsDetailState({arguments}) {
        this.arguments = arguments;
        this.data = arguments["data"];
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Scaffold(
                appBar: AppBarWidget().buildAppBar('${arguments["appTabName"]}'),
                body: Container(
                    child: InAppWebView(
                        initialUrl: "${Config.WEB_URL}/app#/?id=${this.data.noticeId}",
                    ),
                )
            ),
        );
    }
}
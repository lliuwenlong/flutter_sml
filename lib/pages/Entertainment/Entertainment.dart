import 'package:flutter/material.dart';
import '../../components/CommonListItem.dart';
import '../../services/ScreenAdaper.dart';

class Entertainment extends StatefulWidget {
    Entertainment({Key key}) : super(key: key);
    _EntertainmentState createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("神木娱乐", style: TextStyle(
                    color: Colors.black,
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                    return CommonListItem(
                        "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                        "神木汗蒸",
                        "古法养生",
                        "贵州省黔西南布依族苗族自治州兴义市鲁",
                        76,
                        "<500"
                    );
                },
            ),
        );
    }
}

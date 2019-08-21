import 'package:flutter/material.dart';
import '../../components/CommonListItem.dart';
import '../../services/ScreenAdaper.dart';

class Restaurant extends StatefulWidget {
    Restaurant({Key key}) : super(key: key);
    _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("神木餐饮", style: TextStyle(
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
                    return GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/restaurantDetails");
                        },
                        child: CommonListItem(
                            "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                            "边屯酒家",
                            "海鲜自助餐",
                            "贵州省黔西南布依族苗族自治州兴义市鲁",
                            76,
                            "<500"
                        )
                    );
                },
            ),
        );
    }
}

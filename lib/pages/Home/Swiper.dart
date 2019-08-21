import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdaper.dart';

class SwiperComponent extends StatefulWidget {
    SwiperComponent({Key key}) : super(key: key);
    _SwiperComponentState createState() => _SwiperComponentState();
}

class _SwiperComponentState extends State<SwiperComponent> {
    List<Map> bannerList = [
        {"url": 'https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws'},
        {"url": 'https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws'},
        {"url": 'https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws'},
        {"url": 'https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws'}
    ];

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            margin: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
            child: AspectRatio(
                aspectRatio: 5 / 2,
                child: Swiper(
                    itemBuilder: (BuildContext context,int index){
                        return Container(
                            height: ScreenAdaper.height(276),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                image: DecorationImage(
                                    image: NetworkImage(bannerList[index]['url']),
                                    fit: BoxFit.cover
                                )
                            )
                        );
                    },
                    itemCount: bannerList.length, 
                    pagination: new SwiperPagination()
                ),
            )
        );
    }
}
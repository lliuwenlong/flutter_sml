import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/HttpUtil.dart';
import '../../common/Config.dart';
import '../../model/api/home/BannerModel.dart';

class SwiperComponent extends StatefulWidget {
    SwiperComponent({Key key}) : super(key: key);
    _SwiperComponentState createState() => _SwiperComponentState();
}

class _SwiperComponentState extends State<SwiperComponent> {
    List<Map> bannerList = [
        {"url": "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"},
        {"url": "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"},
        {"url": "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"},
        {"url": "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"},
        {"url": "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"},
        {"url": "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"}
    ];

    @override
    void initState() {
        super.initState();
    }

    _getBannerList() async {
        Map<String, dynamic> response = await HttpUtil().get("/api/v1/banner/index");
        BannerModel.fromJson(response);
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            margin: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                ScreenAdaper.width(10),
                ScreenAdaper.width(30),
                0
            ),
            child: AspectRatio(
                aspectRatio: 5 / 2,
                child: Swiper(
                    autoplay: true,
                    itemBuilder: (BuildContext context,int index){
                        String url = this.bannerList[index]["url"];
                        return Container(
                            height: ScreenAdaper.height(276),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                child: Image.network(
                                    url,
                                    fit: BoxFit.cover
                                ),
                            )
                        );
                    },
                    onTap: (int index) {
                        this._getBannerList();
                    },
                    itemCount: bannerList.length, 
                    pagination: new SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                            activeColor: Colors.white,
                            space: 5,
                            size: 8,
                            activeSize: 12
                        )
                    )
                ),
            )
        );
    }
}
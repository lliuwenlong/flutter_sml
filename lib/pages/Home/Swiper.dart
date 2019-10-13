
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/home/BannerModel.dart';
import '../../common/HttpUtil.dart';

class SwiperComponent extends StatefulWidget {
    SwiperComponent({Key key}) : super(key: key);
    _SwiperComponentState createState() => _SwiperComponentState();
}

class _SwiperComponentState extends State<SwiperComponent> {
    
final HttpUtil http = HttpUtil();
    List bannerList = [];
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _getData();
    }
    _getData () async {
        Map response = await this.http.get('/api/v1/banner/index');  
        if (response['code'] == 200) {
            setState(() {
                this.bannerList = response['data'];
            });
        }
    }
    @override
    void initState() {
        super.initState();
    }

    _getBannerList() async {
        Map<String, dynamic> response = await HttpUtil().get("/api/v1/banner/index");
        print(response);
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
                child: bannerList.length != 0 ? Swiper(
                    autoplay: true,
                    itemBuilder: (BuildContext context,int index){
                        String url = this.bannerList[index]["imageUrl"];
                        return Container(
                            height: ScreenAdaper.height(276),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                            ),
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
                        // this._getBannerList();
                    },
                    itemCount: bannerList.length, 
                    pagination: new SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                            activeColor: Colors.white,
                            space: 5,
                            size: 6,
                            activeSize: 8
                        )
                    )
                ) : Container(),
            )
        );
    }
}
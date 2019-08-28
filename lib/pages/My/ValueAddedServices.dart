import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../components/Label.dart';

class ValueAddedServices extends StatefulWidget {
  ValueAddedServices({Key key}) : super(key: key);

  _ValueAddedServicesState createState() => _ValueAddedServicesState();
}

class _ValueAddedServicesState extends State<ValueAddedServices> {

  Widget _item (String imageUrl,String name,int id) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/valueDetail',arguments: {
              "id":id
            });
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
                Container(
                    width: ScreenAdaper.width(335),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                        color: Colors.white
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Stack(
                                children: <Widget>[
                                    AspectRatio(
                                        aspectRatio: 336 / 420,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(ScreenAdaper.width(10)),
                                            ),
                                            child: Image.network(
                                               imageUrl,
                                                fit: BoxFit.cover,
                                            ),
                                        ),
                                    ),
                                    Positioned(
                                        top: ScreenAdaper.width(20),
                                        left: ScreenAdaper.width(20),
                                        child: Label(name),
                                    )
                                ],
                            ),
                        ]
                    )
                ),
            ]
        ),
        );
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('增值服务'),
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: ListView(
            children: <Widget>[
              Wrap(
            spacing: ScreenAdaper.width(14),
            runSpacing: ScreenAdaper.height(14),
            children: <Widget>[
              this._item(
                'http://img.qqzhi.com/upload/img_5_3768788503D3268726448_27.jpg',
                '百合花',
                1
              ),
              this._item(
                'http://file16.zk71.com/File/CorpProductImages/2017/11/26/sucang_6688_0_20171126122445.jpg_w400.jpg', 
                '灵芝', 
                2
              ),
            ],
          )
            ],
          ),
        ),
      ),
    );
  }
}
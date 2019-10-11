import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class BusinessQualification extends StatefulWidget {
  final arguments;
  BusinessQualification({Key key,this.arguments}) : super(key: key);

  _BusinessQualificationState createState() => _BusinessQualificationState(arguments:arguments);
}

class _BusinessQualificationState extends State<BusinessQualification> {
  final arguments;
  _BusinessQualificationState({this.arguments});
  List imgList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.imgList = arguments['imgList'];
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('商家资质'),
      body: SafeArea(
        bottom: true,
        child: Container(
          margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
          padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: ScreenAdaper.width(20),
                crossAxisSpacing: ScreenAdaper.width(20),
            ),
            itemBuilder: (BuildContext context, int index) {
                    return Container(
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: ScreenAdaper.height(30),
                  child: 
                  Image.network(
                    this.imgList[index],
                  ),
                ),
            );
                },
                itemCount: this.imgList.length,
           
          ),
        ),
      )
    );
  }
}
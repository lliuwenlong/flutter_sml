import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
class AboutUs extends StatefulWidget {
  AboutUs({Key key}) : super(key: key);

  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
final HttpUtil http = HttpUtil();
Map data;
bool _isLoading = true;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _getData();
}
_getData() async {
		Map response  = await this.http.get('/api/v1/sysconf/service');
		if(response['code'] == 200){
			setState(() {
			  this.data = response['data'];
        this._isLoading = false;
			});
		}
	}
Widget _listItem (String name,String tips,{isBorder=true,int color=0XFF666666}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white
    ),
    height: ScreenAdaper.height(88),
    padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
    child: Container(
      decoration: BoxDecoration(
        border: isBorder ? Border(bottom: BorderSide(
          color: Color(0XFFd9d9d9),
          width: 1
        )) : null
      ),
      child: Row(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: ScreenAdaper.fontSize(28)
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  tips,
              style:TextStyle(
                color:Color(color),
                fontSize: ScreenAdaper.fontSize(24)
              )
                )
              ],
            ),
          )
        ],
    )

    ),
  );

}


  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('关于我们'),
      body:_isLoading? 
          Container(
              margin: EdgeInsets.only(
                  top: ScreenAdaper.height(200)
              ),
              child: Loading(),
          ):  
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: ScreenAdaper.width(200),
                  height: ScreenAdaper.height(200),
                  margin: EdgeInsets.only(top: ScreenAdaper.height(76)),
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10),left: ScreenAdaper.width(20),right: ScreenAdaper.width(20),bottom: ScreenAdaper.height(10)),
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Image.asset(
                    'images/logo.png'
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                  alignment: Alignment.center,
                  child: Text(
                    '当前版本：V1.0',
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: ScreenAdaper.fontSize(24)
                    ),
                  )
                ),
                SizedBox(height: 40),
                Column(
                  children: <Widget>[
                    this._listItem('联系电话', data['hotline'],color:0xff22b0a1),
                    this._listItem('官网地址', data['website']),
                    this._listItem('服务地址', data['address'],isBorder: false),

                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/introduction');
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                      height: ScreenAdaper.height(88),
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '公司简介',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: ScreenAdaper.fontSize(28)
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(IconData(0xe61e, fontFamily: 'iconfont'), size: ScreenAdaper.fontSize(24, allowFontScaling: true),color: Color(0xffaaaaaa),)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ),
              ],
            ),
        ),
    );
  }
}
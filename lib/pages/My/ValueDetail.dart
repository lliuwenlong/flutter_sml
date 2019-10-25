import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
import '../../pages/My/ValueProductBuy.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../common/Config.dart';
class ValueDetail extends StatefulWidget {
  final Map arguments;
  ValueDetail({Key key, this.arguments}) : super(key: key);

  _ValueDetailState createState() =>
      _ValueDetailState(arguments: this.arguments);
}

class _ValueDetailState extends State<ValueDetail> {
  final Map arguments;
  _ValueDetailState({this.arguments});

  final HttpUtil http = HttpUtil();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getData();
    
  } 
  Map detailData;
  bool _isLoading = true;

  _getData () async {
    Map response = await this.http.get('/api/v1/vp/${arguments['sid']}');
    if ( response['code'] == 200 ) {
      setState(() {
        this.detailData = response['data'];
        this._isLoading = false;
      });
    }
  }
  BuildContext _selfContext;
    _purchase () {
      showModalBottomSheet(
        context: this._selfContext,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenAdaper.width(10)),
            topRight: Radius.circular(ScreenAdaper.width(10)),
          )
        ),
        builder: (BuildContext context) {
            return Purchase(
                prodId:arguments['sid'], 
                price: double.parse(detailData['price']),
                woodSn: arguments['woodSn']
            );
        }
      );
	}
  
  

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    this._selfContext = context;
    return Scaffold(
        appBar: AppBarWidget().buildAppBar('详情'),
        body:SafeArea(
          bottom: true,
            child:  _isLoading? 
            Container(
                margin: EdgeInsets.only(
                    top: ScreenAdaper.height(200)
                ),
                child: Loading(),
            ): 
            ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: ScreenAdaper.height(110)),
                    child:Container(
                        child: InAppWebView(
                            initialUrl: "${Config.WEB_URL}/app/#/valueDetail?sid=${arguments['sid']}",
                        ),
                    ),
                ),
                Positioned(
                  left: 0,
                  bottom: ScreenAdaper.height(20),
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        left: ScreenAdaper.width(30),
                        right: ScreenAdaper.width(30)),
                    height: ScreenAdaper.height(88),
                    child: RaisedButton(
                      child: Text('购买',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenAdaper.fontSize(40))),
                      disabledColor: Color(0XFF86d4ca),
                      splashColor: Color.fromARGB(0, 0, 0, 0),
                      highlightColor: Color(0xff009a8a),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      color: Color(0XFF22b0a1),
                      onPressed: () {
                        this._purchase();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

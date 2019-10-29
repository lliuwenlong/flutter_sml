import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
class ChooseCoupon extends StatefulWidget {
  final arguments;
    ChooseCoupon({Key key, this.arguments}) : super(key: key);
    _ChooseCouponState createState() => _ChooseCouponState(arguments:this.arguments);
}

class _ChooseCouponState extends State<ChooseCoupon> with SingleTickerProviderStateMixin {
    final arguments;
    _ChooseCouponState({this.arguments});
    final HttpUtil http = HttpUtil();
    User _userModel;
	List couponList = [];
	bool _isLoading = true;
	int _isChooseId ;
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
		    _isChooseId = arguments['couponId']!=null?arguments['couponId']:0;
		    _getData();
    }

    _getData () async{
        Map response = await this.http.get('/api/v1/coupon/user',data: {
          'firmId': this.arguments['firmId'],
          'userId': this._userModel.userId,
          "goodsId": this.arguments['goodsId']
        });
        if (response['code'] == 200) {
          setState(() {
              this.couponList =response['data'];
              this._isLoading = false;
          });
        }
    }
    Widget _cardItem (var data) {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(25),
                0,
                ScreenAdaper.width(25),
                0
            ),
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: GestureDetector(
            onTap: (){
              setState(() {
                  _isChooseId = data['id'];
              });
                  Navigator.of(context).pop({
                      'couponId': data['id'],
                      'firmId': arguments['firmId'],
                      'type': arguments['type'],
                      'orderSn': arguments['orderSn'],
                      'amount': arguments['amount'],
                      'worth': data['worth']
                  });
            },
                child: Container(
					decoration: BoxDecoration(
						image: DecorationImage(
							image:_isChooseId == data['id']? AssetImage("images/yes.png"):AssetImage("images/no.png"),
							fit: BoxFit.fill,
						),
        			),
					child: Column(
						children: <Widget>[
							Container(
								padding: EdgeInsets.fromLTRB(
									ScreenAdaper.width(35),
									ScreenAdaper.height(30),
									ScreenAdaper.width(35),
									ScreenAdaper.height(8)
								),
								child: Row(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Column(
											mainAxisAlignment: MainAxisAlignment.start,
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Text('${data['name']}', style: TextStyle(
													fontSize: ScreenAdaper.fontSize(28)
												)),
												SizedBox(height: ScreenAdaper.height(15)),
												Text("有效期至：${data['endDate']}", style: TextStyle(
													fontSize: ScreenAdaper.fontSize(24),
													color: Color(0xff999999)
												))
											],
										),
										Expanded(
											flex: 1,
											child: data['worth']!=null&& int.parse(data['worth'])>0?  Container(
												height: ScreenAdaper.height(80),
												child: Stack(
													children: <Widget>[
														Align(
															alignment: Alignment.bottomRight,
															child: Text("¥ ${data['worth']}", style: TextStyle(
																fontSize: ScreenAdaper.fontSize(44),
																color: Color(0xfffb4135),
															)),
														)
													]
												),
											):Text(''),
										)
									]
								)
							),
							Container(
								padding: EdgeInsets.only(
									left: ScreenAdaper.width(35),
									right: ScreenAdaper.width(35)
								),
								child: Divider(
									color: Color(0XFFffffff),
								)
							),
							Container(
								padding: EdgeInsets.fromLTRB(
									ScreenAdaper.width(35),
									ScreenAdaper.height(0),
									ScreenAdaper.width(35),
									ScreenAdaper.height(20)
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: <Widget>[
									Text("${data['title']}", style: TextStyle(
											fontSize: ScreenAdaper.fontSize(28)
										)),
										Container(
											width: ScreenAdaper.width(136),
											height: ScreenAdaper.height(50),
										),
									]
								)
							)
						]
                	),
				)
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar('选择优惠券'),
            body: SafeArea(
				bottom: true,
				child: this._isLoading? 
					Container(
						margin: EdgeInsets.only(
							top: ScreenAdaper.height(200)
						),
						child: Loading(),
					) : this.couponList.length <= 0 ? NullContent('暂无数据'):
					ListView.builder(
						itemBuilder: (BuildContext context,int index){
							var data = this.couponList[index];
							return _cardItem(data);
						},
						itemCount: this.couponList.length,
					),
            )
        );
    }
}
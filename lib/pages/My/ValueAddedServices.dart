import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../components/Label.dart';
import '../../model/api/my/ValueAddedData.dart';
import '../../common/HttpUtil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/LoadingSm.dart';
import '../../components/NullContent.dart';
class ValueAddedServices extends StatefulWidget {
  final arguments;
  ValueAddedServices({Key key,this.arguments}) : super(key: key);

  _ValueAddedServicesState createState() => _ValueAddedServicesState(arguments:this.arguments);
}

class _ValueAddedServicesState extends State<ValueAddedServices> {
  final arguments;
  final HttpUtil http = HttpUtil();
  int valueAddPage = 1;
  bool isValueLoading = true;
  List valueAddList = [];
  RefreshController _valueAddRefresController = new RefreshController(initialRefresh: false);
  _ValueAddedServicesState({this.arguments});
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._getData(isInit:true);
  }

    _getData({isInit:false}) async {
        print(this.arguments);
      	Map response = await this.http.post('/api/v1/vp/data', data: {
          "pageNO":1,
          "pageSize":10,
          "woodId": widget.arguments["woodId"],
      	});
		if(response['code'] == 200){
			ValueAddedDataModel  res = new ValueAddedDataModel.fromJson(response);
			if (isInit) {
            setState(() {
                valueAddList = res.data;
                isValueLoading = false;
            });
      	} else {
			setState(() {
				valueAddList.addAll(res.data);
			});
            }
		}else{
			Fluttertoast.showToast(
                msg: response["msg"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
				backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
		}

		return response;
    }

	void _onLoading () async{
		setState(() {
            this.valueAddPage++;
        });
        var controller = this._valueAddRefresController;
        var response = await _getData();
        if (response["data"].length == 0) {
            controller.loadNoData();
        } else {
            controller.loadComplete();
        }
	}

	void _onRefresh() async{
        setState(() {
            this.valueAddPage = 1;
        });
        var controller = this._valueAddRefresController;
        final Map res = await _getData(isInit: true);
        controller.refreshCompleted();
    }

  Widget _item (String imageUrl,String name,int id) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/valueDetail',arguments: {
              "sid":id,
              'woodSn': arguments['woodSn']
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
			child: SmartRefresher(
			controller: this._valueAddRefresController,
				enablePullDown: true,
				enablePullUp: true,
				header: WaterDropHeader(),
				footer: ClassicFooter(
					loadStyle: LoadStyle.ShowWhenLoading,
					idleText: "上拉加载",
					failedText: "加载失败！点击重试！",
					canLoadingText: "加载更多",
					noDataText: "没有更多数据",
					loadingText: "加载中"
				),
				onRefresh: _onRefresh,
				onLoading: _onLoading,
				child:this.isValueLoading
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenAdaper.height(200)
                                ),
                                child: Loading(),
                            ):
                            this.valueAddList.length<=0?
                            NullContent('暂无数据'): ListView(
					children: <Widget>[
						Wrap(
							spacing: ScreenAdaper.width(14),
							runSpacing: ScreenAdaper.height(14),
							children: this.valueAddList.map((val){
								return this._item(val.cover, val.name, val.productId);
							}).toList(),
						)
            		],
          		),
		  	)
        ),
      ),
    );
  }
}
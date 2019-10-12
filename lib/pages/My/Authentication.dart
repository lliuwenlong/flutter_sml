import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_sml/common/HttpUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/store/user/User.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);
  _AuthenticationState createState() => _AuthenticationState();
}
  
class _AuthenticationState extends State<Authentication>{

  // 使用TextEditingController来获取内容
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cardController = TextEditingController();
  String _name;
  String _card;
  String  _positiveImage;
  String  _negativeImage;
  File zImage;
  File fImage;
  User _userMedel;
  @override
  void initState() { 
    super.initState();
    // 设置监听
    _nameController.addListener((){
      _name = _nameController.text;
    });
    _cardController.addListener((){
      _card = _cardController.text;
    });
  }
	@override
	void didChangeDependencies() {
	  super.didChangeDependencies();
	  _userMedel = Provider.of<User>(context);
	}
   @override
    void dispose() {
      if (_nameController != null) {
        _nameController.dispose();
      }
    if(_cardController != null){
      _cardController.dispose();
    }
      super.dispose();
    }

  Widget _inputText (String labelName, String hintText, TextEditingController textEditingController) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenAdaper.width(30),
        right: ScreenAdaper.width(30)
      ),
      height: ScreenAdaper.height(86),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorClass.borderColor,
              width: 1
            )
          )
        ),
        child: Row(
          children: <Widget>[
            Text(labelName, style: TextStyle(
              color: ColorClass.titleColor,
              fontSize: ScreenAdaper.fontSize(28)
            )),
            Expanded(
              flex: 1,
              child: TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Color(0XFFaaaaaa),
                    fontSize: ScreenAdaper.fontSize(24)
                  ),
                ),
                controller: textEditingController,
                onChanged: (str){
                  _name = _nameController.text;
                  _card = _cardController.text;
                },
              )
            )
          ]
        )
      )
    );
  }

  Widget _uploadImage (String labelName, File image, {bool isBordor = true}) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenAdaper.width(30),
        right: ScreenAdaper.width(30)
      ),
      height: ScreenAdaper.height(86),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: isBordor ? BorderSide(
              color: ColorClass.borderColor,
              width: 1
            ) : BorderSide.none
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelName, style: TextStyle(
              color: ColorClass.titleColor,
              fontSize: ScreenAdaper.fontSize(28)
            )),
            Row(
              children: <Widget>[
                 Container(
                  width: ScreenAdaper.fontSize(50),
                  height: ScreenAdaper.fontSize(40),
                  child: image == null ? Text("") : Image.file(image, fit: BoxFit.cover)
                ),
                IconButton(
                  icon: Icon(IconData(
                    0Xe63d,
                    fontFamily: "iconfont"
                  )),
                  color: ColorClass.iconColor,
                  iconSize: ScreenAdaper.fontSize(34),
                  onPressed: (){
                    this._checkPopMenu(isBordor);
                  },
                )
              ],
            ),
          ]
        )
      )
    );
  }

  _lunchImg (File imageFile,bool isBordor) async {
      String path = imageFile.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      CompressObject compressObject = CompressObject(
        imageFile:imageFile, //image
        path:'/storage/emulated/0/Android/data/com.itshouyu.sml/files/Pictures', //compress to path
      );
      Luban.compressImage(compressObject).then((_path) async {
        FormData formData = new FormData.from({
            "image": new UploadFileInfo(File(_path), name)
        });
        Dio dio = new Dio();
        var response = await dio.post("http://api.zhongyunkj.cn/oss/img", data: formData);
        if (response.statusCode == 200) {
          if (isBordor) {//正面
              setState(() {
              this._positiveImage = response.data['data'];
            });
          }else{//反面
              this._negativeImage = response.data['data'];
          }
            
        }
      });
  }

  // 弹出弹窗（相机或者相册）
  void _checkPopMenu(bool isBordor) async {
    if (isBordor) {
       // 身份证正面
      	showModalBottomSheet(
			context: context,
			builder: (BuildContext context){
            	return new Column(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						new ListTile(
							leading: new Icon(Icons.photo_camera),
							title: new Text("相机"),
							onTap: () async {
								var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
								this._lunchImg(imageFile,true);
								setState(() {
									this.zImage = imageFile;
								});
								Navigator.pop(context);
							},
						),
						new ListTile(
							leading: new Icon(Icons.photo_library),
							title: new Text("相册"),
							onTap: () async {
								var  imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
								this._lunchImg(imageFile,true);
								setState(() {
									this.zImage = imageFile;
								});
								Navigator.pop(context);
							},
						),
					],
            	);
        	}
      	);
    } else {
      	showModalBottomSheet(
			context: context,
			builder: (BuildContext context){
				return new Column(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						new ListTile(
								leading: new Icon(Icons.photo_camera),
							title: new Text("相机"),
							onTap: () async {
								var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
								this._lunchImg(imageFile,false);
								setState(() {
									this.fImage = imageFile;
								});
								Navigator.pop(context);
							},
						),
						new ListTile(
							leading: new Icon(Icons.photo_library),
							title: new Text("相册"),
							onTap: () async {
								var  imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
								this._lunchImg(imageFile,false);
								setState(() {
									this.fImage = imageFile;
								});
								Navigator.pop(context);
							},
						),
					],
				);
			}
        );
    }
}

  // 保存实名认证数据
  	void _save() async {
		if (_name == null){
			showOnClickSaveToast("请输入姓名");
			return;
		} 
		if (_card == null) {
			showOnClickSaveToast("请输入身份证");
			return;
		} 
		if (!verificationCard(_card)){
			showOnClickSaveToast("请输入正确的身份证");
			return;
		} 
		if (_positiveImage == null){
			showOnClickSaveToast("请上传身份证正面照");
			return;
		} 
		if (_negativeImage == null){
			showOnClickSaveToast("请上传身份证反面照");
			return;
		}
		Map response = await HttpUtil().post("/api/v1/ident", data: {
			"idcard": _card,
			"idcardBack": _positiveImage,
			"idcardFront": _negativeImage,
			"realName": _name,
			"userId": this._userMedel.userId
		});
            if (response["code"] == 200 ) {
                Fluttertoast.showToast(
                    msg: '认证成功',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIos: 1,
                    textColor: Colors.white,
                    fontSize: ScreenAdaper.fontSize(30)
                );
            } else {
                Fluttertoast.showToast(
                    msg: response["msg"],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIos: 1,
                    textColor: Colors.white,
                    fontSize: ScreenAdaper.fontSize(30)
                );
            }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar("实名认证"),
      body: Container(
        child: Column(
          children: <Widget>[
            this._inputText("真实姓名", "请输入姓名", _nameController),
            this._inputText("身份证号", "请输入身份证号", _cardController),
            this._uploadImage("身份证正面", zImage),
            this._uploadImage("身份证反面", fImage, isBordor: false),
            Container(
              margin: EdgeInsets.only(
                top: ScreenAdaper.height(50)
              ),
              height: ScreenAdaper.height(88),
              width: double.infinity,
              padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
              ),
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                ),
                // 点击事件
                onPressed: () {
                  _save();
                },
                child: Text("提交",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenAdaper.fontSize(40)
                  ),
                ),
                color: ColorClass.common,
              ),
            )
          ]
        )
      )
    );
  }

  // 显示吐司
  void showOnClickSaveToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      textColor: Colors.white,
      fontSize: ScreenAdaper.fontSize(30)
    );
  }

  // 验证身份证号码
  bool verificationCard(String card){
    RegExp reg = RegExp(r'(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)');
	return reg.hasMatch(card);
  } 
}
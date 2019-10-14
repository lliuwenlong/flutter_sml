import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
import '../../common/Config.dart';
class UserInfo extends StatefulWidget {
    final Map arguments;
    UserInfo({Key key,this.arguments}) : super(key: key);
    _UserInfoState createState() => _UserInfoState(arguments:this.arguments);
}

class _UserInfoState extends State<UserInfo> {
    final HttpUtil http = HttpUtil();
    User _userModel;
    final Map arguments;
    _UserInfoState({this.arguments});
    File compressedFile;
    String headImage;
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        this.headImage = _userModel.headerImage;
    }

    _changeUserImage(File imageFile) async {
        String path = imageFile.path;
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
		    String imagePath = path.substring(0,path.lastIndexOf("/"));
        CompressObject compressObject = CompressObject(
          imageFile:imageFile, //image
          path:imagePath, //compress to path
        );
      	Luban.compressImage(compressObject).then((_path) async {
			FormData formData = new FormData.from({
				"image": new UploadFileInfo(File(_path), name)
			});
			Dio dio = new Dio();
			var response = await dio.post("${Config.apiUrl}/oss/img", data: formData);
			if (response.statusCode== 200) {
				Map res = await this.http.post('/api/v11/user/reheader',data: {
					"image": response.data['data'],
					"userId": this._userModel.userId
				});
				if(res['code'] == 200){
				setState(() {
					this.headImage = response.data['data'];
				});
					this._userModel.initUser(
						userId: this._userModel.userId,
						userName: this._userModel.userName,
						phone: this._userModel.phone,
						password: this._userModel.password,
						headerImage:response.data['data'],
						nickName: this._userModel.nickName,
						createTime: this._userModel.createTime
					);
					Fluttertoast.showToast(
						msg: '修改成功',
						toastLength: Toast.LENGTH_SHORT,
						gravity: ToastGravity.CENTER,
						timeInSecForIos: 1,
						textColor: Colors.white,
						backgroundColor: Colors.black87,
						fontSize: ScreenAdaper.fontSize(30)
					);
					
				}
			}else{
				Fluttertoast.showToast(
					msg: '头像上传失败',
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.CENTER,
					timeInSecForIos: 1,
					textColor: Colors.white,
					backgroundColor: Colors.black87,
					fontSize: ScreenAdaper.fontSize(30)
				);
			}
      	});
    }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('个人信息'),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenAdaper.height(148),
              padding: EdgeInsets.only(
                  left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('我的头像'),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
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
                                          File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                                          this._changeUserImage(imageFile);
                                          Navigator.pop(context);
                                        },
                                  	),
                                  	new ListTile(
                                        leading: new Icon(Icons.photo_library),
                                        title: new Text("相册"),
                                        onTap: () async {
                                          File  imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                                          this._changeUserImage(imageFile);
                                          Navigator.pop(context);
                                        },
                                  	),
                                ],
                              );
                            }
                          );
                        },
                        child: CircleAvatar(
                          radius: ScreenAdaper.height(43),
                          backgroundColor:Colors.white,
                          backgroundImage: NetworkImage(
                              this.headImage
                          )),
                      ),
                      SizedBox(
                        width: ScreenAdaper.width(20),
                      ),
                      Icon(IconData(0xe61e, fontFamily: 'iconfont'),
                          size: ScreenAdaper.fontSize(24,
                              allowFontScaling: true),
                          color: Color(0xffaaaaaa),),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/changeNickName',
                    arguments: {"nickName": this._userModel.nickName});
              },
              child: Container(
                height: ScreenAdaper.height(86),
                margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                padding: EdgeInsets.only(
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('昵称'),
                    Row(
                      children: <Widget>[
                        Text(
                          this._userModel.nickName,
                          style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: ScreenAdaper.fontSize(24)),
                        ),
                        SizedBox(
                          width: ScreenAdaper.width(20),
                        ),
                        Icon(IconData(0xe61e, fontFamily: 'iconfont'),
                            size: ScreenAdaper.fontSize(24,
                                allowFontScaling: true),color: Color(0xffaaaaaa)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

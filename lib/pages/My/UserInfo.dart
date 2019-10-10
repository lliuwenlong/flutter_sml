import 'dart:io';

// import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_luban/flutter_luban.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
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

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
    }

    _changeUserImage(File image) async {

        String path = image.path;
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
        print(await image.length());
        FormData formData = new FormData.from({
            "image": new UploadFileInfo(image, name)
        });

        Dio dio = new Dio();
        var respone = await dio.post("http://api.zhongyunkj.cn/oss/img", data: formData);
        print(respone);
        if (respone.statusCode == 200) {
            Map res = await this.http.post('/api/v11/user/reheader',data: {
                "image": 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                "userId": this._userModel.userId
            });
            if(res['code'] == 200){
                Fluttertoast.showToast(
                    msg: '修改成功',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    textColor: Colors.white,
                    backgroundColor: Colors.black87,
                    fontSize: ScreenAdaper.fontSize(30)
                );
                this._userModel.initUser(
                    userId: this._userModel.userId,
                    userName: this._userModel.userName,
                    phone: this._userModel.phone,
                    password: this._userModel.password,
                    headerImage:this._userModel.headerImage,
                    nickName: this._userModel.nickName,
                    createTime: this._userModel.createTime
                );
            }
        }
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
                                          var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                                          this._changeUserImage(imageFile);
                                          Navigator.pop(context);
                                        },
                                  	),
                                  	new ListTile(
                                        leading: new Icon(Icons.photo_library),
                                        title: new Text("相册"),
                                        onTap: () async {
                                          var  imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
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
                          backgroundImage: NetworkImage(
                              this._userModel.headerImage
                          )),
                      ),
                      SizedBox(
                        width: ScreenAdaper.width(20),
                      ),
                      Icon(IconData(0xe61e, fontFamily: 'iconfont'),
                          size: ScreenAdaper.fontSize(24,
                              allowFontScaling: true)),
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
                                allowFontScaling: true)),
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

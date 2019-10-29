import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_sml/common/Config.dart';
import 'package:flutter_sml/components/NetLoadingDialog.dart';
import 'package:flutter_sml/model/store/user/User.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'package:provider/provider.dart';
import '../../common/HttpUtil.dart';
import 'dart:ui';

class FriendDynamicsRelease extends StatefulWidget {
    FriendDynamicsRelease({Key key}) : super(key: key);
    _FriendDynamicsReleaseState createState() => _FriendDynamicsReleaseState();
}

class _FriendDynamicsReleaseState extends State<FriendDynamicsRelease> {
    User _userModel;
    TextEditingController controller = TextEditingController.fromValue(
        TextEditingValue(
            text: ""
        )
    );
    List<Asset> resultList;
    List<Asset> images = List<Asset>();

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
    }

    void getImages () async {
        try {
            resultList = await MultiImagePicker.pickImages(
                maxImages: 9,
                enableCamera: true,
                selectedAssets: images,
                cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                materialOptions: MaterialOptions(
                    actionBarColor: "#22b0a1",
                    actionBarTitle: "请选择图片",
                    lightStatusBar: true,
                    allViewTitle: "全部图片",
                    useDetailsView: true,
                    selectCircleStrokeColor: "#000000",
                    selectionLimitReachedText: "最多选择9张图片"
                ),
            );
            setState(() {
                this.images = resultList;
            });
        }
        on Exception catch (e) {
            print(e.toString());
        }
    }

    void deleteImage (Asset val) {
        setState(() {
            this.images.removeAt(this.images.indexOf(val));
        });
    }

    uploadImages () async {
        Dio dio = new Dio();
        List<String> formDataArr = [];
        await Future.wait(resultList.map((item) async {
            String path = await item.filePath;
            String name = path.substring(path.lastIndexOf("/") + 1, path.length);
            CompressObject compressObject = CompressObject(
                imageFile: File(path), //image
                path:'/storage/emulated/0/Android/data/com.itshouyu.sml/files/Pictures', //compress to path
            );
            String _path = await Luban.compressImage(compressObject);
            formDataArr.add(_path);
            return _path;
        }).toList());
        var response = await dio.post("${Config.apiUrl}/oss/imgs", data: FormData.from({
            "images": formDataArr.map((item) {
                String name = item.substring(item.lastIndexOf("/") + 1, item.length);
                return new UploadFileInfo(File(item), name);
            }).toList()
        }));
        if (response.statusCode == 200) {
            return response.data;
        } else {
            Fluttertoast.showToast(
                msg: "图片上传失败",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
            return null;
        }
    }

    void sendMsg () async {
        if (controller.text.isEmpty && images.length == 0) {
            Fluttertoast.showToast(
                msg: "文字图片至少一项不可以为空",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
            return;
        }
        List urls = [];
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
            return LoadingDialog(
                text: "评论提交中",
            );
        });
        if (images.length != 0) {
            Map res = await this.uploadImages();
            if (res["code"] == 200) {
                urls = res["data"]["urls"] != null ? res["data"]["urls"] : [];
            }
        }
        Map response = await HttpUtil().post("/api/v1/circle/msg", params: {
            "content": controller.text,
            "imageUrls": urls.length != 0 ? urls : null,
            "userId": this._userModel.userId
        });
        if (response["code"] == 200) {
            await Navigator.pop(context);
            await Fluttertoast.showToast(
                msg: "发布成功，等待审核",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
            Navigator.pop(context);
        }
    }

    Widget _imageWidget (Asset val) {
        return Container(
            width: ScreenAdaper.width(155),
            height: ScreenAdaper.width(155),
            child: Stack(
                children: <Widget>[
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            width: ScreenAdaper.width(140),
                            height: ScreenAdaper.width(140),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                child: AssetThumb(
                                    asset: val,
                                    width: 140,
                                    height: 140,
                                )
                            )
                        )
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: () {
                                this.deleteImage(val);
                            },
                            child: Container(
                                alignment: Alignment.topLeft,
                                width: ScreenAdaper.width(30),
                                height: ScreenAdaper.width(30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(30))
                                ),
                                child: Icon(
                                    IconData(0xe61f, fontFamily: "iconfont"),
                                    size: ScreenAdaper.fontSize(30),
                                    color: Color(0XFFd4746c)
                                )
                            )
                        )
                    )                                        ]
            )
        );
    }

    Widget _imageUpload () {
        return GestureDetector(
            onTap: () {
                this.getImages();
            },
            child: Container(
                width: ScreenAdaper.width(155),
                height: ScreenAdaper.width(155),
                child: Stack(
                    children: <Widget>[
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                width: ScreenAdaper.width(140),
                                height: ScreenAdaper.width(140),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("images/border.png"),
                                        fit: BoxFit.cover
                                    )
                                ),
                                child: Icon(
                                    IconData(0xe63d, fontFamily: "iconfont"),
                                    color: Color(0XFFaaaaaa),
                                    size: ScreenAdaper.fontSize(50)
                                ),
                            )
                        )                                       ]
                )
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: PreferredSize(
                child:  AppBarWidget().buildAppBar("发布"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(80)),
            ),
            bottomSheet: Container(
                width: double.infinity,
                height: ScreenAdaper.height(108) + MediaQueryData.fromWindow(window).padding.bottom,
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom + ScreenAdaper.height(10),
                    top: ScreenAdaper.height(10),
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(color: Colors.grey[300],offset: Offset(1, 1)),
                        BoxShadow(color: Colors.grey[300], offset: Offset(-1, -1), blurRadius: 1),
                        BoxShadow(color: Colors.grey[300], offset: Offset(1, -1), blurRadius: 1),
                        BoxShadow(color: Colors.grey[300], offset: Offset(-1, 1), blurRadius: 1)
                    ]
                ),
                child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                        this.sendMsg();
                    },
                    color: ColorClass.common,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                    ),
                    child: Text("提交", style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdaper.fontSize(40)
                    ))
                )
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20),
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(88) + ScreenAdaper.height(20)
                ),
                child: ListView(
                    children: <Widget>[
                        TextField(
                            controller: controller,
                            maxLines: 6,
                            decoration: InputDecoration(
                                fillColor: Color(0xFFf5f5f5),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.fromLTRB(
                                    ScreenAdaper.width(30),
                                    ScreenAdaper.width(25),
                                    ScreenAdaper.width(30),
                                    ScreenAdaper.width(25)
                                ),
                                hintText: "想对大家说",
                                hintStyle: TextStyle(
                                    color: ColorClass.subTitleColor,
                                    fontSize: ScreenAdaper.fontSize(28)
                                )
                            ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(20)
                            ),
                            child: Wrap(
                                runSpacing: ScreenAdaper.width(20),
                                spacing: ScreenAdaper.width(20),
                                alignment: WrapAlignment.start,
                                children: <Widget>[
                                    ...this.images.map((val) {
                                        return this._imageWidget(val);
                                    }).toList(),
                                    this.images.length < 9
                                        ? this._imageUpload()
                                        : SizedBox()
                                ]
                            ),
                        )
                    ]
                )
            )
        );
    }
}
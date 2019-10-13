import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/AppBarWidget.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../common/Config.dart';
import '../../common/HttpUtil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/ScreenAdaper.dart';
class Trip extends StatefulWidget {
    @override
    _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
    final HttpUtil http = HttpUtil();
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _getData();
    
    }

    String phone;
    String title;
    _getData () async {
        var response = await this.http.get('/api/v1/trip');
        print(response);
        if (response['code'] == 200) {
            setState(() {
                this.phone = response['data']['showPhone'];
                this.title = response['data']['showTitle'];
            });
        }
    }

    _launchMap() async {
        print(123);
        if (Platform.isAndroid) {
            final url = 'androidamap://myLocation?sourceApplication=softname';
            if (await canLaunch(url)) {
                await launch(url);
            } else {
                throw 'Could not launch $url';
            }
        } else {
            final url = '//myLocation?sourceApplication=applicationName';
            if (await canLaunch(url)) {
                await launch(url);
            } else {
                throw 'Could not launch $url';
            }
        }
        
    }
  @override
    Widget build(BuildContext context) {
        return Container(
            child: Scaffold(
                appBar: AppBarWidget().buildAppBar('神木出行'),
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
                            BoxShadow(color: Colors.black12, blurRadius: 1)
                        ] 
                    ),
                    child: RaisedButton(
                        elevation: 0,
                        onPressed: () async {
                            final url = 'tel:${this.phone}';
                            if (await canLaunch(url)) {
                                await launch(url);
                            } else {
                                Fluttertoast.showToast(
                                    msg: 'Could not launch $url',
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    fontSize: ScreenAdaper.fontSize(30)
                                );
                            }
                        },
                        color: Color(0XFF22b0a1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                        ),
                        child: Text('${this.title} ： ${this.phone}', style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenAdaper.fontSize(40)
                        ))
                    )
                ),
                body: SafeArea(
                  bottom: true,
                  child: Container(
                    child: InAppWebView(
                        initialUrl: '${Config.WEB_URL}/app/#/trip',
                        onWebViewCreated: (InAppWebViewController controller) {
                            InAppWebViewController webView = controller;
                            webView.addJavaScriptHandler('openMap', (args) {
                                this._launchMap();
                            });
                        },
                      )
                ),
                )
            ),
        );
    }
}


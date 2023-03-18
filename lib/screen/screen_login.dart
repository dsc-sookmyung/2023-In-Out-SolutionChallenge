import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:largo/main.dart';
//sh256인증
import 'package:crypto/crypto.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:largo/screen/screen_main.dart';

String? tokenTest = 'null';

Future<String> getShortLink(String screenName) async {
  String dynamicLinkPrefix = 'https://largo.page.link/share';
  final dynamicLinkParams = DynamicLinkParameters(
    uriPrefix: dynamicLinkPrefix,
    link: Uri.parse('$dynamicLinkPrefix/$screenName'),
    androidParameters: const AndroidParameters(
      packageName: 'com.example.largo',
      minimumVersion: 0,
    ),
    iosParameters: const IOSParameters(
      bundleId: 'com.example.largo',
      minimumVersion: '0',
    ),
  );
  final dynamicLink =
  await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

  return dynamicLink.shortUrl.toString();
}
Future<Post> fetchPost() async {
  const APP_REDIRECT_URI = "inandoutlargo.store";

  final url = Uri.parse('http://inandoutlargo.store:8080/oauth2/authorization/google?redirect_uri=$APP_REDIRECT_URI');
  final response =
  await http.get(url);

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return Post.fromJson(json.decode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

class Post {

  final String? token;

  Post({this.token});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      token: json['token'],
    );
  }
}
class ScreenLogin extends StatefulWidget{
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<ScreenLogin> {
  //String response = "";
  //TextEditingController teCon =
  //TextEditingController(text: "https://jsonplaceholder.typicode.com/albums");
  String _status = '';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final VoidCallback? onTap;
    final Widget? child;
    final BorderRadius _baseBorderRadius = BorderRadius.circular(8);

    return MaterialApp(
      theme: ThemeData(
        fontFamily : 'notosanskr',
      ),
      home: Scaffold(
        backgroundColor: Color(0xffFFC977),


        body: Container(
          width :double.infinity,
          margin: EdgeInsets.fromLTRB(23, 0, 23, 23),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 10),
            width: double.infinity,
            child : Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 280, 310, 20),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage('assets/images/largo.png'),
                        fit : BoxFit.fitHeight
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: double.infinity,
                  child: Text(
                    '색다른',
                    style: TextStyle(
                        color : Colors.white,
                        letterSpacing: -0.5,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  width: double.infinity,
                  child: Text(
                    '경험을 찾아서, Largo',
                    style: TextStyle(
                        color : Colors.white,
                        letterSpacing: -0.5,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,),
                ),
                // * 로그인 버튼
                ElevatedButton(
                  onPressed: () async {
                    this.signIn();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                          borderRadius: BorderRadius.circular(50)),
                          primary: Colors.white,
                          minimumSize: Size(double.infinity, 62),
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 18),
                          alignment: Alignment.center,
                          textStyle: const TextStyle(fontSize: 20)
                      ),

                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),

                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: AssetImage('assets/images/google.png'),
                              fit : BoxFit.fitHeight
                          ),
                        ),


                      ),

                      Text(
                        'Google 계정으로 로그인',
                        style: TextStyle(
                            color : Colors.grey,
                            letterSpacing: -0.5,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  width: double.infinity,
                  child: Text(
                    tokenTest!,
                    style: TextStyle(
                        color : Colors.white,
                        letterSpacing: -0.5,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,),
                ),
              ],
            )

          ),



        )
      ),
    );

  }



  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }


  Future<void> signIn() async {
    final url = 'http://inandoutlargo.store:8080/oauth2/authorization/google?redirect_uri=http://inandoutlargo.store:8080/login/oauth2/code/google';

    //inandoutlargo.store
    final callbackUrlScheme = 'largo.page.link';

    try {
      logger.d('log1');
      final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: callbackUrlScheme);
      logger.d('log2');
      final token = Uri.parse(result).queryParameters['token'];
      logger.d('log3');
      tokenTest = token.toString();
      logger.d('log4 - token: ', tokenTest);

    } on PlatformException catch (e) {
      logger.d(e);
    }

    // dynamic link : https://largo.page.link/main

    // final callbackUrlScheme = 'largo.page.link://main';
    //
    // logger.e('log1');
    // final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: callbackUrlScheme);
    // logger.e('log2');
    // final token = Uri.parse(result).queryParameters['token'];
    // tokenTest = token.toString();
    // logger.e(token.toString());


  }

}




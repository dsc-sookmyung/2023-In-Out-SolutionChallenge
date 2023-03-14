import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
String? token = 'null';
class ScreenLogin extends StatefulWidget{
  _LoginScreenState createState() => _LoginScreenState();
}
Future<void> signIn() async {
  // 고유한 redirect uri
  const APP_REDIRECT_URI = "inandoutlargo.store";

  // 백엔드에서 미리 작성된 API 호출
  final url = Uri.parse('http://inandoutlargo.store:8080/oauth2/authorization/google?redirect_uri=$APP_REDIRECT_URI');

  // 백엔드가 제공한 로그인 페이지에서 로그인 후 callback 데이터 반환
  final result = await FlutterWebAuth.authenticate(
      url: url.toString(), callbackUrlScheme: APP_REDIRECT_URI);


  // 백엔드에서 redirect한 callback 데이터 파싱
  final accessToken = Uri
      .parse(result)
      .queryParameters['token'];
  token = accessToken;

}

class _LoginScreenState extends State<ScreenLogin> {
  String response = "";
  TextEditingController teCon =
  TextEditingController(text: "https://jsonplaceholder.typicode.com/albums");


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
                    signIn();
                      // . . .
                      // FlutterSecureStorage 또는 SharedPreferences 를 통한
                      // Token 저장 및 관리
                      // . . .


                    // //_getUrl(teCon.text.toString());
                    // final url = Uri.parse('http://inandoutlargo.store:8080/oauth2/authorization/google?redirect_uri=http://inandoutlargo.store:8080/login/oauth2/code/google');
                    // final reponse = await http.get(url);
                    // var result = await http.post(
                    //     Uri.parse('http://inandoutlargo.store:8080/oauth2/authorization/google?redirect_uri=http://inandoutlargo.store:8080/login/oauth2/code/google'),
                    //     //headers: {'content-type': 'application/json'}
                    // );
                    // if (result.statusCode == 201) {
                    //   _showDialog('Successfully signed up');
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => ScreenMain())
                    //   );}
                    // else{_showDialog('Failed to sign up');}
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
                    token!,
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

}




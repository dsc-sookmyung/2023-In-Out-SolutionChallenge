import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Colors
import 'package:largo/color/themeColors.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart'; // 패키지


class CustomButton extends StatefulWidget {
  final Widget child;

  CustomButton(this.child);

  @override
  _CustomButton createState() => _CustomButton();
}

class _CustomButton extends State<CustomButton> {

  var url = "http://inandoutlargo.store:8080/oauth2/authorize/google?redirect_uri=http://inandoutlargo.store/login/oauth2/code/google";
  var html_body = "";

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(
      _url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _handleGetContact() async {

    final http.Response response = await http.get(
        Uri.encodeFull(url) as Uri
    );
    print("login get await, ${response.statusCode}");

    if (response.statusCode == 200) {
      //print("People API ${response.statusCode} response: ${response.body}");
      //print(response.body);
     this.html_body = response.body.toString();
      print(this.html_body);
      return ;
    }
  }

  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isPressed ? null : [
            BoxShadow(
              color: greyScale6   // 현재 테마 색상 중 밝은 그림자 색으로 변경
            ),
            BoxShadow(
              color: greyScale6,   // 현재 테마 색상 중 밝은 그림자 색으로 변경
            )
          ],
        ),
        child: Center(
          child: widget.child,),
      ),
    );
  }
}

//
// @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20, bottom: 10),
//       child: ElevatedButton(
//         onPressed: () {
//           // Respond to button press
//           print("Login test");
//           _launchUrl();
//         },
//         child: Text(
//           this.title,
//           style: TextStyle(fontWeight: FontWeight.bold, color: greyScale4),
//         ),
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20), // <-- Radius
//           ),
//           backgroundColor: buttonColor,
//           minimumSize: const Size.fromHeight(60), // NEW
//         ),
//       ),
//     );
//   }
// }

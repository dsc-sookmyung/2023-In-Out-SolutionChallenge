import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Colors
import 'package:largo/color/themeColors.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart'; // 패키지


class CustomButton extends StatelessWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomButton(
    this.title, {
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          // Respond to button press
          print("Login test");
          _launchUrl();
        },
        child: Text(
          this.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: greyScale4),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // <-- Radius
          ),
          backgroundColor: buttonColor,
          minimumSize: const Size.fromHeight(60), // NEW
        ),
      ),
    );
  }
}

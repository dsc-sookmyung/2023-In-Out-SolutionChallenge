import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screen/screen_home.dart';
import '../screen/screen_main.dart';

class SearchBar extends StatelessWidget{
  final TextEditingController _textController = new TextEditingController();
  Widget _changedTextWidget = Container();

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.lightGreenAccent,
      child: Column(
        children: [
      Row(
      children: [
      Container(
        child: IconButton(
        color : Color(0xff645F5A),
          onPressed:(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenMain())
            );
        }, icon: Icon(Icons.arrow_back_sharp),),
      ),
      Flexible(
      child: TextField(
        controller: _textController,
        //onSubmitted: sendMsg,
        //onChanged: checkText,
        onSubmitted: (text) {
          sendMsg(text);
        },
        onChanged: (text) {
          checkText(text);
        },
        decoration: InputDecoration(
          // labelText: '텍스트 입력',
          filled: true,
          fillColor: Color(0xfaffc977),

          hintText: '검색할 장소',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width: 3, color: Color(0xfaffc977)),
          ),//외곽선

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width: 3, color: Color(0xfaffc977)),
          ),//외곽선
          suffixIcon: _textController.text.isNotEmpty  //엑스버튼
              ? Container(
            child: IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(
                Icons.cancel,
              ),
              onPressed: () {
                _textController.clear();
              },
            ),
          )
              : null,
        ),
          cursorColor: Colors.black,

        ),
      ),

      GestureDetector(
        onTap: () {
        sendMsg(_textController.text);
        },
        child: Container(
          decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            ),
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xfaffc977),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 4.0,
            ),
          child: Container(
            height: 80,
            width: 50,
            alignment: Alignment.center,
            child: Icon(
              Icons.search_rounded,
            )
        ),
        ),
        ),
      ],
      ),
      // 모델 들어갈 자리
      Expanded(
      child: Container(
        alignment: Alignment.center,
        color: Colors.yellow[200],
        ),
      ),
      ],
      ),
    );
  }
  void sendMsg(String text) {
    _textController.clear();
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      // gravity: ToastGravity.CENTER,  //위치(default 는 아래)
    );
    // api 보내서 화면 띄우기
  }

  void checkText(String text) {
    _changedTextWidget = Container(
      child: Text.rich(
        //Text.rich 와 TextSpan 을 사용하여 다양한 스타일의 텍스트를 한줄에 표시할 수 있게 하는 위젯
        TextSpan(
          text: '=> ', //기본 스타일의 텍스트 (default text style)
          children: [
            TextSpan(
              //TextSpan 위젯을 이용하여 다양한 스타일의 텍스트 사용 가능
              text: '$text',
              style: TextStyle(
                fontSize: 20,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

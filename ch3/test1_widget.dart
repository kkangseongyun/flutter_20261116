//flutter 3.50.0 이전버전까지.. 모든 sdk 위젯을 제공..
// import 'package:flutter/material.dart';
//3.50.0 버전부터 아래의 파일
import 'package:material_ui/material_ui.dart';

void main() => runApp(MyApp());

//StatelessWidget, StatefulWidget을 조합해서 위젯 트리를 구성하는 것인데..
//위젯 계층의 최 상단이 StatefulWidget으로 구성되는 것은 바람직하지 않다.
//화면 re-rendering 능력을 가진 위젯인데.. re-rendering 명령이 내려지면 그 곳부터 모든 하위가 다시 구성
class MyApp extends StatelessWidget {
  //위젯의 화면을 결정하기 위해서 자동 호출.. 리턴되는 내용이 화면 정보..
  @override
    Widget build(BuildContext context) {
      //필수는 아니다. 사실상의 필수
      //앱 전체의 테마설정 + 앱 전체의 navigation 처리..
      //개발자가 만드는 모든 위젯의 root를 MaterialApp으로 선언할 필요는 없다.(가능은 하다.)
      //엡에서 최초로 출력하는 위젯쪽에서 일반적으로 선언..
      return MaterialApp(
        //화면의 기본 구조..
        //화면 단위 위젯에서 사용..
        home: Scaffold(
          appBar: AppBar(
            title: Text('Widget Test'),
          ),
          body: Column(//위젯을 세로방향으로 나열하는 위젯..
            children: [
              MyStatelessWidget(),
              MyStatefulWidget(),
            ],
          ),
        ),
      );
    }
}

class MyStatelessWidget extends StatelessWidget {
  //상태를 못가지는 위젯이라는 것이지. 그렇다고 변수선언이 안되는 것도 아니고. 변수값 변경이 안되는 것도 아니다.
  bool favorited = false;
  int favoriteCount = 10;

  //이벤트 콜백 함수..
  void toggleFavorite(){
    print('Stateless...toggleFavorite');
    if(favorited){
      favoriteCount -= 1;
      favorited = false;
    }else {
      favoriteCount += 1;
      favorited = true;
    }
  }

  @override
    Widget build(BuildContext context) {
      print("Stateless...build...");
      return Row(//위젯을 가로방향으로 나열하는 위젯..
        children: [
          IconButton(
              onPressed: toggleFavorite,
              icon: favorited ? Icon(Icons.star) : Icon(Icons.star_border),
              color: Colors.red,
          ),
          Text('$favoriteCount')
        ],
      );
    }
}

class MyStatefulWidget extends StatefulWidget {
  //위젯의 상태를 결정하기 위해서 자동 호출..
  @override
    State<StatefulWidget> createState() {
      return MyState();
    }
}

class MyState extends State<MyStatefulWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  //이벤트 콜백 함수..
  void toggleFavorite(){
    print('Statelful...toggleFavorite');
    //상태 변수를 단순 변경으로는 re-rendering되지 않는다.
    //setState()로 re-rendering명령 내려야 한다.
    //setState()는 화면 re-rendering명령인데.. re-rendering이 비동기로 실행된다.
    //setState() 함수의 매개변수에 지정한 함수가 먼저 호출되고. 함수가 끝나면
    //re-rendering이 진행된다.
    //상태 변경은 가급적 setState() 안의 함수에서 진행하는 것이 좋다.
    setState(() {
      if(favorited){
        favoriteCount -= 1;
        favorited = false;
      }else {
        favoriteCount += 1;
        favorited = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    print("Stateful...build...");
    return Row(//위젯을 가로방향으로 나열하는 위젯..
      children: [
        IconButton(
          onPressed: toggleFavorite,
          icon: favorited ? Icon(Icons.star) : Icon(Icons.star_border),
          color: Colors.red,
        ),
        Text('$favoriteCount')
      ],
    );
  }
}











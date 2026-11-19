import 'package:flutter_lab/screen/main/dto/DestinationDto.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'widgets/DetailMainWidget.dart';
import 'widgets/DetailNewsWidget.dart';

class DetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailScreen> {
  //탭 버튼 위치 지정, 상태..
  int selectedIndex = 0;

  List<Widget> widgets = [DetailMainWidget(), DetailNewsWidget()];

  //탭 버튼 클릭 이벤트 콜백..
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    //화면 전환시 전달된 데이터 추출..
    var state = GoRouterState.of(context);
    var extra = state.extra as Map<String, dynamic>;

    DestinationDto dto = extra['destination'] as DestinationDto;

    return Scaffold(
      //접히는 부분을 표현하기 위해서는 appbar 사용하면 안된다..
      //화면에 하나의 위젯쪽에서 (ListView) 스크롤이 발생할 때 다른 부분이 같이 접히게(상단)하려면
      //NestedScrollView 사용
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            //접히는 앱바, AppBar는  NestedScrollView의 스크롤 정보를 활용할 준비가 안되어 있다.
            SliverAppBar(
              expandedHeight: 250.0,
              //접혔다가 다시 거꾸로 스크롤 할때 처음부터 나올 것인가 - true, 맨 마지막에 끌려 나올 것인가 - false
              floating: false,
              //접힐때 완전히 사라진다 - false, 한줄은 남긴다. - true
              pinned: true,
              backgroundColor: Color(0xFF3899DD),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(dto.destination, style: TextStyle(color: Colors.white,),),
                titlePadding: EdgeInsets.only(left: 56, bottom: 16,),
                expandedTitleScale: 1.0,//접혔을때 대시 확대되었을때 타이틀 문자열 크기
                background: Image.asset('assets/images/detail_main.jpg', fit: BoxFit.cover,),
              ),
            ),
          ];
        },
        body: widgets.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,//탭 버튼 클릭시 탭 버튼의 애니메이션 효과, fixed(적용 안한다)
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
            backgroundColor: Color(0xFF3899DD),//이 탭 버튼이 클릭되었을 때 bar의 전체 background color
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'News',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber,//현재 선택된 버튼의 색상
        onTap: onItemTapped,
      ),
    );
  }
}

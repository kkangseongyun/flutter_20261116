import 'package:material_ui/material_ui.dart';

import 'dto/EventDto.dart';
import 'widgets/EventCard.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//PageView의 유저 이벤트에 의해 화면이 계속 조정되어야..
class EventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventState();
  }
}

class EventState extends State<EventScreen> {
  //가상의 데이터..
  List<EventDto> datas = [
    EventDto(
      'assets/images/main_australia.jpg',
      '호주',
      '시드니+멜버른+브리즈번',
      '2.14(금) ~ 2.23(일)',
      '20%',
    ),
    EventDto(
      'assets/images/main_georgia.jpg',
      '조지아',
      '나리칼라+게르게티',
      '2.14(금) ~ 2.29(토)',
      '15%',
    ),
    EventDto(
      'assets/images/main_hawaii.jpg',
      '하와이',
      '호놀룰루+마우이',
      '2.15(토) ~ 2.20(목)',
      '20%',
    ),
    EventDto(
      'assets/images/main_mongolia.jpg',
      '몽골',
      '울란바토르+알타이',
      '2.17(월) ~ 2.23(일)',
      '20%',
    ),
    EventDto(
      'assets/images/main_nepal.jpg',
      '네팔',
      '카트만두+ABC',
      '2.21(금) ~ 3.8(일)',
      '15%',
    ),
  ];

  //위젯을 만드는 개발자 함수..
  List<Widget> makePageView() {
    return datas.map((dto) {
      return EventCard(dto);
    }).toList();
  }

  //선언형 UI - 유저 이벤트에 의한 데이터, 위젯에서 직접 획득 불가능하다.
  //XXXController - 이벤트, 이벤트에 의한 데이터를 받을 객체를 따로 준비해서 정보로 설정.. 이곳에 이벤트 발생,
  //이곳에 데이터 유지해줘..
  PageController controller = PageController(
    initialPage: 0, //초기 출력
    viewportFraction: 0.9, //현 화면과 왼쪽, 오른쪽의 화면이 같이 얼마나 나오게 할 것인가?
  );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF3899DD),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,//지정한 controller 설정대로 나오고.. 유저 화면 조정 이벤트가 유지
                children: makePageView(),
              ),
            ),
            SmoothPageIndicator(
              controller: controller,//PageView와 동일 controller 지정, PageView의 이벤트 정보가 전달..
              count: 5,
              effect: WormEffect(
                dotColor: Colors.white,
                activeDotColor: Colors.yellow,
              ),
            ),
            SizedBox(height: 32.0,),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_lab/screen/event/EventScreen.dart';
import 'package:flutter_lab/screen/main/widgets/MainDrawer.dart';
import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'package:material_ui/material_ui.dart';
import './dto/DestinationDto.dart';
import './widgets/DestinationCard.dart';

class MainScreen extends StatelessWidget {
  //화면 구성을 위한 가상의 데이터..
  List<DestinationDto> destinations = [
    DestinationDto(
      id: 1,
      image: 'assets/images/main_swiss.jpg',
      destination: '스위스',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 2,
      image: 'assets/images/main_australia.jpg',
      destination: '호주',
      discount: '최대 10% 할인',
    ),
    DestinationDto(
      id: 3,
      image: 'assets/images/main_georgia.jpg',
      destination: '조지아',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 4,
      image: 'assets/images/main_mongolia.jpg',
      destination: '몽골',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 5,
      image: 'assets/images/main_nepal.jpg',
      destination: '네팔',
      discount: '최대 15% 할인',
    ),
    DestinationDto(
      id: 6,
      image: 'assets/images/main_hawaii.jpg',
      destination: '하와이',
      discount: '최대 5% 할인',
    ),
  ];

  //화면 구성 위젯을 준비하는 개발자 함수..
  List<Widget> makeCard(){
    return destinations.map((destination){
      return DestinationCard(destination);
    }).toList();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('MainScreen'),
        ),
        drawer: MainDrawer(),
        //위젯을 나열하다 화면을 벗어나면 스크롤을 신경쓰지 않았다고 검정/노랑 경고 패펀
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(//화면이 나오는 사각형 영역에 대한 다양한 설정..
                //size, padding, background...
                //size 만을 위한 , padding 만을 위한 별도의 위젯을 사용해도 되고, 한꺼번에 설정하기 위해서
                //Container를 사용해도 되고..
                width: double.infinity,
                //child 의 사이즈를 유지하기는 하지만 최대 300보다 크게 나올수 없다.
                constraints: BoxConstraints(maxHeight: 300),
                child: Image.asset(
                  'assets/images/main_bg_1.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '특가 여행지',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EventScreen()));
                      },
                      label: Text('전체 여행지 보기'),
                      icon: Icon(Icons.arrow_drop_down, size: 20,),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3899DD),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.count(
                  //GridView는 기본이 무한 사이즈 확보. 다른 위젯과 같이 나온다면 너네의 사이즈만 확보하라.
                  shrinkWrap: true,
                  //GridView의 항목 자체 스크롤 지원, 하지마라.. 화면 전체 스크롤에 따르게 할때.
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,//한줄의 cell갯수
                  childAspectRatio: 0.85,//cell의 가로/세로 비율
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,//항목과 항목의 여백..
                  children: makeCard(),
                ),
              ),
              // ElevatedButton(
              //     onPressed: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => MyInfoScreen()));
              //     },
              //     child: Text('Go MyInfo'),
              // )
            ],
          ),
        )

      );

    }
}













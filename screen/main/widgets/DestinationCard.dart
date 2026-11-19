import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import 'package:material_ui/material_ui.dart';

import '../dto/DestinationDto.dart';

class DestinationCard extends StatelessWidget {
  DestinationDto destinationDto;

  DestinationCard(this.destinationDto);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,//그림자 효과.
      //RoundedRectangleBorder(권장), CircleCorder
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        //이벤트 처리 위젯
        //GestureDetector - 유저 터치 이벤트 시에 UI 효과는 없다.
        //InkWell - 유저 터치 이벤트 시에 잉크 번짐 UI 효과 기본 적용해 준다.
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen()));
        },
        //잉크 번짐 효과가 어디까지 진행되어야 하는가?
        //둥근 사각형 카드로 화면이 나오는 경우 아래 설정이 없으면 사각형 모서리 밖까지 잉크 번짐이 진행
        borderRadius: BorderRadius.circular(10),
        child: Padding(//여백 설정 위젯..
          padding: EdgeInsets.all(10.0),//4방향 동일 값.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(//여백 차지..
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      destinationDto.image,
                      width: 150,
                      fit: BoxFit.cover,//이미지위젯의 사이즈와 실제 이미지의 사이즈가 맞지 않았을때 어떻게?
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4,),//공간만 차지하는 위젯
              Text(
                destinationDto.destination,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                destinationDto.discount,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

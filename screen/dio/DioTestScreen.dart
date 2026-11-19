import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DioTestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return DioTestScreenState();
  }
}

class DioTestScreenState extends State<DioTestScreen> {
  List datas = [];

  //ListView에 의해 목록이 출력된 것은 맞지만 스크롤 정보가 ListView객체에서 유지되지 않는다.
  //별도의 controller 를 만들어 추가해서 이 controller에 스크롤 정보 유지하게 해야 한다.
  //필요하다면.. ==> 스크롤 이벤트 처리를 위해서.. ==>페이징 판단할려고..
  ScrollController controller = ScrollController();

  //서버 전달 데이터..
  int page = 1;
  int seed = 1;

  //서버 네트워킹 필요시 호출되는 함수..
  Future<List<dynamic>> dioTest() async {
    try{
      //Dio 객체를 공통 옵션 설정해서 생성..
      var dio = Dio(BaseOptions(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        }
      ));
    }catch(e){
      print(e);
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dio'),
        ),
        body: RefreshIndicator(

          child: ListView.separated(
            controller: controller,
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                    "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}"),
                subtitle: Text(datas[position]["email"]),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child:
                    Image.network(datas[position]["picture"]['thumbnail']),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
        )
    );
  }
}
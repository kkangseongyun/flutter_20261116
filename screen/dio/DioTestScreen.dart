import 'dart:io';

import 'package:dio/dio.dart';
import 'package:material_ui/material_ui.dart';

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
    try {
      //Dio 객체를 공통 옵션 설정해서 생성..
      var dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
          },
        ),
      );

      Response<dynamic> response = await dio.get(
        'https://randomuser.me/api/?seed=${seed}&page=${page}&results=20',
      );
      return response.data['results'];
    } catch (e) {
      print(e);
    }
    return [];
  }

  //scroll event callback..
  scrollListener() async {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      //마지막까지 스크롤이 된 상태..
      //그다음 페이지 데이터를 네트워킹으로 획득 추가..
      page++;
      List result = await dioTest();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    //최초 데이터 획득..
    //await로 데이터를 획득하려면 함수가 async로 선언되어야 한다.
    //라이프사이클 함수다. async 선언 불가하고, await에 의해 함수 실행이 불로킹이 되면 안된다.
    dioTest().then((value) {
      //Future에 실제 데이터가 발생되는 순간 자동 호출..
      setState(() {
        datas = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //refresh 이벤트 콜백..
  Future<void> refresh() async {
    page = 1;
    seed++;
    List result = await dioTest();
    setState(() {
      datas = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dio')),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          controller: controller,
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int position) {
            return ListTile(
              contentPadding: EdgeInsets.all(5),
              title: Text(
                "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}",
              ),
              subtitle: Text(datas[position]["email"]),
              leading: CircleAvatar(
                radius: 25,
                child: ClipOval(
                  child: Image.network(datas[position]["picture"]['thumbnail']),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int position) {
            return Divider(color: Colors.black);
          },
        ),
      ),
    );
  }
}

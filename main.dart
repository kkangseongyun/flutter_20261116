import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import 'package:flutter_lab/screen/dio/DioTestScreen.dart';
import 'package:flutter_lab/screen/event/EventScreen.dart';
import 'package:flutter_lab/screen/main/MainScreen.dart';
import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

//화면 정보 등록..
GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => MainScreen()),
    GoRoute(path: '/myinfo/:id', builder: (context, state){
      //only test...
      //전달된 데이터를 추출해서. 위젯의 생성자 매개변수로 전달..
      String? id = state.pathParameters['id'];//path 의 :과 key를 맞추면 된다.
      String? q = state.uri.queryParameters['q'];
      var extraData = state.extra as Map<String, dynamic>;
      return MyInfoScreen(id: id, q: q, extra: extraData);
    }),
    GoRoute(path: '/event', builder: (context, state) => EventScreen()),
    GoRoute(path: '/detail', builder: (context, state) => DetailScreen()),
    GoRoute(path: '/dio', builder: (context, state) => DioTestScreen()),
  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}



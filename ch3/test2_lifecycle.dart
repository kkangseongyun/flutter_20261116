import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

void main() => runApp(ParentWidget());

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();
  }
}

class ParentState extends State<ParentWidget> {
  int count = 0; //상위에서 관리하는 상태.. 상위에서 변경. 하위에 전파되는 상태..

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lifecycle Test')),
        body: Provider.value(
          //상태를 등록.. 하위에 전파..
          value: count,
          child: Column(
            //child 에 추가된 위젯부터 그 하위 모든 위젯에서 등록한 상태 이용 가능..
            children: [
              Text('I am Parent Widget'),
              ElevatedButton(onPressed: increment, child: Text('increment')),
              ChildWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget() {
    print('ChildWidget...constructor');
  }

  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}

class ChildState extends State<ChildWidget> with WidgetsBindingObserver {
  int count = 0; //상위에서 관리되어, 전파되는 데이터..

  ChildState() {
    print('ChildState...constructor..');
  }

  @override
  void initState() {
    super.initState();
    print('ChildState...initState');
    //B/L 에 의한 데이터로 상태 초기화..
    //이벤트 등록..
    WidgetsBinding.instance.addObserver(this); //앱 라이프사이클.. 이벤트..
  }

  @override
  void dispose() {
    //initState에서 등록한 이벤트, 등록해제...
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ChildState..didChangeDependencies');
    count = Provider.of<int>(context); //상위에서 전파되는 상태값 획득..
  }

  @override
  Widget build(BuildContext context) {
    print('ChildState...build');
    return Text('I am Child, $count');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        print('resume');
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        print('paused');
        break;
    }
  }
}

//최초...
//I/flutter ( 6987): ChildWidget...constructor
// I/flutter ( 6987): ChildState...constructor..
// I/flutter ( 6987): ChildState...initState
// I/flutter ( 6987): ChildState..didChangeDependencies
// I/flutter ( 6987): ChildState...build

//상위 상태 변경시...
//==>상위 상태 변경되었다. 위젯은 불변이다. 하위 위젯은 다시 생성된다.
//상태가 다시 생성되지는 않는다.
//I/flutter ( 6987): ChildWidget...constructor
// I/flutter ( 6987): ChildState..didChangeDependencies
// I/flutter ( 6987): ChildState...build

//앱이 화면에서 사라질때..
//I/flutter ( 6987): paused

//앱이 화면에 나타날때..
//I/flutter ( 6987): resume

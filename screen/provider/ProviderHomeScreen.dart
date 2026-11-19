import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../../provider/TodosModel.dart';
import './widgets/TodoList.dart';
import 'ProviderAddScreen.dart';

class TabScreen extends StatelessWidget {

  List<Todo> todos;
  TabScreen(this.todos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TodoList(this.todos ),
    );
  }
}


class ProviderHomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProviderHomeScreen>
    with SingleTickerProviderStateMixin {

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);//animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.push("/provider-add");
              },
            ),
          ],
          bottom: TabBar(//tab button
            controller: controller,
            tabs: <Widget>[
              Tab(text: 'All'),
              Tab(text: 'Active'),
              Tab(text: 'Complete'),
            ],
          ),
        ),
      body: Consumer<TodosModel>(
        //제네릭 타입으로 명시한 상태가 builder의 두번째 매개변수에 전달..
        builder: (context, model, child){
          return TabBarView(//TabBar의 버튼이 나올때 출력될 화면..
            //TabBar와 TabBarView를 동일 controller로 연결만 하면 이벤트 처리하지 않아도 버튼 클릭시 화면 조정.
            controller: controller,
            children: [
              TabScreen(model.todos),
              TabScreen(model.todos.where((todo) => !todo.completed).toList()),
              TabScreen(model.todos.where((todo) => todo.completed).toList()),
            ],
          );
        },
      ),



    );
  }
}
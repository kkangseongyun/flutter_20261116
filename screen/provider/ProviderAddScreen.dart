import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:provider/provider.dart';
import '../../provider/TodosModel.dart';


class ProviderAddScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<ProviderAddScreen> {
  final controller = TextEditingController();
  bool completedStatus = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onAdd() {
    //유저 입력 데이터 획득..
    String title = controller.text;
    bool completed = completedStatus;
    if(title.isNotEmpty){
      Todo todo = Todo(
        title: title,
        completed: completed
      );
      Provider.of<TodosModel>(context, listen: false).addTodo(todo);
      //자동으로 이전 화면으로 전환..
      context.pop();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(controller: controller),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) => setState(() {
                      completedStatus = checked ?? false;
                    }),
                    title: Text('Complete?'),
                  ),
                  ElevatedButton(
                    child: Text('Add'),
                    onPressed: onAdd,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
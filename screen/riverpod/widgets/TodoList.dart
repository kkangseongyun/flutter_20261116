import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../riverpod/RiverpodNotifier.dart';

//Provider가 위젯내에 선언된 것이 아님으로 앱 전역에서 우리가 원하는 Provider 를 식별해서 이용해야 한다.
//상위 클래스를 변경하거나 Consumer 를 이용하거나.
class TodoListItem extends ConsumerWidget {

  Todo todo;

  TodoListItem(this.todo);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (bool? checked) {
          //앱 전역에 등록된 provider중.. todosProvider의 상태를 저장소에서 획득해서.
          //read() 단발성 획득.. 주로 수정을 위해서..
          ref.read(todosProvider.notifier).toggleTodo(todo);
        },
      ),
      title: Text(todo.title),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          ref.read(todosProvider.notifier).deleteTodo(todo);
        },
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  List<Todo> todos;

  TodoList(this.todos);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTodos(),
    );
  }

  List<Widget> getChildrenTodos() {
    return todos.map((todo) => TodoListItem(todo)).toList();
  }
}

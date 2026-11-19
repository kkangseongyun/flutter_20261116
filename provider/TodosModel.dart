import 'package:material_ui/material_ui.dart';

class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleComleted(){
    completed = !completed;
  }
}

//provider로 공개하는 상태데이터..
class TodosModel extends ChangeNotifier {
  List<Todo> todos = [];
  //상태를 변경하기 위해서 호출되는 함수..
  void addTodo(Todo todo){
    todos.add(todo);
    //하위 위젯 반영 명령..
    notifyListeners();
  }
  void toggleTodo(Todo todo){
    var index = todos.indexOf(todo);
    todos[index].toggleComleted();
    notifyListeners();
  }
  void deleteTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }
}
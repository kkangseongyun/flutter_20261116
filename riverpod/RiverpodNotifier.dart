import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}

//riverpod로 상태 변경(추가, 제거, 수정)시 호출할 함수를 가지는 Notifier
//Notifier의 함수가 호출되어 업무가 진행되고, 발생하는 데이터가 상태..
//List<Todo> : 발생하는 데이터 타입..
class TodosNotifier extends Notifier<List<Todo>> {
  //상태 초기값..
  @override
  List<Todo> build() => [];

  //상태 변경을 위해 호출될 개발자 함수..
  void addTodo(Todo todo){
    //B/L 실행하고..
    //상태를 만들면 된다.
    //state - 내장 객체.. 이전에 발행한 상태 데이터.
    state = [...state, todo];
  }

  void toggleTodo(Todo todo) {
    state = [
      for (final t in state)
        if (t == todo) Todo(title: t.title, completed: !t.completed) else t,
    ];
  }

  void deleteTodo(Todo todo) {
    state = state.where((t) => t != todo).toList();
  }
}

//파일은 상관없다. top level에 등록되면 된다.
//일반적으로 Notifier선언된 파일에서 등록한다.
//Provider : 상수값 등록..
//StateProvider : 상태를 변경하기 위한 별도의 클래스(notifier)가 없는 경우, 상태 값을 바로 변경하면 되는 경우.
//NotifierProvider : 상태를 변경하기 위한 클래스가 있는 경우..
var todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(
  TodosNotifier.new // () => TodosNotifier() 축약형..
);


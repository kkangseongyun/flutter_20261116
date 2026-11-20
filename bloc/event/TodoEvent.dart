import 'package:flutter/cupertino.dart';

import '../state/TodoState.dart';

//Bloc에 발생시킬 이벤트..
//식별만 되면 된다. enum 상수로 만들거나.. 클래스로 만들거나..
abstract class TodosEvent {//모든 이벤트의 상위 타입..

}
class AddTodoEvent extends TodosEvent {
  Todo todo;
  AddTodoEvent(this.todo);
}
class DeleteTodoEvent extends TodosEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}
class ToggleCompletedTodoEvent extends TodosEvent {
  Todo todo;
  ToggleCompletedTodoEvent(this.todo);
}